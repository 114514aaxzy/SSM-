<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>注册失败</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/jquery-1.8.0.min.js"></script>
  </head>
  
  <body>
	<h1 style="text-align:center;color:#FF8000;"><img src="static/images/sdutcm.jpg" width="200" height="160"></img>山中医外卖系统</h1>
		
		<div class="container">
			<ul id="Tab" class="nav nav-pills" style="font-size:15pt">
				<li><a href="tologin">返回</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="alert alert-danger">
				<h2>注册失败</h2>
				<p>${message != null ? message : '注册过程中发生错误，请重试'}</p>
			</div>
			<div>
				<a href="userCheck" class="btn btn-primary">返回注册</a>
				<a href="toIndex" class="btn btn-default">返回首页</a>
			</div>
		</div>
  </body>
</html>
