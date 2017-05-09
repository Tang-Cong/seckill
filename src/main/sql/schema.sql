--数据库初始化脚本

create database seckill;

use seckill;

--秒杀库存表
create table seckill(
`seckill_id` bigint NOT NULL auto_increment	COMMENT '商品库存id',
`name` varchar(120) NOT NULL COMMENT '商品名称',
`number` int NOT NULL COMMENT '库存数量',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`start_time` timestamp NOT NULL COMMENT '秒杀开启时间',
`end_time` timestamp NOT NULL COMMENT '秒杀结束时间',
PRIMARY KEY (seckill_id),
key idx_start_time(start_time),
key idx_end_time(end_time),
key idx_create_time(create_time)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='秒杀库存表';

insert into seckill(name,number,start_time,end_time)
values
	('1000元秒杀iPhone6',100,'2017-03-09 00:00:00','2017-03-10 00:00:00'),
	('500元秒杀iPad2',200,'2017-03-09 00:00:00','2017-03-10 00:00:00'),
	('300元秒杀小米4',300,'2017-03-09 00:00:00','2017-03-10 00:00:00'),
	('200元秒杀红米note',400,'2017-03-09 00:00:00','2017-03-10 00:00:00');
	
--秒杀成功明细表
--用户登录相关认证相关的信息
create table success_killed(
`seckill_id` bigint NOT NULL COMMENT '秒杀商品id',
`user_phone` bigint NOT NULL COMMENT '用户手机号',
`state` tinyint NOT NULL DEFAULT -1 COMMENT '状态标示:-1:无效 0:成功 1:已付款 2:已发货',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
PRIMARY KEY (seckill_id,user_phone),/*联合主键*/
key idx_create_time(create_time)
)ENGINE=InnoDB DEFAULT charset=utf8 COMMENT='秒杀成功明细表';

--为什么手写DDL
--记录每次上线的DDL修改
--方便他人观看
--上线新的版本
ALTER TABLE seckill
DROP INDEX idx_create_time,
ADD index idx_c_s(start_time,create_time);

	