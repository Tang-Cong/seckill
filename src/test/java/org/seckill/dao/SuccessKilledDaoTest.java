package org.seckill.dao;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.SuccessKilled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SuccessKilledDaoTest {
	//注入DAO实现依赖
	@Resource
	private SuccessKilledDao successKilledDao;
	
//	@Test
//	public void testInsertSuccessKilled() throws Exception{
//		Long id= 1001L; 
//		long userPhone=18797821234L;
//		int insertCount = successKilledDao.insertSuccessKilled(id, userPhone);
//		System.out.println(insertCount);
//	}
	
	@Test
	public void testQueryByIdWithSeckill() {
		Long id= 1001L; 
		long userPhone=18797821234L;
		SuccessKilled successKilled = successKilledDao.queryByIdWithSeckill(id, userPhone);
		System.out.println(successKilled);
		System.out.println(successKilled.getSeckill());
	} 
}
