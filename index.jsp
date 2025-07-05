<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		/* 自定义颜色方案 - 采用橙色系为主色调，符合外卖行业特征 */
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

		/* 头部样式优化 */
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

		/* 导航栏优化 */
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

		.dropdown-menu {
			border-radius: 15px;
			box-shadow: 0 6px 16px rgba(0,0,0,0.12);
			margin-top: 5px;
		}

		.dropdown-menu>li>a {
			padding: 8px 20px;
			transition: background-color 0.2s ease;
		}

		.dropdown-menu>li>a:hover {
			background-color: var(--accent-color);
			color: var(--dark-color);
		}

		/* 内容区域优化 */
		.content-container {
			margin-top: 30px;
		}

		.tab-content {
			background-color: white;
			border-radius: 15px;
			box-shadow: 0 4px 16px rgba(0,0,0,0.08);
			padding: 30px;
		}

		.tab-pane {
			animation: fadeIn 0.5s ease-in-out;
		}

		@keyframes fadeIn {
			from { opacity: 0; transform: translateY(10px); }
			to { opacity: 1; transform: translateY(0); }
		}

		.section-title {
			color: var(--primary-color);
			font-size: 1.8rem;
			font-weight: 600;
			margin-top: 0;
			padding-bottom: 15px;
			border-bottom: 2px solid var(--accent-color);
			display: inline-block;
		}

		.system公告 {
			line-height: 1.8;
			font-size: 1.05rem;
		}

		/* 轮播图优化 */
		.carousel-container {
			margin-top: 30px;
			border-radius: 15px;
			overflow: hidden;
			box-shadow: 0 6px 24px rgba(0,0,0,0.12);
		}

		.carousel-indicators li {
			width: 12px;
			height: 12px;
			border-radius: 50%;
			background-color: rgba(255,255,255,0.5);
		}

		.carousel-indicators li.active {
			background-color: white;
			width: 14px;
			height: 14px;
		}

		.carousel-control {
			width: 5%;
		}

		.carousel-control .glyphicon-chevron-left,
		.carousel-control .glyphicon-chevron-right {
			font-size: 30px;
			color: var(--primary-color);
		}

		.carousel-caption {
			background-color: rgba(0,0,0,0.5);
			border-radius: 8px;
			padding: 15px 25px;
			bottom: 30px;
			right: 30px;
			left: auto;
			max-width: 300px;
			text-align: left;
		}

		.carousel-caption h4 {
			font-size: 1.2rem;
			margin-top: 0;
		}

		.carousel-caption p {
			font-size: 0.9rem;
			margin-bottom: 0;
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

			.tab-content {
				padding: 20px;
			}

			.section-title {
				font-size: 1.5rem;
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
		}
	</style>
</head>
<body>
<!-- 优化后的头部区域 -->
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
		<li><a href="#index" data-toggle="tab"><i class="fa fa-home"></i> 首页</a></li>
		<li class="dropdown">
			<a href="#" id="TabDrop" class="dropdown-toggle" data-toggle="dropdown">
				关于我们 <b class="caret"></b>
			</a>
			<ul class="dropdown-menu">
				<li><a href="#sdutcm" tabindex="-1" data-toggle="tab">山中医外卖系统</a></li>
				<li><a href="#about" tabindex="-1" data-toggle="tab">关于我们</a></li>
			</ul>
		</li>
		<li><a href="userCheck"><i class="fa fa-user-plus"></i> 注册</a></li>
		<li><a href="tologin"><i class="fa fa-sign-in"></i> 登录</a></li>
	</ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
	<div id="TabContent" class="tab-content">
		<div class="tab-pane fade in active" id="index">
			<h2 class="section-title">系统公告</h2>
			<p class="system公告">
				欢迎使用山中医外卖系统！本系统致力于为山东中医药大学师生提供便捷、高效的外卖服务。
				我们与校内多家优质商家合作，涵盖各种风味美食，满足您的不同口味需求。
				系统支持在线下单、支付、订单跟踪等功能，让您足不出户即可享受美味佳肴。
				如有任何问题或建议，请联系我们的客服团队，我们将竭诚为您服务！
			</p>
		</div>


		<div class="tab-pane fade" id="sdutcm">
			<h2 class="section-title">山中医外卖</h2>
			<p>
				山中医外卖系统是专为山东中医药大学师生打造的校园外卖平台，
				旨在解决师生们在校园生活中的饮食需求。我们严选校内优质商家，
				确保食品卫生与安全，同时提供丰富的菜品选择，让您在繁忙的学习和工作中，
				也能享受到美味可口的餐食。
			</p>
			<p>
				系统具备简洁易用的界面和流畅的操作体验，无论是午餐、晚餐还是宵夜，
				只需轻轻一点，美味即刻送达。我们致力于不断优化系统功能和服务质量，
				为您带来更好的外卖体验。
			</p>
		</div>

		<div class="tab-pane fade" id="about">
			<h2 class="section-title">组员介绍</h2>
			<div class="row">
				<div class="col-md-4">
					<div class="panel panel-info">
						<div class="panel-heading">徐志永</div>
						<div class="panel-body">
							<p>前端后端开发</p>
							<p>个人信息展示，点餐（购物车结算），我的订单，配送订单（确认收货），评价订单</p>
						</div>
						<div class="panel-heading">吴曰邦</div>
						<div class="panel-body">
							<p>前端后端开发</p>
							<p>店铺个人信息展示，店铺管理（注册店铺，添加菜品），店铺订单（接单/拒绝，制作完成）</p>
						</div>
						<div class="panel-heading">韩寓宇</div>
						<div class="panel-body">
							<p>前端后端开发</p>
							<p>骑手个人信息展示，骑手抢单功能，骑手显示正在配送的订单</p>
						</div>
					</div>
				</div>
				<!-- 可扩展更多组员介绍 -->
			</div>
		</div>
	</div>

	<!-- 优化后的轮播图 -->
	<div id="myCarousel" class="carousel slide carousel-container" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img src="static/images/cxx.jpg" alt="美食推荐">
				<div class="carousel-caption">
					<h4>今日推荐</h4>
					<p>营养套餐，健康美味</p>
				</div>
			</div>
			<div class="item">
				<img src="static/images/cp2.jpg" alt="特色菜品">
				<div class="carousel-caption">
					<h4>特色菜品</h4>
					<p>传统美食，地道风味</p>
				</div>
			</div>
			<div class="item">
				<img src="static/images/cp3.jpg" alt="优惠活动">
				<div class="carousel-caption">
					<h4>优惠活动</h4>
					<p>新用户立减，多买多送</p>
				</div>
			</div>
		</div>
		<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>