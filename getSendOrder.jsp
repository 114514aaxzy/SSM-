<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 正在配送订单</title>
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

		.shop-name {
			font-weight: 500;
			color: #555;
		}

		.order-id {
			font-weight: 600;
			color: #28a745;
		}

		.order-time {
			color: #dc3545;
		}

		.order-price {
			color: #fd7e14;
			font-weight: 500;
		}

		/* 订单状态标签优化 */
		.status-tag {
			display: inline-block;
			padding: 4px 10px;
			border-radius: 15px;
			font-size: 0.85rem;
			font-weight: 500;
			margin-right: 5px;
			transition: all 0.2s ease;
		}

		.status-3 { background-color: #17a2b8; color: white; } /* 已接单 */
		.status-4 { background-color: #ffc107; color: #212529; } /* 可取货 */
		.status-5 { background-color: #007bff; color: white; } /* 已送出 */

		.status-tag:hover {
			transform: scale(1.05);
		}

		/* 操作按钮优化 */
		.action-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 20px;
			padding: 6px 12px;
			font-size: 0.85rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 2px 6px rgba(255, 126, 46, 0.2);
			display: inline-flex;
			align-items: center;
			gap: 5px;
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
			gap: 8px;
		}

		/* 空状态提示 */
		.empty-order {
			text-align: center;
			padding: 50px 0;
			color: #999;
			background-color: var(--light-color);
			border-radius: 10px;
			padding: 30px;
		}

		.empty-order i {
			font-size: 3rem;
			margin-bottom: 20px;
			color: #ddd;
		}

		/* 状态说明区域优化 */
		.status-explanation {
			background-color: var(--accent-color);
			border-left: 4px solid var(--primary-color);
			padding: 10px 15px;
			margin-top: 10px;
			border-radius: 0 8px 8px 0;
			font-size: 0.9rem;
			color: #555;
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

			.order-table thead th {
				padding: 10px;
				font-size: 1rem;
			}

			.order-table tbody td {
				padding: 10px;
				font-size: 0.9rem;
			}

			.action-btn {
				padding: 5px 10px;
				font-size: 0.8rem;
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

			.order-table thead {
				display: none;
			}

			.order-table tbody tr {
				display: block;
				margin-bottom: 20px;
				border: 1px solid #eee;
				border-radius: 10px;
				overflow: hidden;
			}

			.order-table tbody td {
				display: block;
				padding: 8px 15px;
				border-top: 1px solid #eee;
				position: relative;
				padding-left: 120px;
			}

			.order-table tbody td:before {
				content: attr(data-label);
				position: absolute;
				left: 15px;
				width: 100px;
				font-weight: 500;
				color: #666;
			}

			.order-table tbody td:last-child {
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
	<ul id="Tab" class="nav nav-pills" style="justify-content: center; flex-wrap: wrap;">
		<li><a href="showShop"><i class="fa fa-cutlery"></i> 点餐</a></li>
		<li><a href="userManageInUser"><i class="fa fa-user"></i> 我的信息</a></li>
		<li><a href="getUserOrder"><i class="fa fa-list"></i> 我的订单</a></li>
		<li class="active"><a href="getSendOrder"><i class="fa fa-motorcycle"></i> 正在配送订单</a></li>
		<li><a href="getUserComments"><i class="fa fa-comments"></i> 我的评论</a></li>
		<li><a href="toUserHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
		<li><a href="quit"><i class="fa fa-sign-out"></i> 退出</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">正在配送的订单</h2>

		<c:if test="${empty Userorder}">
			<div class="empty-order">
				<i class="fa fa-motorcycle"></i>
				<p>暂无正在配送的订单</p>
				<p><a href="showShop" style="color: var(--primary-color); text-decoration: underline;">去点餐</a> 开始购物吧</p>
			</div>
		</c:if>

		<c:if test="${not empty Userorder}">
			<div class="order-table">
				<table class="table">
					<thead>
					<tr>
						<th>店铺名</th>
						<th>订单号</th>
						<th>下单时间</th>
						<th>订单价格</th>
						<th>实付金额</th>
						<th>订单状态</th>
						<th>收货地址</th>
						<th>用户ID</th>
						<th>联系方式</th>
						<th>配送员ID</th>
						<th>操作</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="oa" items="${Userorder}">
						<tr>
							<td data-label="店铺名" class="shop-name">${oa.shop_name}</td>
							<td data-label="订单号" class="order-id">${oa.order_on}</td>
							<td data-label="下单时间" class="order-time">${oa.order_time}</td>
							<td data-label="订单价格" class="order-price">${oa.order_price}</td>
							<td data-label="实付金额">${oa.order_pay}</td>
							<td data-label="订单状态">
								<c:choose>
									<c:when test="${oa.order_status == 3}">
										<span class="status-tag status-3">已接单</span>
									</c:when>
									<c:when test="${oa.order_status == 4}">
										<span class="status-tag status-4">可取货</span>
									</c:when>
									<c:when test="${oa.order_status == 5}">
										<span class="status-tag status-5">已送出</span>
									</c:when>
								</c:choose>
							</td>
							<td data-label="收货地址">${oa.order_address}</td>
							<td data-label="用户ID">${oa.user_id}</td>
							<td data-label="联系方式">${oa.user_phone}</td>
							<td data-label="配送员ID">${oa.rider_id}</td>
							<td data-label="操作">
								<div class="btn-group">
									<a href="getUserItem?order_on=${oa.order_on}" class="action-btn">
										<i class="fa fa-eye"></i> 查看详情
									</a>
									<c:if test="${oa.order_status == 5}">
										<a href="arrive?order_on=${oa.order_on}" class="action-btn" style="background-color: #28a745;">
											<i class="fa fa-check"></i> 确认收货
										</a>
									</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="11" class="status-explanation">
								订单状态说明：0未付款，1已付款，2拒接单，3已接单，4可取货，5已送出，6已完成
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>