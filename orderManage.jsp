<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 店铺订单管理</title>
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

			/* 订单状态颜色 */
			--status-pending: #f0ad4e;
			--status-rejected: #d9534f;
			--status-processing: #5bc0de;
			--status-ready: #5cb85c;
			--status-delivering: #428bca;
			--status-completed: #777;
		}

		body {
			font-family: 'Microsoft YaHei', Arial, sans-serif;
			color: var(--text-color);
			background-color: #f8f9fa;
		}

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

		.nav-container {
			margin-top: -20px;
			z-index: 100;
			padding: 20px 0;
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

		.content-container {
			margin-top: 30px;
			padding: 0 15px;
		}

		.order-section {
			background: white;
			border-radius: 15px;
			box-shadow: 0 4px 16px rgba(0,0,0,0.08);
			padding: 20px;
			margin-bottom: 30px;
		}

		.order-header {
			display: flex;
			align-items: center;
			justify-content: space-between;
			margin-bottom: 20px;
			padding-bottom: 15px;
			border-bottom: 2px solid var(--accent-color);
		}

		.order-title {
			font-size: 1.4rem;
			font-weight: 600;
			color: var(--primary-color);
			margin: 0;
		}

		.order-count {
			background: var(--accent-color);
			color: var(--dark-color);
			padding: 5px 15px;
			border-radius: 20px;
			font-weight: 500;
		}

		.order-table {
			width: 100%;
			margin-bottom: 20px;
		}

		.order-table th {
			background: var(--light-color);
			padding: 12px;
			font-weight: 600;
			color: var(--dark-color);
			border-bottom: 2px solid var(--accent-color);
		}

		.order-table td {
			padding: 12px;
			border-bottom: 1px solid #eee;
		}

		.status-badge {
			display: inline-block;
			padding: 5px 12px;
			border-radius: 20px;
			font-size: 0.9rem;
			font-weight: 500;
			color: white;
		}

		.status-1 { background-color: var(--status-pending); }
		.status-2 { background-color: var(--status-rejected); }
		.status-3 { background-color: var(--status-processing); }
		.status-4 { background-color: var(--status-ready); }
		.status-5 { background-color: var(--status-delivering); }
		.status-6 { background-color: var(--status-completed); }

		.action-btn {
			padding: 5px 12px;
			border-radius: 15px;
			border: none;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			margin: 0 2px;
		}

		.btn-accept {
			background-color: var(--status-ready);
			color: white;
		}

		.btn-reject {
			background-color: var(--status-rejected);
			color: white;
		}

		.empty-state {
			text-align: center;
			padding: 40px;
		}

		.empty-icon {
			font-size: 48px;
			color: var(--secondary-color);
			margin-bottom: 20px;
		}

		.empty-text {
			font-size: 1.2rem;
			color: #666;
		}

		@media (max-width: 768px) {
			.system-title {
				font-size: 2rem;
			}

			.order-table {
				display: block;
				overflow-x: auto;
			}

			.nav-pills>li>a {
				padding: 10px 15px;
				font-size: 0.9rem;
			}
		}
	</style>
</head>
<body>
	<!-- 头部区域 -->
	<div class="header">
		<div class="container">
			<div class="logo-container">
				<img src="static/images/sdutcm.jpg" class="logo-img" width="180" height="140" alt="山东中医药大学校徽">
				<h1 class="system-title">山中医外卖系统</h1>
			</div>
		</div>
	</div>

	<!-- 导航栏 -->
	<div class="container nav-container">
		<ul class="nav nav-pills">
			<li class="active"><a href="#"><i class="fa fa-list"></i> 订单管理</a></li>
			<li><a href="toSellerHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
		</ul>
	</div>

	<!-- 内容区域 -->
	<div class="container content-container">
		<c:choose>
			<c:when test="${empty pendingOrders and empty processingOrders and empty readyOrders and empty deliveringOrders and empty completedOrders and empty rejectedOrders}">
				<!-- 空状态显示 -->
				<div class="empty-state">
					<i class="fa fa-clipboard-list empty-icon"></i>
					<p class="empty-text">暂无订单</p>
				</div>
			</c:when>
			<c:otherwise>
				<!-- 待处理订单 -->
				<c:if test="${not empty pendingOrders}">
					<div class="order-section">
						<div class="order-header">
							<h3 class="order-title"><i class="fa fa-clock-o"></i> 待处理订单</h3>
							<span class="order-count">${pendingOrders.size()}个订单</span>
						</div>
						<div class="table-responsive">
							<table class="order-table">
								<thead>
									<tr>
										<th>订单号</th>
										<th>店铺</th>
										<th>总价</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pendingOrders}" var="order">
										<tr>
											<td>${order.order_on}</td>
											<td>
												<c:forEach items="${shops}" var="shop">
													<c:if test="${shop.shop_id eq order.shop_id}">
														${shop.shop_name}
													</c:if>
												</c:forEach>
											</td>
											<td>￥${order.order_price}</td>
											<td><span class="status-badge status-1">待处理</span></td>
											<td>
												<form style="display: inline;" action="updateOrderStatus" method="post">
													<input type="hidden" name="order_on" value="${order.order_on}">
													<input type="hidden" name="status" value="3">
													<button type="submit" class="action-btn btn-accept">接受</button>
												</form>
												<form style="display: inline;" action="updateOrderStatus" method="post">
													<input type="hidden" name="order_on" value="${order.order_on}">
													<input type="hidden" name="status" value="2">
													<button type="submit" class="action-btn btn-reject">拒绝</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>

				<!-- 处理中订单 -->
				<c:if test="${not empty processingOrders}">
					<div class="order-section">
						<div class="order-header">
							<h3 class="order-title"><i class="fa fa-refresh"></i> 处理中订单</h3>
							<span class="order-count">${processingOrders.size()}个订单</span>
						</div>
						<div class="table-responsive">
							<table class="order-table">
								<thead>
									<tr>
										<th>订单号</th>
										<th>店铺</th>
										<th>总价</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${processingOrders}" var="order">
										<tr>
											<td>${order.order_on}</td>
											<td>
												<c:forEach items="${shops}" var="shop">
													<c:if test="${shop.shop_id eq order.shop_id}">
														${shop.shop_name}
													</c:if>
												</c:forEach>
											</td>
											<td>￥${order.order_price}</td>
											<td><span class="status-badge status-3">处理中</span></td>
											<td>
												<form action="updateOrderStatus" method="post">
													<input type="hidden" name="order_on" value="${order.order_on}">
													<input type="hidden" name="status" value="4">
													<button type="submit" class="action-btn btn-accept">完成制作</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>

				<!-- 其他状态的订单... -->
				<c:if test="${not empty readyOrders}">
					<div class="order-section">
						<div class="order-header">
							<h3 class="order-title"><i class="fa fa-check"></i> 待配送订单</h3>
							<span class="order-count">${readyOrders.size()}个订单</span>
						</div>
						<div class="table-responsive">
							<table class="order-table">
								<thead>
									<tr>
										<th>订单号</th>
										<th>店铺</th>
										<th>总价</th>
										<th>状态</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${readyOrders}" var="order">
										<tr>
											<td>${order.order_on}</td>
											<td>
												<c:forEach items="${shops}" var="shop">
													<c:if test="${shop.shop_id eq order.shop_id}">
														${shop.shop_name}
													</c:if>
												</c:forEach>
											</td>
											<td>￥${order.order_price}</td>
											<td><span class="status-badge status-4">待配送</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>

				<!-- 配送中订单 -->
				<c:if test="${not empty deliveringOrders}">
					<div class="order-section">
						<div class="order-header">
							<h3 class="order-title"><i class="fa fa-bicycle"></i> 配送中订单</h3>
							<span class="order-count">${deliveringOrders.size()}个订单</span>
						</div>
						<div class="table-responsive">
							<table class="order-table">
								<thead>
									<tr>
										<th>订单号</th>
										<th>店铺</th>
										<th>总价</th>
										<th>状态</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${deliveringOrders}" var="order">
										<tr>
											<td>${order.order_on}</td>
											<td>
												<c:forEach items="${shops}" var="shop">
													<c:if test="${shop.shop_id eq order.shop_id}">
														${shop.shop_name}
													</c:if>
												</c:forEach>
											</td>
											<td>￥${order.order_price}</td>
											<td><span class="status-badge status-5">配送中</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>

				<!-- 已完成订单 -->
				<c:if test="${not empty completedOrders}">
					<div class="order-section">
						<div class="order-header">
							<h3 class="order-title"><i class="fa fa-check-circle"></i> 已完成订单</h3>
							<span class="order-count">${completedOrders.size()}个订单</span>
						</div>
						<div class="table-responsive">
							<table class="order-table">
								<thead>
									<tr>
										<th>订单号</th>
										<th>店铺</th>
										<th>总价</th>
										<th>状态</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${completedOrders}" var="order">
										<tr>
											<td>${order.order_on}</td>
											<td>
												<c:forEach items="${shops}" var="shop">
													<c:if test="${shop.shop_id eq order.shop_id}">
														${shop.shop_name}
													</c:if>
												</c:forEach>
											</td>
											<td>￥${order.order_price}</td>
											<td><span class="status-badge status-6">已完成</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>

				<!-- 已拒绝订单 -->
				<c:if test="${not empty rejectedOrders}">
					<div class="order-section">
						<div class="order-header">
							<h3 class="order-title"><i class="fa fa-times-circle"></i> 已拒绝订单</h3>
							<span class="order-count">${rejectedOrders.size()}个订单</span>
						</div>
						<div class="table-responsive">
							<table class="order-table">
								<thead>
									<tr>
										<th>订单号</th>
										<th>店铺</th>
										<th>总价</th>
										<th>状态</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${rejectedOrders}" var="order">
										<tr>
											<td>${order.order_on}</td>
											<td>
												<c:forEach items="${shops}" var="shop">
													<c:if test="${shop.shop_id eq order.shop_id}">
														${shop.shop_name}
													</c:if>
												</c:forEach>
											</td>
											<td>￥${order.order_price}</td>
											<td><span class="status-badge status-2">已拒绝</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</c:if>
			</c:otherwise>
		</c:choose>
	</div>

	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>