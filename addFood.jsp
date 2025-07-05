<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.sdutcm.wm.pojo.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 添加菜品</title>
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

		.file-upload {
			position: relative;
			display: inline-block;
		}

		.file-upload-btn {
			background-color: var(--primary-color);
			color: white;
			border: none;
			border-radius: 10px;
			padding: 10px 20px;
			font-size: 0.95rem;
			cursor: pointer;
			transition: all 0.3s ease;
		}

		.file-upload-btn:hover {
			background-color: #FF6A14;
			transform: translateY(-1px);
		}

		.file-upload-input {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			opacity: 0;
			cursor: pointer;
		}

		.file-name {
			display: inline-block;
			margin-left: 10px;
			max-width: 200px;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}

		/* 提交按钮优化 */
		.submit-btn {
			background-color: #28a745;
			color: white;
			border: none;
			border-radius: 25px;
			padding: 12px 30px;
			font-size: 1rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
			display: block;
			width: 100%;
			max-width: 200px;
			margin: 30px auto 0;
		}

		.submit-btn:hover {
			background-color: #218838;
			transform: translateY(-2px);
			box-shadow: 0 6px 16px rgba(40, 167, 69, 0.3);
		}

		.submit-btn:focus {
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

		/* 添加店铺选择样式 */
		.shop-select {
			width: 100%;
			height: 45px;
			border-radius: 10px;
			border: 1px solid #ddd;
			padding: 10px 15px;
			transition: border-color 0.3s ease;
			background-color: white;
			-webkit-appearance: none;
			-moz-appearance: none;
			appearance: none;
			background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
			background-repeat: no-repeat;
			background-position: right 1rem center;
			background-size: 1em;
		}

		.shop-select:focus {
			border-color: var(--primary-color);
			box-shadow: 0 0 0 3px rgba(255, 126, 46, 0.2);
			outline: none;
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
		<li class="active"><a href="#adminPI"><i class="fa fa-plus-circle"></i> 添加菜品</a></li>
		<li><a href="toSellerHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div class="card">
		<h2 class="page-title">添加新菜品</h2>

		<f:form action="addFood" method="post" enctype="multipart/form-data">
			<!-- 店铺选择 -->
			<div class="form-group">
				<label class="form-label required-field">选择店铺</label>
				<select name="shop_id" class="shop-select" required>
					<c:forEach items="${shops}" var="shop">
						<option value="${shop.shop_id}">${shop.shop_name}</option>
					</c:forEach>
				</select>
			</div>

			<!-- 菜品号输入 -->
			<div class="form-group">
				<label for="food_id" class="form-label required-field">菜品号</label>
				<input type="text" id="food_id" name="food_id" class="form-control"
					   required="required" pattern="^[a-zA-Z0-9]{1,32}$"
					   title="请输入1-32位的字母或数字">
			</div>

			<!-- 菜品图片上传 -->
			<div class="form-group">
				<label for="food_img" class="form-label required-field">菜品图片</label>
				<div class="file-upload">
					<button type="button" class="file-upload-btn">
						<i class="fa fa-upload"></i> 选择图片
					</button>
					<input type="file" id="food_img" name="food_img" class="file-upload-input"
						   required="required" accept="image/*">
					<span class="file-name" id="file-name">未选择文件</span>
				</div>
			</div>

			<!-- 菜品名输入 -->
			<div class="form-group">
				<label for="food_name" class="form-label required-field">菜品名</label>
				<input type="text" id="food_name" name="food_name" class="form-control"
					   required="required" maxlength="100">
			</div>

			<!-- 菜品价格输入 -->
			<div class="form-group">
				<label for="food_price" class="form-label required-field">菜品价格</label>
				<input type="number" id="food_price" name="food_price" class="form-control"
					   required="required" min="0" step="0.01">
			</div>

			<!-- 提交按钮 -->
			<button type="submit" class="submit-btn">
				<i class="fa fa-check"></i> 确认添加
			</button>
		</f:form>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	// 显示选择的文件名
	$(document).ready(function() {
		$(".file-upload-input").change(function() {
			var fileName = $(this).val().split('\\').pop();
			if (fileName) {
				$(".file-name").text(fileName);
			} else {
				$(".file-name").text("未选择文件");
			}
		});
	});
</script>
</body>
</html>