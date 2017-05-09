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
  <title>秒杀列表页</title>
  <!-- Bootstrap -->
  <link rel="stylesheet"  href="/resources/bootstrap/css/bootstrap.min.css">

</head>
<body>
  <div class="container">
  	<div class="panel panel-default">
  		<div class="panel-heading text-center">
  			<h2>秒杀列表</h2>	
  		</div>
  		<div class="panel-body">
  			<table class="table table-hover">
  				<thead>
  					<tr>
  						<th>名称</th>
  						<th>库存</th>
  						<th>开始时间</th>
  						<th>结束时间</th>
  						<th>创建时间</th>
  						<th>详情页</th>
  					</tr>
  				</thead>
  				<tbody>
	  				<c:forEach var="sk" items="${list}">
	  				  	<tr>
	  						<td>${sk.name}</td>
	  						<td>${sk.number}</td>
	  						<td>
	  							<fmt:formatDate value="${sk.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
	  						</td>
	  						<td>
	  							<fmt:formatDate value="${sk.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
	  						</td>
	  						<td>
	  							<fmt:formatDate value="${sk.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
	  						</td>
	  						<td>
	  							<a class="btn btn-info" href="/seckill/${sk.seckillId}/detail" target="_blank">link</a>
	  						</td>
	  					</tr>
	  				</c:forEach>
  				</tbody>
  			</table>
  		</div>
  	</div>
  
  </div>



</body>
  <script type="text/javascript" src="/resources/jQuery/jquery-3.1.1.js"></script>
  <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js"></script>
</html>
