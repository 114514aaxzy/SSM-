<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 点餐</title>
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

		/* 店铺列表表格优化 */
		.shop-table {
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.shop-table thead {
			background-color: var(--primary-color);
			color: white;
		}

		.shop-table thead th {
			padding: 15px;
			font-weight: 500;
			font-size: 1.1rem;
		}

		.shop-table tbody tr {
			transition: background-color 0.2s ease;
		}

		.shop-table tbody tr:hover {
			background-color: var(--light-color);
		}

		.shop-table tbody td {
			padding: 15px;
			vertical-align: middle;
			border-top: 1px solid #eee;
		}

		.shop-name {
			font-weight: 500;
			color: var(--dark-color);
		}

		.shop-address {
			color: #666;
			font-size: 0.95rem;
		}

		.shop-phone {
			color: #666;
			font-size: 0.95rem;
		}

		/* 按钮优化 */
		.enter-shop-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 20px;
			padding: 8px 15px;
			font-size: 0.95rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 2px 6px rgba(255, 126, 46, 0.2);
		}

		.enter-shop-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-1px);
			box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
		}

		.enter-shop-btn:focus {
			outline: none;
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

			.shop-table thead th {
				padding: 10px;
				font-size: 1rem;
			}

			.shop-table tbody td {
				padding: 10px;
				font-size: 0.9rem;
			}

			.enter-shop-btn {
				padding: 6px 12px;
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

			.shop-table thead {
				display: none;
			}

			.shop-table tbody tr {
				display: block;
				margin-bottom: 20px;
				border: 1px solid #eee;
				border-radius: 10px;
				overflow: hidden;
			}

			.shop-table tbody td {
				display: block;
				padding: 8px 15px;
				border-top: 1px solid #eee;
			}

			.shop-table tbody td:first-child {
				background-color: var(--light-color);
				font-weight: 500;
			}

			.shop-table tbody td:last-child {
				text-align: center;
				padding: 15px;
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
		<li class="active"><a href="showShop"><i class="fa fa-cutlery"></i> 点餐</a></li>
		<li><a href="userManageInUser"><i class="fa fa-user"></i> 我的信息</a></li>
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
		<h2 class="page-title">选择店铺</h2>

		<div class="shop-table">
			<table class="table">
				<thead>
				<tr>
					<th>店铺名</th>
					<th>店铺地址</th>
					<th>联系方式</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${shoplist}">
					<tr>
						<td class="shop-name">${list.shop_name}</td>
						<td class="shop-address">${list.shop_address}</td>
						<td class="shop-phone">${list.shop_phone}</td>
						<td>
							<a href="showFood?shop_id=${list.shop_id}">
								<button class="enter-shop-btn">
									<i class="fa fa-shopping-bag"></i> 进入店铺
								</button>
							</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty shoplist}">
					<tr>
						<td colspan="4" class="empty-state">
							<i class="fa fa-cutlery"></i>
							<p>暂无店铺信息</p>
						</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>