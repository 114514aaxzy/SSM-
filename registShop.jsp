<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 店铺注册</title>
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

		/* 表单优化 */
		.form-group {
			margin-bottom: 25px;
		}

		.form-label {
			display: block;
			margin-bottom: 10px;
			font-weight: 500;
			color: var(--dark-color);
		}

		.required-field::after {
			content: " *";
			color: #e74c3c;
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

		.error-message {
			color: #e74c3c;
			font-size: 0.9rem;
			margin-top: 5px;
			display: block;
		}

		/* 按钮优化 */
		.btn-container {
			margin-top: 30px;
			text-align: center;
		}

		.btn-primary {
			background-color: var(--primary-color);
			border: none;
			border-radius: 25px;
			padding: 12px 30px;
			font-size: 1rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 4px 12px rgba(255, 126, 46, 0.2);
			margin-right: 15px;
		}

		.btn-primary:hover {
			background-color: #FF6A14;
			transform: translateY(-2px);
			box-shadow: 0 6px 16px rgba(255, 126, 46, 0.3);
		}

		.btn-primary:focus {
			outline: none;
		}

		.btn-default {
			background-color: #f0f0f0;
			border: none;
			border-radius: 25px;
			padding: 12px 30px;
			font-size: 1rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 2px 8px rgba(0,0,0,0.05);
		}

		.btn-default:hover {
			background-color: #e0e0e0;
			transform: translateY(-1px);
		}

		.btn-default:focus {
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

			.form-control {
				height: 40px;
				font-size: 0.95rem;
			}

			.btn-primary, .btn-default {
				padding: 10px 25px;
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

			.btn-container {
				display: flex;
				flex-direction: column;
				gap: 15px;
			}

			.btn-primary, .btn-default {
				margin-right: 0;
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
		<li class="active"><a href="#adminPI"><i class="fa fa-plus-circle"></i> 店铺注册</a></li>
		<li><a href="toSellerHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">店铺注册</h2>

		<f:form action="shopRegist" method="post" modelAttribute="shop">
			<!-- 店铺ID -->
			<div class="form-group">
				<label for="shop_id" class="form-label">店铺ID</label>
				<f:input path="shop_id" id="shop_id" class="form-control" />
				<f:errors path="shop_id" cssClass="error-message" />
			</div>

			<!-- 店铺名 -->
			<div class="form-group">
				<label for="shop_name" class="form-label">店铺名</label>
				<f:input path="shop_name" id="shop_name" class="form-control" />
			</div>

			<!-- 店铺地址 -->
			<div class="form-group">
				<label for="shop_address" class="form-label">店铺地址</label>
				<f:input path="shop_address" id="shop_address" class="form-control" />
			</div>

			<!-- 联系方式 -->
			<div class="form-group">
				<label for="shop_phone" class="form-label required-field">联系方式</label>
				<f:input path="shop_phone" id="shop_phone" class="form-control"
						 placeholder="请输入11位手机号码" required="required" />
				<f:errors path="shop_phone" cssClass="error-message" />
			</div>

			<!-- 按钮区域 -->
			<div class="btn-container">
				<button type="submit" class="btn btn-primary">
					<i class="fa fa-check"></i> 注册
				</button>
				<button type="reset" class="btn btn-default">
					<i class="fa fa-refresh"></i> 重填
				</button>
			</div>
		</f:form>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	// 表单验证和交互增强
	$(document).ready(function() {
		// 为表单输入添加焦点效果
		$('.form-control').focus(function() {
			$(this).closest('.form-group').addClass('has-focus');
		}).blur(function() {
			$(this).closest('.form-group').removeClass('has-focus');
		});

		// 手机号码验证
		$('#shop_phone').on('input', function() {
			var phone = $(this).val();
			var phoneRegex = /^1[3-9]\d{9}$/;

			if (phone && !phoneRegex.test(phone)) {
				$(this).addClass('border-danger');
			} else {
				$(this).removeClass('border-danger');
			}
		});
	});
</script>
</body>
</html>