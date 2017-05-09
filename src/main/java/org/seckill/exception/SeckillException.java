package org.seckill.exception;

/**
 * 秒杀相关业务异常 三个方面：方法力度，参数，返回类型(return 类型/异常)
 * 
 * @author asus
 *
 */
public class SeckillException extends RuntimeException {

	public SeckillException(String message, Throwable cause) {
		super(message, cause);
	}

	public SeckillException(String message) {
		super(message);
	}

}
