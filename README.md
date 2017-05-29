# 秒杀业务

> 前言：这是一个基于ssm的项目


## 需求

	1.原则
		单个账号单个商品仅限购买一次（使用主键冲突来实现）

	2.前台展示
		PC端：按单品区分
		倒计时：结束时间和即将开始时间
 
	3.后台设置内容
		开始时间、结束时间（PC端按单品设置、移动端按时间段设置）
		商品库存数量设置

	4.功能逻辑
		库存锁定（拖取商品后，原商品库存减少）
		库存返还（活动结束后，剩余库存返还至原商品）
		同一个用户购买一次后变更立即购买按钮，移除或变灰不可点

 	5.并发优化
		使用redis缓存数据优化,超时的基础上一致性维护
		调整数据库操作语句顺序
		事务SQL在数据库中执行（存储过程），因为本地执行sql速度很快，减少GC的影响

### 使用工具：

	maven（构建项目），git(版本控制工具)，myeclipse(集成开发环境），junit(测试)
	
### 技术栈：

	spring,springmvc,mybatis(框架)，mysql(数据库)
	redis(缓存)，bootstrap(页面),html,css,javascript,jquery（前端）


### 数据库设计
	CREATE TABLE `seckill` (
	  `seckill_id` bigint(20) NOT NULL auto_increment COMMENT '商品库存id',
	  `name` varchar(120) NOT NULL COMMENT '商品名称',
	  `number` int(11) NOT NULL COMMENT '库存数量',
	  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
	  `start_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '秒杀开启时间',
	  `end_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '秒杀结束时间',
	  PRIMARY KEY  (`seckill_id`),
	  KEY `idx_start_time` (`start_time`),
	  KEY `idx_end_time` (`end_time`),
	  KEY `idx_create_time` (`create_time`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀库存表';

	CREATE TABLE `success_killed` (
	  `seckill_id` bigint(20) NOT NULL COMMENT '秒杀商品id',
	  `user_phone` bigint(20) NOT NULL COMMENT '用户手机号',
	  `state` tinyint(4) NOT NULL default '-1' COMMENT '状态标示:-1:无效 0:成功 1:已付款 2:已发货',
	  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
	  PRIMARY KEY  (`seckill_id`,`user_phone`),
	  KEY `idx_create_time` (`create_time`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀成功明细表';

建议养成手写sql语句的习惯，**sql文件在 src/main/sql 中**

## 实现

> localhost:8080/seckill/list  显示秒杀商品列表

> localhost:8080/{seckillId}/detail 显示商品详细


### 秒杀的业务逻辑

## 代码：
		public SeckillExecution executeSeckill(long seckillId, long userPhone,
			String md5) throws SeckillException, RepeatKillException,
			SeckillCloseException {
		if (md5 == null || !md5.equals(getMD5(seckillId))) {
			throw new SeckillException("seckill data rewrite");
		}
		// 执行秒杀逻辑：减库存 + 记录购买行为
		Date nowTime = new Date();

		try {

			// 记录购买行为
			int insertCount = successKilledDao.insertSuccessKilled(seckillId,
					userPhone);
			// 唯一：seckillId, userPhone
			if (insertCount <= 0) {
				// 重复秒杀
				throw new RepeatKillException("seckill repeated");
			} else {
				// 减库存，热点商品竞争
				int updateCount = seckillDao.reduceNumber(seckillId, nowTime);
				if (updateCount <= 0) {
					// 没有更新到记录,秒杀结束
					throw new SeckillCloseException("seckill is closed");
				} else {
					// 秒杀成功
					SuccessKilled successKilled = successKilledDao
							.queryByIdWithSeckill(seckillId, userPhone);
					return new SeckillExecution(seckillId,
							SeckillStatEnum.SUCCESS, successKilled);
				}

			}

		} catch (SeckillCloseException e1) {
			throw e1;
		} catch (RepeatKillException e2) {
			throw e2;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			// 所有编译期异常转化为运行期异常
			throw new SeckillException("seckill inner error:" + e.getMessage());
		}
	}

### 使用枚举表述常量数据字典

## 代码：

	 public enum SeckillStatEnum {
		SUCCESS(1, "秒杀成功"), END(0, "秒杀结束"), REPEAT_KILL(-1, "重复秒杀"), INNER_ERROR(
			-2, "系统异常"), DATA_REWRITE(-3, "数据篡改");

	private int state;

	private String stateInfo;

	SeckillStatEnum(int state, String stateInfo) {
		this.state = state;
		this.stateInfo = stateInfo;
	}

	public int getState() {
		return state;
	}

	public String getStateInfo() {
		return stateInfo;
	}

	public static SeckillStatEnum stateOf(int index) {
		for (SeckillStatEnum state : values()) {
			if (state.getState() == index) {
				return state;
			}
		}
		return null;
	}

	}

### 自定义秒杀异常

 秒杀相关业务异常 三个方面：方法粒度，参数，返回类型(return 类型/异常)

> - RepeatKillException 重复秒杀异常 

> - SeckillCloseException 秒杀关闭异常

> - SeckillException 秒杀异常

### 事务

使用注解控制事务方法的优点

> - 1.开发团队达成一致约定，明确标注事务方法的编程风格

> - 2.保证事务方法的执行时间尽可能短，不要穿插其他网络风格操作RPC/HTTP 请求或者剥离到事务方法外部

> - 3.不是所有的方法都需要事务，如只有一条修改，只读操作不需要事务控制

### 页面倒计时

使用countdown 插件

### 安全

> - 当未开启秒杀时，用户访问不了秒杀的地址

> - 当开启秒杀时，才会暴露秒杀地址，秒杀地址结果MD5加密，同时使用盐值混淆，如果用户用第三方插件或手动修改数据，会抛出异常，阻止用户


**项目源码**：[https://github.com/Tang-Cong/seckill](https://github.com/Tang-Cong/seckill)

**预览**：
![](http://i.imgur.com/WCc71cg.gif)

![](http://i.imgur.com/v1gLQ7f.gif)

![](http://i.imgur.com/ihgU9Ql.gif)

![](http://i.imgur.com/HG0Xaj8.gif)