<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>已完成订单 - 山中医外卖系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

        /* 统计卡片样式优化 */
        .stats-card {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stats-card::after {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 0 0 0 100%;
        }

        .stats-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
        }

        .stats-card h4 {
            margin-top: 0;
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 500;
        }

        .stats-card h2 {
            margin: 15px 0 0;
            font-size: 2rem;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.1);
        }

        .stats-icon {
            position: absolute;
            bottom: -10px;
            right: 15px;
            font-size: 50px;
            opacity: 0.2;
        }

        /* 已完成订单卡片样式优化 */
        .completed-order {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            padding: 20px;
            transition: all 0.3s ease;
        }

        .completed-order:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.12);
        }

        .order-header {
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 12px;
            margin-bottom: 15px;
            color: var(--dark-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-header strong {
            font-size: 1.1rem;
        }

        .delivery-info {
            background-color: var(--light-color);
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .delivery-info .row div {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .info-icon {
            margin-right: 8px;
            color: var(--primary-color);
            width: 20px;
            text-align: center;
        }

        .page-title {
            color: var(--primary-color);
            font-size: 1.8rem;
            font-weight: 600;
            margin: 20px 0 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--accent-color);
            display: inline-block;
        }

        .empty-message {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            margin-top: 30px;
            color: #666;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .empty-message i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-message h3 {
            color: #555;
            margin-top: 20px;
        }

        .btn-view-detail {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .btn-view-detail:hover {
            background-color: #FF6A14;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
            color: white;
            text-decoration: none;
        }

        .btn-view-detail i {
            margin-right: 5px;
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

            .stats-card {
                padding: 20px;
            }

            .stats-card h2 {
                font-size: 1.8rem;
            }

            .completed-order {
                padding: 15px;
            }

            .order-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .order-header span {
                margin-top: 5px;
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
                margin-bottom: 5px;
            }

            .stats-card h2 {
                font-size: 1.5rem;
            }

            .stats-icon {
                font-size: 40px;
            }
        }

        /* 内容区域样式 */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .content-container {
            padding: 0;
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
    <ul id="Tab" class="nav nav-pills" style="justify-content: center; flex-wrap: wrap;">
        <li><a href="riderManage"><i class="fa fa-user"></i> 我的信息</a></li>
        <li><a href="getStatusFourOrder"><i class="fa fa-list-alt"></i> 可配送订单</a></li>
        <li><a href="getStatusFiveOrder"><i class="fa fa-motorcycle"></i> 正在配送订单</a></li>
        <li><a href="getPendingCompletionOrders"><i class="fa fa-edit"></i> 待完善订单</a></li>
        <li class="active"><a href="completedOrders"><i class="fa fa-check-circle"></i> 已完成订单</a></li>
        <li><a href="riderHome"><i class="fa fa-home"></i> 返回主页</a></li>
    </ul>
</div>

<div class="container content-container">
    <h2 class="page-title">已完成订单记录</h2>

    <!-- 统计信息 -->
    <div class="row">
        <div class="col-md-4 col-sm-6 mb-4">
            <div class="stats-card">
                <h4>总完成订单数</h4>
                <h2 id="totalOrders">${completedOrderCount}</h2>
                <i class="fa fa-clipboard-check stats-icon"></i>
            </div>
        </div>
        <div class="col-md-4 col-sm-6 mb-4">
            <div class="stats-card">
                <h4>总配送距离</h4>
                <h2 id="totalDistance">${totalDistance} km</h2>
                <i class="fa fa-road stats-icon"></i>
            </div>
        </div>
        <div class="col-md-4 col-sm-12 mb-4">
            <div class="stats-card">
                <h4>总配送收入</h4>
                <h2 id="totalEarnings">¥${totalEarnings}</h2>
                <i class="fa fa-money stats-icon"></i>
            </div>
        </div>
    </div>

    <!-- 订单列表 -->
    <div class="row">
        <div class="col-md-12">
            <c:if test="${empty completedOrders}">
                <div class="empty-message">
                    <i class="fa fa-inbox"></i>
                    <h3>暂无已完成的订单</h3>
                    <p class="text-muted">您还没有完成任何订单</p>
                </div>
            </c:if>

            <c:forEach items="${completedOrders}" var="order">
                <div class="completed-order">
                    <div class="order-header">
                        <strong>订单号：${order.orderOn}</strong>
                        <span>
                            完成时间：<fmt:formatDate value="${order.completionTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                    <div class="delivery-info">
                        <div class="row">
                            <div class="col-md-4 col-sm-6">
                                <i class="fa fa-road info-icon"></i>
                                配送距离：${order.deliveryDistance} km
                            </div>
                            <div class="col-md-4 col-sm-6">
                                <i class="fa fa-clock-o info-icon"></i>
                                配送时长：${order.deliveryDuration} 分钟
                            </div>
                            <div class="col-md-4 col-sm-12">
                                <i class="fa fa-money info-icon"></i>
                                配送费：¥${order.deliveryFee}
                            </div>
                        </div>
                        <div class="text-right" style="margin-top: 10px;">
                            <a href="${pageContext.request.contextPath}/getCompletedOrderDetail?orderOn=${order.orderOn}"
                               class="btn-view-detail">
                                <i class="fa fa-info-circle"></i> 查看详情
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    // 为统计卡片添加数字动画效果
    $(document).ready(function() {
        // 检查元素是否在视口中
        function isInViewport(element) {
            const rect = element.getBoundingClientRect();
            return (
                rect.top >= 0 &&
                rect.left >= 0 &&
                rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
                rect.right <= (window.innerWidth || document.documentElement.clientWidth)
            );
        }

        // 数字增长动画
        function animateValue(obj, start, end, duration) {
            let startTimestamp = null;
            const step = (timestamp) => {
                if (!startTimestamp) startTimestamp = timestamp;
                const progress = Math.min((timestamp - startTimestamp) / duration, 1);
                const value = Math.floor(progress * (end - start) + start);

                // 处理带小数的值
                if (obj.id === 'totalDistance' || obj.id === 'totalEarnings') {
                    obj.innerHTML = (value / 100).toFixed(2) + (obj.id === 'totalDistance' ? ' km' : '');
                } else {
                    obj.innerHTML = value;
                }

                if (progress < 1) {
                    window.requestAnimationFrame(step);
                }
            };
            window.requestAnimationFrame(step);
        }

        // 检查并启动动画
        function checkAnimation() {
            const elements = document.querySelectorAll('#totalOrders, #totalDistance, #totalEarnings');
            elements.forEach(element => {
                if (isInViewport(element) && !element.classList.contains('animated')) {
                    element.classList.add('animated');

                    // 获取目标值
                    let target = 0;
                    if (element.id === 'totalDistance' || element.id === 'totalEarnings') {
                        // 移除非数字字符并转换为分（避免小数计算）
                        target = parseInt(element.innerText.replace(/[^\d.]/g, '') * 100);
                    } else {
                        target = parseInt(element.innerText);
                    }

                    // 启动动画
                    animateValue(element, 0, target, 1500);
                }
            });
        }

        // 初始检查
        checkAnimation();

        // 滚动时检查
        window.addEventListener('scroll', checkAnimation);
    });
</script>
</body>
</html>