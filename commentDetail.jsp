<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.sdutcm.wm.pojo.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>山中医外卖系统 - 评论详情</title>
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

        /* 信息卡片优化 */
        .info-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 20px;
        }

        .info-card h3 {
            color: var(--primary-color);
            font-size: 1.3rem;
            font-weight: 600;
            margin-top: 0;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            display: inline-block;
        }

        .order-info-table {
            width: 100%;
            margin-bottom: 15px;
        }

        .order-info-table th,
        .order-info-table td {
            padding: 10px 0;
            vertical-align: middle;
        }

        .order-info-table th {
            width: 180px;
            color: #666;
            font-weight: 500;
        }

        .order-id {
            color: #28a745;
            font-weight: 600;
        }

        .order-status {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-completed {
            background-color: #28a745;
            color: white;
        }

        /* 订单项目表格优化 */
        .order-items-table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .order-items-table thead {
            background-color: #f8f9fa;
        }

        .order-items-table th,
        .order-items-table td {
            padding: 12px 15px;
            text-align: center;
        }

        .order-items-table tfoot {
            font-weight: 600;
            background-color: #f8f9fa;
        }

        .price {
            color: var(--primary-color);
            font-weight: 500;
        }

        /* 评论内容优化 */
        .comment-card {
            background-color: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }

        .comment-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #eee;
        }

        .comment-time {
            color: #666;
            font-size: 0.95rem;
        }

        .comment-content {
            line-height: 1.8;
            font-size: 1.05rem;
            color: #555;
        }

        /* 返回按钮优化 */
        .back-btn {
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
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .back-btn:hover {
            background-color: #FF6A14;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
        }

        .back-btn:focus {
            outline: none;
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

            .order-info-table th {
                width: 150px;
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

            .info-card {
                padding: 20px;
            }

            .order-info-table th,
            .order-info-table td {
                padding: 8px 0;
                font-size: 0.95rem;
            }

            .order-info-table th {
                width: 120px;
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

            .order-info-table {
                display: block;
                overflow-x: auto;
            }

            .order-items-table {
                display: block;
                overflow-x: auto;
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
        <li><a href="getUserComments" class="back-btn">
            <i class="fa fa-arrow-left"></i> 返回评论列表
        </a></li>
    </ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
    <div class="card">
        <h2 class="page-title">评论详情</h2>

        <!-- 订单信息卡片 -->
        <div class="info-card">
            <h3>订单信息</h3>
            <table class="order-info-table">
                <tr>
                    <th>订单号</th>
                    <td><span class="order-id">${order.order_on}</span></td>
                    <th>下单时间</th>
                    <td>${order.order_time}</td>
                </tr>
                <tr>
                    <th>店铺名称</th>
                    <td>${order.shop_name}</td>
                    <th>订单状态</th>
                    <td><span class="order-status status-completed">已完成</span></td>
                </tr>
                <tr>
                    <th>配送地址</th>
                    <td colspan="3">${order.order_address}</td>
                </tr>
            </table>
        </div>

        <!-- 订单项目卡片 -->
        <div class="info-card">
            <h3>订单项目</h3>
            <div style="overflow-x: auto;">
                <table class="order-items-table table">
                    <thead>
                    <tr>
                        <th>菜品名称</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th>小计</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>${item.food_name}</td>
                            <td class="price">￥${item.food_price}</td>
                            <td>${item.food_num}</td>
                            <td class="price">￥${item.food_total}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="3" class="text-right">总计：</th>
                        <th class="price">￥${order.order_price}</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- 评论内容卡片 -->
        <div class="info-card">
            <h3>评论内容</h3>
            <div class="comment-card">
                <div class="comment-meta">
                    <span class="comment-time">评论时间：${comment.comment_time}</span>
                </div>
                <div class="comment-content">${comment.comment_content}</div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>