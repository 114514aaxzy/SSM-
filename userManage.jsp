<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 我的信息</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		/* 保持与其他页面一致的颜色方案 */
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

		/* 头部样式优化 - 与其他页面保持一致 */
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

		/* 导航栏优化 - 与其他页面保持一致 */
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

		/* 内容区域优化 */
		.content-container {
			margin-top: 30px;
		}

		.card {
			background-color: white;
			border-radius: 15px;
			box-shadow: 0 4px 16px rgba(0,0,0,0.08);
			padding: 30px;
			margin-bottom: 30px;
		}

		.page-title {
			color: var(--primary-color);
			font-size: 1.8rem;
			font-weight: 600;
			margin-top: 0;
			padding-bottom: 15px;
			border-bottom: 2px solid var(--accent-color);
			display: inline-block;
		}

		/* 用户信息展示优化 */
		.user-info {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
			gap: 20px;
		}

		.info-card {
			background-color: white;
			border-radius: 12px;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
			padding: 25px;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
		}

		.info-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 8px 20px rgba(0,0,0,0.1);
		}

		.info-title {
			font-size: 1.2rem;
			font-weight: 600;
			color: var(--dark-color);
			margin-bottom: 20px;
			padding-bottom: 15px;
			border-bottom: 2px solid var(--accent-color);
			display: inline-block;
		}

		.info-item {
			display: flex;
			align-items: center;
			margin-bottom: 15px;
			padding-bottom: 15px;
			border-bottom: 1px solid #eee;
		}

		.info-item:last-child {
			margin-bottom: 0;
			padding-bottom: 0;
			border-bottom: none;
		}

		.info-label {
			min-width: 80px;
			font-weight: 500;
			color: #666;
		}

		.info-value {
			flex-grow: 1;
			font-size: 1rem;
			color: var(--dark-color);
		}

		.info-action {
			margin-left: auto;
		}

		/* 操作按钮优化 */
		.action-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 20px;
			padding: 8px 15px;
			font-size: 0.9rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 2px 6px rgba(255, 126, 46, 0.2);
		}

		.action-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-1px);
			box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
		}

		.action-btn:focus {
			outline: none;
		}

		.btn-group {
			display: flex;
			gap: 15px;
			margin-top: 30px;
			justify-content: center;
		}

		/* 响应式设计优化 */
		@media (max-width: 992px) {
			.nav-pills {
				display: flex;
				flex-wrap: wrap;
				justify-content: center;
			}

			.nav-pills>li {
				margin-bottom: 5px;
			}
		}

		@media (max-width: 768px) {
			.system-title {
				font-size: 2rem;
			}

			.nav-pills>li>a {
				padding: 10px 15px;
				font-size: 0.9rem;
			}

			.page-title {
				font-size: 1.5rem;
			}

			.info-card {
				padding: 20px;
			}

			.info-label {
				min-width: 70px;
				font-size: 0.95rem;
			}

			.info-value {
				font-size: 0.95rem;
			}
		}

		@media (max-width: 480px) {
			.system-title {
				font-size: 1.8rem;
			}

			.nav-pills {
				flex-direction: column;
				align-items: stretch;
			}

			.nav-pills>li {
				margin-bottom: 5px;
			}

			.nav-pills>li>a {
				text-align: center;
			}

			.user-info {
				grid-template-columns: 1fr;
			}

			.btn-group {
				flex-direction: column;
				gap: 15px;
			}
		}
	</style>
</head>
<body>
<!-- 保持与其他页面一致的头部区域 -->
<div class="header">
	<div class="container">
		<div class="logo-container">
			<img src="static/images/sdutcm.jpg" class="logo-img" width="180" height="140" alt="山东中医药大学校徽">
			<h1 class="system-title">山中医外卖系统</h1>
		</div>
	</div>
</div>

<!-- 优化后的导航栏 -->
<div class="container nav-container">
	<ul id="Tab" class="nav nav-pills" style="justify-content: center; flex-wrap: wrap;">
		<li><a href="showShop"><i class="fa fa-cutlery"></i> 点餐</a></li>
		<li class="active"><a href="userManageInUser"><i class="fa fa-user"></i> 我的信息</a></li>
		<li><a href="getUserOrder"><i class="fa fa-list"></i> 我的订单</a></li>
		<li><a href="getSendOrder"><i class="fa fa-motorcycle"></i> 正在配送订单</a></li>
		<li><a href="getUserComments"><i class="fa fa-comments"></i> 我的评论</a></li>
		<li><a href="toUserHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
		<li><a href="quit"><i class="fa fa-sign-out"></i> 退出</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">个人信息</h2>
		<div class="user-info">
			<div class="info-card">
				<h3 class="info-title">账号信息</h3>
				<div class="info-item">
					<span class="info-label">账号：</span>
					<span class="info-value">${user.user_id}</span>
				</div>
				<div class="info-item">
					<span class="info-label">用户名：</span>
					<span class="info-value">${user.user_name}</span>
				</div>
				<div class="info-item">
					<span class="info-label">性别：</span>
					<span class="info-value">${user.user_sex}</span>
				</div>
				<div class="info-item">
					<span class="info-label">联系方式：</span>
					<span class="info-value">${user.user_phone}</span>
				</div>
			</div>
			<div class="info-card">
				<h3 class="info-title">账户余额</h3>
				<div class="info-item">
					<span class="info-label">当前余额：</span>
					<span class="info-value" style="font-size: 1.2rem; font-weight: 600; color: var(--primary-color);">¥${user.user_balance}</span>
					<div class="info-action">
						<a href="toDeposit">
							<button class="action-btn">
								<i class="fa fa-plus"></i> 充值
							</button>
						</a>
					</div>
				</div>
			</div>
		</div>

		<div class="btn-group">
			<a href="toUpdateUser">
				<button class="action-btn" style="background-color: #4CAF50;">
					<i class="fa fa-pencil"></i> 修改信息
				</button>
			</a>
		</div>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>