<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.sdutcm.wm.pojo.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 订单详情</title>
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

		/* 订单项目表格优化 */
		.order-items-table {
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.order-items-table thead {
			background-color: var(--primary-color);
			color: white;
		}

		.order-items-table thead th {
			padding: 15px;
			font-weight: 500;
			font-size: 1.1rem;
			text-align: center;
		}

		.order-items-table tbody tr {
			transition: background-color 0.2s ease;
		}

		.order-items-table tbody tr:hover {
			background-color: var(--light-color);
		}

		.order-items-table tbody td {
			padding: 15px;
			vertical-align: middle;
			border-top: 1px solid #eee;
			font-size: 0.95rem;
		}

		.food-name {
			color: #crimson;
			font-weight: 500;
		}

		.food-price {
			color: #a52a2a;
			font-weight: 500;
		}

		/* 评论区域优化 */
		.comment-card {
			background-color: white;
			border-radius: 12px;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
			padding: 25px;
			margin-top: 30px;
		}

		.comment-card h3 {
			color: var(--primary-color);
			font-size: 1.3rem;
			font-weight: 600;
			margin-top: 0;
			padding-bottom: 15px;
			border-bottom: 1px solid #eee;
			display: inline-block;
		}

		.form-control {
			border-radius: 10px;
			border: 1px solid #ddd;
			transition: border-color 0.3s ease;
		}

		.form-control:focus {
			border-color: var(--primary-color);
			box-shadow: 0 0 0 3px rgba(255, 126, 46, 0.2);
			outline: none;
		}

		.btn-primary {
			background-color: var(--primary-color);
			border-color: var(--primary-color);
			border-radius: 25px;
			padding: 10px 20px;
			transition: all 0.3s ease;
		}

		.btn-primary:hover {
			background-color: #FF6A14;
			transform: translateY(-2px);
			box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
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

			.order-items-table thead th {
				padding: 10px;
				font-size: 1rem;
			}

			.order-items-table tbody td {
				padding: 10px;
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

			.nav-pills>li>a {
				text-align: center;
			}

			.order-items-table {
				display: block;
				overflow-x: auto;
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
		<li><a href="getUserOrder"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">订单详情</h2>

		<!-- 订单项目表格 -->
		<div style="overflow-x: auto;">
			<table class="order-items-table table">
				<thead>
				<tr>
					<th>店铺名</th>
					<th>菜品名</th>
					<th>菜品单价</th>
					<th>数量</th>
					<th>总价</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="oi" items="${orderitem}">
					<tr>
						<td>${oi.shop_name}</td>
						<td class="food-name">${oi.food_name}</td>
						<td class="food-price">${oi.food_price}元/份</td>
						<td>${oi.food_num}份</td>
						<td>${oi.food_total}元</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 只有已完成的订单才显示评论部分 -->
		<c:if test="${order.order_status == 6}">
			<div class="comment-card">
				<h3>订单评价</h3>
				<form action="addComment" method="post" class="form-horizontal">
					<input type="hidden" name="order_on" value="${order.order_on}">
					<input type="hidden" name="shop_id" value="${orderitem[0].shop_id}">
					<div class="form-group">
						<div class="col-sm-12">
							<textarea name="comment_content" class="form-control" rows="4" placeholder="请输入您的评价内容..." required></textarea>
						</div>
					</div>
					<div class="form-group" style="text-align: center;">
						<button type="submit" class="btn btn-primary">
							<i class="fa fa-paper-plane"></i> 提交评价
						</button>
					</div>
				</form>
			</div>
		</c:if>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>