<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 我的购物车</title>
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

		/* 购物车表格优化 */
		.cart-table {
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.cart-table thead {
			background-color: var(--primary-color);
			color: white;
		}

		.cart-table thead th {
			padding: 15px;
			font-weight: 500;
			font-size: 1.1rem;
		}

		.cart-table tbody tr {
			transition: background-color 0.2s ease;
		}

		.cart-table tbody tr:hover {
			background-color: var(--light-color);
		}

		.cart-table tbody td {
			padding: 15px;
			vertical-align: middle;
			border-top: 1px solid #eee;
		}

		.food-name {
			font-weight: 500;
			color: var(--dark-color);
		}

		.food-price, .cart-total {
			color: var(--primary-color);
			font-weight: 500;
		}

		/* 数量操作按钮优化 */
		.quantity-control {
			display: flex;
			align-items: center;
			justify-content: center;
			gap: 10px;
		}

		.quantity-btn {
			width: 30px;
			height: 30px;
			border: 1px solid #ddd;
			border-radius: 50%;
			background-color: white;
			color: var(--text-color);
			cursor: pointer;
			display: flex;
			align-items: center;
			justify-content: center;
			transition: all 0.3s ease;
		}

		.quantity-btn:hover {
			background-color: var(--light-color);
			border-color: var(--primary-color);
			color: var(--primary-color);
		}

		.quantity-btn:active {
			transform: scale(0.95);
		}

		.quantity-value {
			min-width: 30px;
			text-align: center;
			font-weight: 500;
		}

		/* 结算栏优化 */
		.checkout-bar {
			background-color: var(--light-color);
			padding: 15px 20px;
			border-radius: 10px;
			margin-top: 20px;
			display: flex;
			justify-content: space-between;
			align-items: center;
			border: 1px solid var(--accent-color);
		}

		.total-price {
			font-size: 1.2rem;
			font-weight: 700;
			color: var(--primary-color);
		}

		/* 结算按钮优化 */
		.checkout-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 25px;
			padding: 12px 30px;
			font-size: 1rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 4px 12px rgba(255, 126, 46, 0.2);
			display: flex;
			align-items: center;
			justify-content: center;
			gap: 8px;
		}

		.checkout-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-2px);
			box-shadow: 0 6px 16px rgba(255, 126, 46, 0.3);
		}

		.checkout-btn:focus {
			outline: none;
		}

		/* 空状态提示 */
		.empty-cart {
			text-align: center;
			padding: 50px 0;
			color: #999;
		}

		.empty-cart i {
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

			.cart-table thead th {
				padding: 10px;
				font-size: 1rem;
			}

			.cart-table tbody td {
				padding: 10px;
				font-size: 0.9rem;
			}

			.checkout-btn {
				padding: 10px 20px;
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

			.checkout-bar {
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
		<li><a href="toUserHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">我的购物车</h2>

		<c:if test="${not empty cartlist}">
			<div class="cart-table">
				<table class="table">
					<thead>
					<tr>
						<th>菜品</th>
						<th>单价</th>
						<th>数量</th>
						<th>总价</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${cartlist}" var="list">
						<tr>
							<td class="food-name">${list.food_name}</td>
							<td class="food-price">¥${list.food_price}</td>
							<td>
								<div class="quantity-control">
									<a href="changeCart?cart_id=${list.cart_id}&param=minus">
										<button class="quantity-btn">-</button>
									</a>
									<span class="quantity-value">${list.cart_num}</span>
									<a href="changeCart?cart_id=${list.cart_id}&param=add">
										<button class="quantity-btn">+</button>
									</a>
								</div>
							</td>
							<td class="cart-total">¥${list.cart_total}</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="3" style="font-weight: 600; color: var(--dark-color);">总计：</td>
						<td class="cart-total" style="font-size: 1.2rem;">¥${totalprice}</td>
					</tr>
					</tbody>
				</table>
			</div>

			<div class="checkout-bar">
				<span class="total-price">总计：¥${totalprice}</span>
				<a href="account">
					<button class="checkout-btn">
						<i class="fa fa-credit-card"></i> 结算
					</button>
				</a>
			</div>
		</c:if>

		<c:if test="${empty cartlist}">
			<div class="empty-cart">
				<i class="fa fa-shopping-cart"></i>
				<p>您的购物车还是空的</p>
				<p><a href="showShop" style="color: var(--primary-color); text-decoration: underline;">去点餐</a> 逛逛吧</p>
			</div>
		</c:if>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>