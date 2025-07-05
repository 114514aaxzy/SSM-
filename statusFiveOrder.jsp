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
			--status-color-0: #6c757d; /* 未付款：灰色 */
			--status-color-1: #28a745; /* 已付款：绿色 */
			--status-color-2: #dc3545; /* 拒接单：红色 */
			--status-color-3: #ffc107; /* 已接单：黄色 */
			--status-color-4: #17a2b8; /* 可取货：青色 */
			--status-color-5: #007bff; /* 已送出：蓝色 */
			--status-color-6: #28a745; /* 已完成：绿色 */
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
			width: 100%;
			border-collapse: collapse;
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}

		.order-table thead {
			background-color: var(--primary-color);
			color: white;
		}

		.order-table th, .order-table td {
			padding: 12px 15px;
			text-align: center;
			vertical-align: middle;
			border-bottom: 1px solid #eee;
		}

		.order-table th {
			font-weight: 600;
			text-transform: capitalize;
		}

		.order-table tbody tr:hover {
			background-color: #f5f5f5;
			transition: background-color 0.2s ease;
		}

		.order-table .shop-link {
			color: var(--primary-color);
			font-weight: 500;
			text-decoration: none;
			transition: color 0.2s ease;
		}

		.order-table .shop-link:hover {
			color: #FF6A14;
			text-decoration: underline;
		}

		/* 订单状态样式 */
		.status-badge {
			display: inline-block;
			padding: 4px 8px;
			border-radius: 20px;
			font-size: 0.9rem;
			font-weight: 500;
			text-transform: capitalize;
		}

		.status-0 { background-color: rgba(108, 117, 125, 0.1); color: var(--status-color-0); }
		.status-1 { background-color: rgba(40, 167, 69, 0.1); color: var(--status-color-1); }
		.status-2 { background-color: rgba(220, 53, 69, 0.1); color: var(--status-color-2); }
		.status-3 { background-color: rgba(255, 193, 7, 0.1); color: var(--status-color-3); }
		.status-4 { background-color: rgba(23, 162, 184, 0.1); color: var(--status-color-4); }
		.status-5 { background-color: rgba(0, 123, 255, 0.1); color: var(--status-color-5); }
		.status-6 { background-color: rgba(40, 167, 69, 0.1); color: var(--status-color-6); }

		/* 订单状态说明 */
		.status-info {
			background-color: #f8f9fa;
			border-radius: 10px;
			padding: 15px;
			margin-top: 20px;
			border: 1px solid #eee;
			font-size: 0.95rem;
			color: #666;
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

			.order-table th, .order-table td {
				padding: 10px;
				font-size: 0.9rem;
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

			/* 响应式表格 */
			.order-table {
				display: block;
				overflow-x: auto;
				white-space: nowrap;
			}

			.order-table thead, .order-table tbody, .order-table th, .order-table td, .order-table tr {
				display: block;
			}

			.order-table thead tr {
				position: absolute;
				top: -9999px;
				left: -9999px;
			}

			.order-table tr {
				border: 1px solid #ddd;
				margin-bottom: 15px;
				border-radius: 10px;
				overflow: hidden;
			}

			.order-table td {
				border: none;
				border-bottom: 1px solid #eee;
				position: relative;
				padding-left: 50%;
				text-align: right;
			}

			.order-table td:before {
				position: absolute;
				left: 15px;
				width: 45%;
				padding-right: 10px;
				white-space: nowrap;
				text-align: left;
				font-weight: 600;
			}

			/* 为每个单元格添加标签 */
			.order-table td:nth-of-type(1):before { content: "店铺名:"; }
			.order-table td:nth-of-type(2):before { content: "订单号:"; }
			.order-table td:nth-of-type(3):before { content: "下单时间:"; }
			.order-table td:nth-of-type(4):before { content: "订单总价:"; }
			.order-table td:nth-of-type(5):before { content: "实付金额:"; }
			.order-table td:nth-of-type(6):before { content: "订单状态:"; }
			.order-table td:nth-of-type(7):before { content: "收货地址:"; }
			.order-table td:nth-of-type(8):before { content: "用户ID:"; }
			.order-table td:nth-of-type(9):before { content: "用户联系方式:"; }
			.order-table td:nth-of-type(10):before { content: "骑手ID:"; }

			/* 调整状态说明样式 */
			.status-info {
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

			.order-table td {
				padding-left: 15px;
				text-align: center;
			}

			.order-table td:before {
				position: relative;
				display: block;
				width: 100%;
				text-align: center;
				margin-bottom: 5px;
				color: var(--primary-color);
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

<!-- 导航栏区域 -->
<div class="container nav-container">
	<ul id="Tab" class="nav nav-pills" style="justify-content: center; flex-wrap: wrap;">
		<li><a href="riderManage"><i class="fa fa-user"></i> 我的信息</a></li>
		<li><a href="getStatusFourOrder"><i class="fa fa-list-alt"></i> 可配送订单</a></li>
		<li class="active"><a href="getStatusFiveOrder"><i class="fa fa-motorcycle"></i> 正在配送订单</a></li>
		<li><a href="getPendingCompletionOrders"><i class="fa fa-edit"></i> 待完善订单</a></li>
		<li><a href="completedOrders"><i class="fa fa-check-circle"></i> 已完成订单</a></li>
		<li><a href="riderHome"><i class="fa fa-home"></i> 返回主页</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">正在配送订单</h2>

		<div class="table-responsive">
			<table class="order-table">
				<thead>
				<tr>
					<th>店铺名</th>
					<th>订单号</th>
					<th>下单时间</th>
					<th>订单总价</th>
					<th>实付金额</th>
					<th>订单状态</th>
					<th>收货地址</th>
					<th>用户ID</th>
					<th>用户联系方式</th>
					<th>骑手ID</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="oa" items="${orderlist}">
					<tr>
						<td><a href="getShop?shop_id=${oa.shop_id}" class="shop-link">${oa.shop_name}</a></td>
						<td>${oa.order_on}</td>
						<td>${oa.order_time}</td>
						<td>¥${oa.order_price}</td>
						<td>¥${oa.order_pay}</td>
						<td>
							<span class="status-badge status-${oa.order_status}">
								${oa.order_status == 0 ? '未付款' :
									oa.order_status == 1 ? '已付款' :
									oa.order_status == 2 ? '拒接单' :
									oa.order_status == 3 ? '已接单' :
									oa.order_status == 4 ? '可取货' :
									oa.order_status == 5 ? '已送出' : '已完成'}
							</span>
						</td>
						<td>${oa.order_address}</td>
						<td>${oa.user_id}</td>
						<td>${oa.user_phone}</td>
						<td>${oa.rider_id}</td>
						<td>
							<button class="btn btn-success btn-sm complete-order" 
									data-order-on="${oa.order_on}" 
									data-rider-id="${oa.rider_id}">
								<i class="fa fa-check"></i> 完成配送
							</button>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 订单状态说明 -->
		<div class="status-info">
			<p><i class="fa fa-info-circle"></i> 订单状态说明：0-未付款（灰色），1-已付款（绿色），2-拒接单（红色），3-已接单（黄色），4-可取货（青色），5-已送出（蓝色），6-已完成（绿色）</p>
		</div>
	</div>
</div>

<!-- 完成订单模态框 -->
<div class="modal fade" id="completeOrderModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">完成订单</h4>
			</div>
			<div class="modal-body">
				<form id="completeOrderForm">
					<input type="hidden" id="orderOn" name="orderOn">
					<input type="hidden" id="riderId" name="riderId">
					
					<div class="form-group">
						<label>配送距离 (km)</label>
						<input type="number" class="form-control" id="deliveryDistance" name="deliveryDistance" step="0.1" required>
					</div>
					
					<div class="form-group">
						<label>配送时长 (分钟)</label>
						<input type="number" class="form-control" id="deliveryDuration" name="deliveryDuration" required>
					</div>
					
					<div class="form-group">
						<label>配送费 (元)</label>
						<input type="number" class="form-control" id="deliveryFee" name="deliveryFee" step="0.1" required>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="submitCompleteOrder">确认完成</button>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		// 完成订单按钮点击事件
		$(document).on('click', '.complete-order', function() {
			const orderOn = $(this).data('order-on');
			const riderId = $(this).data('rider-id');
			$('#orderOn').val(orderOn);
			$('#riderId').val(riderId);
			$('#completeOrderModal').modal('show');
		});
		
		// 提交完成订单
		$('#submitCompleteOrder').click(function() {
			const formData = {
				orderOn: $('#orderOn').val(),
				riderId: $('#riderId').val(),
				deliveryDistance: parseFloat($('#deliveryDistance').val()),
				deliveryDuration: parseInt($('#deliveryDuration').val()),
				deliveryFee: parseFloat($('#deliveryFee').val())
			};
			
			$.ajax({
				url: '${pageContext.request.contextPath}/api/rider/completed-orders/complete',
				method: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(formData),
				success: function(response) {
					if (response.success) {
						alert('订单已完成！');
						$('#completeOrderModal').modal('hide');
						// 刷新页面
						location.reload();
					} else {
						alert('操作失败：' + response.message);
					}
				},
				error: function(xhr, status, error) {
					alert('系统错误：' + error);
					console.error('Error:', xhr.responseText);
				}
			});
		});

		// 验证表单输入
		$('#completeOrderForm').on('input', 'input', function() {
			const deliveryDistance = parseFloat($('#deliveryDistance').val());
			const deliveryDuration = parseInt($('#deliveryDuration').val());
			const deliveryFee = parseFloat($('#deliveryFee').val());
			
			const isValid = 
				!isNaN(deliveryDistance) && deliveryDistance > 0 &&
				!isNaN(deliveryDuration) && deliveryDuration > 0 &&
				!isNaN(deliveryFee) && deliveryFee > 0;
			
			$('#submitCompleteOrder').prop('disabled', !isValid);
		});
	});
</script>
</body>
</html>