<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 菜单管理</title>
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

		/* 菜品表格优化 */
		.food-table {
			width: 100%;
			border-collapse: collapse;
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.food-table thead {
			background-color: var(--primary-color);
			color: white;
		}

		.food-table th, .food-table td {
			padding: 15px;
			text-align: center;
			vertical-align: middle;
			border-bottom: 1px solid #eee;
		}

		.food-table th {
			font-weight: 600;
			text-transform: capitalize;
		}

		.food-table tbody tr:hover {
			background-color: #f5f5f5;
			transition: background-color 0.2s ease;
		}

		.food-id {
			color: #28a745;
			font-weight: 600;
		}

		.food-name {
			color: #e74c3c;
			font-weight: 500;
		}

		.food-price {
			color: #ff9800;
			font-weight: 500;
		}

		/* 菜品图片优化 */
		.food-image {
			width: 160px;
			height: 90px;
			object-fit: cover;
			border-radius: 8px;
			transition: transform 0.3s ease;
		}

		.food-image:hover {
			transform: scale(1.05);
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

		/* 响应式设计优化 */
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

			.food-table th, .food-table td {
				padding: 10px;
				font-size: 0.95rem;
			}

			.food-image {
				width: 120px;
				height: 70px;
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

			.food-table {
				display: block;
				overflow-x: auto;
			}

			.food-image {
				width: 100px;
				height: 60px;
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
	<ul id="Tab" class="nav nav-pills" style="justify-content: center;">
		<li class="active"><a href="#adminPI"><i class="fa fa-list"></i> 菜单管理</a></li>
		<li><a href="toSellerHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">菜品管理</h2>

		<div class="table-responsive">
			<table class="food-table">
				<thead>
				<tr>
					<th>菜品号</th>
					<th>菜品图片</th>
					<th>菜品名</th>
					<th>菜品价格</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${foodlist}">
					<tr>
						<td class="food-id">${list.food_id}</td>
						<td>
							<img src="${pageContext.request.contextPath}/static/images/food/${list.food_id}.jpg"
								 class="food-image"
								 alt="${list.food_name}">
						</td>
						<td class="food-name">${list.food_name}</td>
						<td class="food-price">${list.food_price}元/份</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<div style="text-align: center; margin-top: 30px;">
			<a href="toAddFood">
				<button type="button" class="action-btn">
					<i class="fa fa-plus"></i> 添加新菜品
				</button>
			</a>
		</div>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>