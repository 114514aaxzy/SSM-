<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.sdutcm.wm.pojo.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>山中医外卖系统 - 我的评论</title>
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

        /* 评论列表优化 */
        .comment-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .comment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .order-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .order-id {
            font-weight: 600;
            color: #28a745;
            margin-right: 10px;
        }

        .shop-name {
            font-weight: 500;
            color: var(--primary-color);
        }

        .comment-time {
            color: #666;
            font-size: 0.9rem;
        }

        .comment-content {
            margin: 15px 0;
            line-height: 1.6;
            color: #555;
        }

        .comment-preview {
            color: #555;
            line-height: 1.6;
            max-height: 80px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }

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
        }

        .action-btn:hover {
            background-color: #FF6A14;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
        }

        .action-btn:focus {
            outline: none;
        }

        /* 空状态提示 */
        .empty-comment {
            text-align: center;
            padding: 50px 0;
            color: #999;
        }

        .empty-comment i {
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

            .comment-card {
                padding: 15px;
            }

            .order-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
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
        <li class="active"><a href="getUserComments"><i class="fa fa-comments"></i> 我的评论</a></li>
        <li><a href="toUserHomePage"><i class="fa fa-arrow-left"></i> 返回</a></li>
        <li><a href="quit"><i class="fa fa-sign-out"></i> 退出</a></li>
    </ul>
</div>

<!-- 优化后的内容区域 -->
<div class="container content-container">
    <div class="card">
        <h2 class="page-title">我的评论列表</h2>

        <c:if test="${empty commentList}">
            <div class="empty-comment">
                <i class="fa fa-comments-o"></i>
                <p>暂无评论记录</p>
                <p><a href="showShop" style="color: var(--primary-color); text-decoration: underline;">去点餐</a> 后可以对订单进行评论</p>
            </div>
        </c:if>

        <c:if test="${not empty commentList}">
            <c:forEach var="comment" items="${commentList}">
                <div class="comment-card">
                    <div class="comment-header">
                        <div class="order-info">
                            <span class="order-id">订单号：${comment.order_on}</span>
                            <span class="shop-name">${comment.shop_name}</span>
                        </div>
                        <span class="comment-time">${comment.comment_time}</span>
                    </div>
                    <div class="comment-preview">${comment.comment_content}</div>
                    <div style="text-align: right; margin-top: 15px;">
                        <a href="viewCommentDetail?order_on=${comment.order_on}" class="action-btn">
                            <i class="fa fa-eye"></i> 查看详情
                        </a>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>

<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>