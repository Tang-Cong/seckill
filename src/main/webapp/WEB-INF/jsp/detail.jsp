<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>秒杀详情页</title>
  <!-- Bootstrap -->
  <link rel="stylesheet"  href="/resources/bootstrap/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
  	<div class="panel panel-default text-center">
  		<div class="panel-heading">
  			<h1>${seckill.name}</h1>
  		</div>

  		<div class="panel-body">
			<h2 class="text-danger">
				<!-- 显示time图标 -->
				<span class="glyphicon glyphicon-time"></span>
				<!-- 展示倒计时 -->
				<span class="glyphicon" id="seckill-box"></span>
			</h2>
  		</div>
  	</div>
  </div>
<!-- 登录弹出层，输入电话 -->
<div id="killPhoneModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title text-center">
					<span class="glyphicon glyphicon-phone"></span>秒杀电话：
				</h3>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xs-8 col-xs-offset-2">
						<input type="text" name="killPhone" id="killPhoneKey"
								placeholder="填手机号^o^" class="form-control">
					</div>
				</div>
			</div>
			
			<div class="modal-footer">
				<!-- 验证信息 -->
				<span id="killPhoneMessage" class="glyphicon"></span>
				<button type="button" id="killPhoneBtn" class="btn-success">
					<span class="glyphicon glyphicon-phone"></span>
					Submit
				</button>
			</div>
		
		</div>
	</div>
</div>

</body>
  <script type="text/javascript" src="/resources/jQuery/jquery-3.1.1.js"></script>
  <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>
  <script type="text/javascript" src="/resources/js/jquery.countdown.min.js"></script>
  <script type="text/javascript" src="/resources/js/seckill.js"></script>
  <script type="text/javascript">
	$(function(){
		seckill.detail.init({ 
			//使用EL表达式传出参数
			seckillId : ${seckill.seckillId},
			startTime : ${seckill.startTime.time},
			endTime : ${seckill.endTime.time}
		});
	});
  </script>
</html>

