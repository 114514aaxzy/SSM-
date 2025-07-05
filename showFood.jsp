<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 菜品列表</title>
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

		/* 菜品列表优化 */
		.food-list {
			display: grid;
			grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
			gap: 20px;
		}

		.food-item {
			background-color: white;
			border-radius: 15px;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
			overflow: hidden;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			display: flex;
			flex-direction: column;
		}

		.food-item:hover {
			transform: translateY(-5px);
			box-shadow: 0 8px 20px rgba(0,0,0,0.1);
		}

		.food-image {
			position: relative;
			overflow: hidden;
			height: 180px;
		}

		.food-image img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			transition: transform 0.5s ease;
		}

		.food-item:hover .food-image img {
			transform: scale(1.1);
		}

		.food-content {
			padding: 15px;
			flex-grow: 1;
			display: flex;
			flex-direction: column;
		}

		.food-name {
			font-size: 1.2rem;
			font-weight: 500;
			color: var(--dark-color);
			margin-bottom: 8px;
		}

		.food-price {
			font-size: 1.1rem;
			font-weight: 500;
			color: var(--primary-color);
			margin-bottom: 15px;
		}

		.food-actions {
			margin-top: auto;
		}

		/* 加入购物车按钮优化 */
		.add-to-cart-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 25px;
			padding: 10px 20px;
			width: 100%;
			font-size: 1rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 4px 12px rgba(255, 126, 46, 0.2);
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.add-to-cart-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-2px);
			box-shadow: 0 6px 16px rgba(255, 126, 46, 0.3);
		}

		.add-to-cart-btn:focus {
			outline: none;
		}

		.add-to-cart-btn i {
			margin-right: 8px;
		}

		/* 空状态提示 */
		.empty-state {
			text-align: center;
			padding: 50px 0;
			color: #999;
		}

		.empty-state i {
			font-size: 3rem;
			margin-bottom: 20px;
			color: #ddd;
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

			.food-list {
				grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
			}

			.food-item {
				flex-direction: row;
				height: 120px;
			}

			.food-image {
				height: 100%;
				width: 120px;
			}

			.food-content {
				padding: 10px 15px;
			}

			.food-name {
				font-size: 1.1rem;
				margin-bottom: 5px;
			}

			.food-price {
				font-size: 1rem;
				margin-bottom: 10px;
			}

			.add-to-cart-btn {
				padding: 8px 15px;
				font-size: 0.9rem;
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

			.food-list {
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
		<li><a href="showShop"><i class="fa fa-arrow-left"></i> 返回</a></li>
		<li><a href="myCart"><i class="fa fa-shopping-cart"></i> 我的购物车</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">选择菜品</h2>

		<div class="food-list">
			<c:forEach var="list" items="${foodlist}">
				<div class="food-item">
					<div class="food-image">
						<img src="${pageContext.request.contextPath}/static/images/food/${list.food_id}.jpg" alt="${list.food_name}">
					</div>
					<div class="food-content">
						<h3 class="food-name">${list.food_name}</h3>
						<p class="food-price">¥${list.food_price}</p>
						<div class="food-actions">
							<a href="addCart?shop_id=${list.shop_id}&food_id=${list.food_id}">
								<button class="add-to-cart-btn">
									<i class="fa fa-plus-circle"></i> 加入购物车
								</button>
							</a>
						</div>
					</div>
				</div>
			</c:forEach>
			<c:if test="${empty foodlist}">
				<div class="empty-state" style="grid-column: 1 / -1;">
					<i class="fa fa-cutlery"></i>
					<p>暂无菜品信息</p>
				</div>
			</c:if>
		</div>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>