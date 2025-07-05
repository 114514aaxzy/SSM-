<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 店铺管理</title>
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

		/* 店铺信息展示优化 */
		.shop-info {
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

		.shop-id {
			color: #28a745;
			font-weight: 600;
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

			.nav-pills>li>a {
				text-align: center;
			}

			.shop-info {
				grid-template-columns: 1fr;
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
		<li class="active"><a href="#"><i class="fa fa-home"></i> 店铺管理</a></li>
		<li><a href="toRegistShop"><i class="fa fa-plus-circle"></i> 注册店铺</a></li>
		<li><a href="toSellerHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<c:choose>
		<c:when test="${empty shops}">
			<!-- 空状态显示 -->
			<div class="empty-state">
				<i class="fa fa-store empty-icon"></i>
				<p class="empty-text">您还没有注册任何店铺</p>
				<a href="toRegistShop" class="btn btn-primary action-btn">
					<i class="fa fa-plus"></i> 注册新店铺
				</a>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 店铺列表 -->
			<div class="shops-grid">
				<c:forEach items="${shops}" var="shop">
					<div class="shop-card">
						<div class="shop-header">
							<i class="fa fa-store shop-icon"></i>
							<h3 class="shop-name">${shop.shop_name}</h3>
						</div>
						<div class="shop-info-item">
							<i class="fa fa-id-card info-icon"></i>
							<span class="info-label">店铺ID:</span>
							<span class="info-value">${shop.shop_id}</span>
						</div>
						<div class="shop-info-item">
							<i class="fa fa-map-marker info-icon"></i>
							<span class="info-label">地址:</span>
							<span class="info-value">${shop.shop_address}</span>
						</div>
						<div class="shop-info-item">
							<i class="fa fa-phone info-icon"></i>
							<span class="info-label">电话:</span>
							<span class="info-value">${shop.shop_phone}</span>
						</div>
						<div class="shop-actions">
							<a href="foodManage?shop_id=${shop.shop_id}" class="action-btn btn-menu">
								<i class="fa fa-list"></i> 管理菜单
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>