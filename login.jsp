<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 登录</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		/* 保持与首页一致的颜色方案 */
		:root {
			--primary-color: #FF7E2E;
			--secondary-color: #FFA542;
			--accent-color: #FFE0B3;
			--text-color: #333;
			--light-color: #F9F9F9;
			--dark-color: #222;
		}

		body {
			font-family: 'Microsoft YaHei', Arial, sans-serif;
			color: var(--text-color);
			background-color: #f8f9fa;
		}

		/* 头部样式优化 - 与首页保持一致 */
		.header {
			background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
			color: white;
			padding: 20px 0;
			box-shadow: 0 4px 12px rgba(0,0,0,0.1);
			position: relative;
			overflow: hidden;
		}

		.header::after {
			content: "";
			position: absolute;
			bottom: -20px;
			left: 0;
			right: 0;
			height: 40px;
			background: #f8f9fa;
			border-radius: 50% 50% 0 0;
		}

		.logo-container {
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.logo-img {
			margin-right: 15px;
			transition: transform 0.3s ease;
		}

		.logo-img:hover {
			transform: scale(1.05);
		}

		.system-title {
			font-size: 2.5rem;
			font-weight: 700;
			text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
			margin: 0;
		}

		/* 导航栏优化 - 与首页保持一致 */
		.nav-container {
			margin-top: -20px;
			z-index: 100;
		}

		.nav-pills>li>a {
			color: var(--dark-color);
			font-size: 1rem;
			font-weight: 500;
			padding: 12px 20px;
			margin-right: 5px;
			border-radius: 20px;
			transition: all 0.3s ease;
			background-color: white;
			box-shadow: 0 2px 8px rgba(0,0,0,0.08);
		}

		.nav-pills>li>a:hover,
		.nav-pills>li>a:focus {
			background-color: var(--primary-color);
			color: white;
			transform: translateY(-2px);
			box-shadow: 0 4px 12px rgba(0,0,0,0.15);
		}

		.nav-pills>li.active>a,
		.nav-pills>li.active>a:hover,
		.nav-pills>li.active>a:focus {
			background-color: var(--primary-color);
			color: white;
			box-shadow: 0 4px 12px rgba(0,0,0,0.15);
		}

		/* 登录表单优化 */
		.login-container {
			margin-top: 50px;
			max-width: 500px;
			margin-left: auto;
			margin-right: auto;
		}

		.login-card {
			background-color: white;
			border-radius: 15px;
			box-shadow: 0 6px 20px rgba(0,0,0,0.08);
			padding: 40px;
			position: relative;
		}

		.login-card::before {
			content: "";
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			height: 10px;
			background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
			border-radius: 15px 15px 0 0;
		}

		.login-title {
			text-align: center;
			color: var(--primary-color);
			font-size: 1.8rem;
			font-weight: 600;
			margin-bottom: 30px;
		}

		.form-group {
			margin-bottom: 25px;
		}

		.form-label {
			display: block;
			font-weight: 500;
			margin-bottom: 8px;
			color: var(--dark-color);
		}

		.form-control {
			height: 45px;
			border-radius: 10px;
			border: 1px solid #ddd;
			padding: 10px 15px;
			transition: border-color 0.3s ease;
		}

		.form-control:focus {
			border-color: var(--primary-color);
			box-shadow: 0 0 0 3px rgba(255, 126, 46, 0.2);
			outline: none;
		}

		.radio-group {
			display: flex;
			flex-wrap: wrap;
			gap: 20px;
			margin-top: 10px;
		}

		.radio-item {
			display: flex;
			align-items: center;
		}

		.radio-item input[type="radio"] {
			display: none;
		}

		.radio-item label {
			position: relative;
			padding-left: 30px;
			cursor: pointer;
			font-weight: normal;
		}

		.radio-item label::before {
			content: "";
			position: absolute;
			left: 0;
			top: 1px;
			width: 20px;
			height: 20px;
			border: 2px solid #ddd;
			border-radius: 50%;
			transition: border-color 0.3s ease;
		}

		.radio-item input[type="radio"]:checked + label::before {
			border-color: var(--primary-color);
		}

		.radio-item label::after {
			content: "";
			position: absolute;
			left: 5px;
			top: 6px;
			width: 10px;
			height: 10px;
			background-color: var(--primary-color);
			border-radius: 50%;
			opacity: 0;
			transition: opacity 0.3s ease;
		}

		.radio-item input[type="radio"]:checked + label::after {
			opacity: 1;
		}

		.login-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 25px;
			padding: 12px 20px;
			width: 100%;
			font-size: 1rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 4px 12px rgba(255, 126, 46, 0.2);
		}

		.login-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-2px);
			box-shadow: 0 6px 16px rgba(255, 126, 46, 0.3);
		}

		.login-btn:focus {
			outline: none;
		}

		/* 响应式设计 */
		@media (max-width: 768px) {
			.system-title {
				font-size: 2rem;
			}

			.login-container {
				padding: 0 20px;
			}

			.login-card {
				padding: 30px;
			}
		}

		/* 表单动画效果 */
		.form-group {
			animation: fadeInUp 0.5s ease forwards;
			opacity: 0;
		}

		.form-group:nth-child(1) { animation-delay: 0.1s; }
		.form-group:nth-child(2) { animation-delay: 0.2s; }
		.form-group:nth-child(3) { animation-delay: 0.3s; }

		@keyframes fadeInUp {
			from {
				opacity: 0;
				transform: translateY(15px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
	</style>
</head>
<body>
<!-- 保持与首页一致的头部区域 -->
<div class="header">
	<div class="container">
		<div class="logo-container">
			<img src="static/images/sdutcm.jpg" class="logo-img" width="180" height="140" alt="山东中医药大学校徽">
			<h1 class="system-title">山中医外卖系统</h1>
		</div>
	</div>
</div>

<!-- 保持与首页一致的导航栏 -->
<div class="container nav-container">
	<ul id="Tab" class="nav nav-pills" style="justify-content: center;">
		<li><a href="toIndex"><i class="fa fa-home"></i> 首页</a></li>
	</ul>
</div>

<!-- 优化后的登录表单 -->
<div class="container login-container">
	<div class="login-card">
		<h2 class="login-title">用户登录</h2>

		<form action="login" method="post">
			<div class="form-group">
				<label class="form-label">身份</label>
				<div class="radio-group">
					<div class="radio-item">
						<input type="radio" id="user" name="person" value="user" required>
						<label for="user"><i class="fa fa-user"></i> 用户</label>
					</div>
					<div class="radio-item">
						<input type="radio" id="seller" name="person" value="seller" required>
						<label for="seller"><i class="fa fa-shopping-bag"></i> 商家</label>
					</div>
					<div class="radio-item">
						<input type="radio" id="rider" name="person" value="rider" required>
						<label for="rider"><i class="fa fa-motorcycle"></i> 骑手</label>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">账号</label>
				<input type="text" name="id" class="form-control" placeholder="请输入账号" required>
			</div>

			<div class="form-group">
				<label class="form-label">密码</label>
				<input type="password" name="pwd" class="form-control" placeholder="请输入密码" required>
			</div>

			<button type="submit" class="login-btn">
				<i class="fa fa-sign-in"></i> 登录
			</button>
		</form>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>