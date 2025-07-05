<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .detail-card {
            margin: 20px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .detail-item {
            margin: 10px 0;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="detail-card">
        <h2 class="text-center mb-4">订单详情</h2>

        <div class="row">
            <div class="col-md-6">
                <h4>订单信息</h4>
                <div class="detail-item">
                    <span class="detail-label">订单编号：</span>
                    <span>${order.order_on}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">订单状态：</span>
                    <span>已完成</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">商家名称：</span>
                    <span>${order.shop_name}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">配送地址：</span>
                    <span>${order.order_address}</span>
                </div>
            </div>

            <div class="col-md-6">
                <h4>配送信息</h4>
                <div class="detail-item">
                    <span class="detail-label">配送距离：</span>
                    <span>${completedOrder.deliveryDistance} km</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">配送时长：</span>
                    <span>${completedOrder.deliveryDuration} 分钟</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">配送费：</span>
                    <span>¥${completedOrder.deliveryFee}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">完成时间：</span>
                    <span>${completedOrder.completionTime}</span>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="javascript:history.back()" class="btn btn-primary">返回</a>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html> 