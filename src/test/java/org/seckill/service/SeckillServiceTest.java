package org.seckill.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
// 告诉junit spring配置文件
@ContextConfiguration({ "classpath:spring/spring-dao.xml",
		"classpath:spring/spring-service.xml" })
public class SeckillServiceTest {
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	// 注入service实现依赖
	@Autowired
	private SeckillService seckillService;

	// @Test
	// public void testGetSeckillList() throws Exception{
	// List<Seckill> list = seckillService.getSeckillList();
	// logger.info("list={}",list);
	// }
	//
	// @Test
	// public void testGetById() throws Exception{
	// long id = 1000;
	// Seckill seckill = seckillService.getById(id);
	// logger.info("seckill={}", seckill);
	// }

	// 测试代码完整逻辑
	// @Test
	// public void testExportSeckillUrl() throws Exception {
	// long id = 1000;
	// Exposer exposer = seckillService.exportSeckillUrl(id);
	// if (exposer.isExposed()) {
	// long phone = 18798765432L;
	// String md5 = exposer.getMd5();
	// try {
	// SeckillExecution execution = seckillService.executeSeckill(id,
	// phone, md5);
	// logger.info("result={}", execution);
	// } catch (SeckillCloseException e1) {
	// logger.error(e1.getMessage());
	// } catch (RepeatKillException e2) {
	// logger.error(e2.getMessage());
	// }
	// } else
	// // 秒杀未开启
	// logger.warn("exposer={}", exposer);
	// // md5=4bbf29d893751ecb1da2ccee812672b4
	// }

	@Test
	public void executeSeckillProcedure() {
		long seckillId = 1003;
		long phone = 13680111011L;
		Exposer exposer = seckillService.exportSeckillUrl(seckillId);
		if (exposer.isExposed()) {
			String md5 = exposer.getMd5();
			SeckillExecution execution = seckillService
					.executeSeckillProcedure(seckillId, phone, md5);
			logger.info(execution.getStateInfo());
		}

	}

	// @Test
	// public void testExecuteSeckill() throws Exception{
	// long id = 1000;
	// long phone=18798765432L;
	// String md5 = "4bbf29d893751ecb1da2ccee812672b4";
	// try {
	// SeckillExecution execution = seckillService.executeSeckill(id, phone,
	// md5);
	// logger.info("result={}", execution);
	// }catch(SeckillCloseException e1){
	// logger.error(e1.getMessage());
	// }
	// catch(RepeatKillException e2){
	// logger.error(e2.getMessage());
	// }
	//
	// }

}
