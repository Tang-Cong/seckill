package org.seckill.dao;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 配置spring 和 junit 整合，junit 启动时加载spring IOC容器
 * @author asus
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
//告诉junit spring配置文件
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SeckillDaoTest {
	//注入DAO实现依赖
	@Autowired 
	private SeckillDao seckillDao;

/*	@Test
	public void testQueryById()  throws Exception{
		long id = 1000;
		Seckill seckill = seckillDao.queryById(id);
		System.out.println(seckill.getName());
		System.out.println(seckill);
	}
	*/
	
	//List<Seckill> queryAll(int offet,int limit);-->arg0,arg1
	//java没有保存形参的记录
/*	@Test
	public void testQueryAll()  throws Exception{
		List<Seckill> seckills = seckillDao.queryAll(0, 100);
		for(Seckill s:seckills){
			System.out.println(s);
		}
	}*/
	
	@Test
	public void testReduceNumber()  throws Exception{
		Date killTime = new Date();
		int updateCount = seckillDao.reduceNumber(1000L, killTime);
		System.out.println(updateCount);
	}

	

}
