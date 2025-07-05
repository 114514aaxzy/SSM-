<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>山中医外卖系统 - 骑手首页</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* 全局颜色变量定义 */
        :root {
            --primary-color: #FF7E2E;
            --secondary-color: #FFA542;
            --accent-color: #FFE0B3;
            --text-color: #333;
            --light-bg: #F9F9F9;
            --card-shadow: 0 4px 16px rgba(0,0,0,0.08);
        }

        /* 基础样式重置 */
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f8f9fa;
            color: var(--text-color);
        }

        /* 头部样式 */
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

        /* 导航栏样式 */
        .nav-container {
            margin-top: -20px;
            z-index: 100;
        }
        .nav-pills>li>a {
            color: var(--text-color);
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
        .nav-pills>li.active>a {
            background-color: var(--primary-color);
            color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        /* 内容区域样式 */
        .content-container {
            margin-top: 30px;
        }
        .card {
            background-color: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
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

        /* 系统公告样式 */
        .notice-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 30px;
        }
        .notice-title {
            color: var(--primary-color);
            font-size: 1.3rem;
            font-weight: 600;
            margin-top: 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            display: inline-block;
        }
        .notice-content {
            margin-top: 15px;
            line-height: 1.8;
            color: #555;
        }

        /* 轮播图样式 */
        .carousel-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
        }
        .carousel-indicators li {
            border-radius: 50%;
            width: 12px;
            height: 12px;
            background-color: #ddd;
        }
        .carousel-indicators .active {
            background-color: var(--primary-color);
        }
        .carousel-control {
            width: 5%;
            color: var(--primary-color);
        }
        .carousel-control:hover {
            color: var(--secondary-color);
        }
        .carousel-control .glyphicon {
            font-size: 30px;
        }
        .carousel-inner .item img {
            height: 300px;
            object-fit: cover;
        }

        /* 响应式适配 */
        @media (max-width: 768px) {
            .system-title { font-size: 2rem; }
            .nav-pills>li>a {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
            .page-title { font-size: 1.5rem; }
            .notice-card, .carousel-inner .item img { padding: 20px; height: 250px; }
        }
        @media (max-width: 480px) {
            .system-title { font-size: 1.8rem; }
            .nav-pills { flex-direction: column; }
            .nav-pills>li>a { text-align: center; }
            .carousel-inner .item img { height: 200px; }
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

<!-- 导航栏区域 -->
<div class="container nav-container">
    <ul id="Tab" class="nav nav-pills" style="justify-content: center; flex-wrap: wrap;">
        <li><a href="riderManage"><i class="fa fa-user"></i> 我的信息</a></li>
        <li><a href="getStatusFourOrder"><i class="fa fa-list-alt"></i> 可配送订单</a></li>
        <li><a href="getStatusFiveOrder"><i class="fa fa-motorcycle"></i> 正在配送订单</a></li>
        <li><a href="getPendingCompletionOrders"><i class="fa fa-edit"></i> 待完善订单</a></li>
        <li><a href="completedOrders"><i class="fa fa-check-circle"></i> 已完成订单</a></li>
        <li><a href="quit"><i class="fa fa-sign-out"></i> 退出</a></li>
    </ul>
</div>

<!-- 内容区域 -->
<div class="container content-container">
    <div class="card">
        <h2 class="page-title">骑手首页</h2>

        <!-- 系统公告卡片 -->
        <div class="notice-card">
            <h3 class="notice-title">系统公告</h3>
            <div class="notice-content">
                <p>[系统公告文案：欢迎使用山中医外卖骑手端，您可以在"可配送订单"中查看待取餐订单，在"正在配送订单"中查看当前配送任务。请及时接单并完成配送，确保餐品准时送达。如有问题，请联系平台客服。]</p>
            </div>
        </div>

        <!-- 轮播图区域 -->
        <div class="carousel-container">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>

                <div class="carousel-inner">
                    <div class="item active">
                        <img src="static/images/cxx.jpg" alt="配送提示">
                    </div>
                    <div class="item">
                        <img src="static/images/cp2.jpg" alt="骑手规范">
                    </div>
                    <div class="item">
                        <img src="static/images/cp3.jpg" alt="安全提示">
                    </div>
                </div>

                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">上一张</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">下一张</span>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>