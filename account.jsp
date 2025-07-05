<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 订单支付</title>
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

		/* 订单表格优化 */
		.order-table {
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.order-table thead {
			background-color: var(--primary-color);
			color: white;
		}

		.order-table thead th {
			padding: 15px;
			font-weight: 500;
			font-size: 1.1rem;
			text-align: center;
		}

		.order-table tbody tr {
			transition: background-color 0.2s ease;
		}

		.order-table tbody tr:hover {
			background-color: var(--light-color);
		}

		.order-table tbody td {
			padding: 15px;
			vertical-align: middle;
			border-top: 1px solid #eee;
			font-size: 0.95rem;
		}

		.total-row {
			font-weight: 600;
			color: var(--primary-color);
			font-size: 1.1rem;
		}

		/* 支付表单优化 */
		.payment-form {
			max-width: 500px;
			margin: 30px auto 0;
		}

		.form-group {
			margin-bottom: 20px;
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

		.form-label {
			font-weight: 500;
			color: var(--dark-color);
			margin-bottom: 8px;
		}

		.pay-btn {
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
			display: flex;
			align-items: center;
			justify-content: center;
			gap: 8px;
		}

		.pay-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-2px);
			box-shadow: 0 6px 16px rgba(255, 126, 46, 0.3);
		}

		.pay-btn:focus {
			outline: none;
		}

		/* 表单验证提示 */
		.error-message {
			color: #dc3545;
			font-size: 0.9rem;
			margin-top: 5px;
			display: none;
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

			.order-table thead th {
				padding: 10px;
				font-size: 1rem;
			}

			.order-table tbody td {
				padding: 10px;
				font-size: 0.9rem;
			}

			.payment-form {
				max-width: 100%;
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
		<li><a href="showShop"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">确认订单</h2>

		<!-- 订单表格 -->
		<div style="overflow-x: auto;">
			<table class="order-table table">
				<thead>
				<tr>
					<th>菜品</th>
					<th>单价</th>
					<th>数量</th>
					<th>总价</th>
					<th>实付金额</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${cartlist}">
					<tr>
						<td>${list.food_name}</td>
						<td>${list.food_price}元/份</td>
						<td>${list.cart_num}份</td>
						<td>${list.cart_total}元</td>
						<td>${list.cart_total}元</td>
					</tr>
				</c:forEach>
				<tr class="total-row">
					<td colspan="4">总计：</td>
					<td>${totalprice}元</td>
				</tr>
				</tbody>
			</table>
		</div>

		<!-- 支付表单 -->
		<form class="payment-form" action="payOrder" method="post" onsubmit="return verification()">
			<div class="form-group">
				<label for="order_address" class="form-label">收货地址</label>
				<input type="text" id="order_address" name="order_address" class="form-control" placeholder="请输入收货地址" required>
				<div id="address-error" class="error-message">收货地址不能为空</div>
			</div>

			<div class="form-group">
				<button type="submit" class="pay-btn">
					<i class="fa fa-credit-card"></i> 确认支付
				</button>
			</div>
		</form>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function verification() {
		var address = document.getElementById("order_address");
		var errorMsg = document.getElementById("address-error");

		if (address.value.trim() === "") {
			errorMsg.style.display = "block";
			address.classList.add("is-invalid");
			return false;
		} else {
			errorMsg.style.display = "none";
			address.classList.remove("is-invalid");
			return true;
		}
	}

	// 输入框获得焦点时隐藏错误提示
	document.getElementById("order_address").addEventListener("focus", function() {
		document.getElementById("address-error").style.display = "none";
		this.classList.remove("is-invalid");
	});
</script>
</body>
</html>