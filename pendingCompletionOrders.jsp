<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>待完善配送信息订单</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
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

        /* 内容区域样式 */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .content-container {
            padding: 0;
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

        /* 订单卡片样式 */
        .order-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.12);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--accent-color);
            margin-bottom: 15px;
        }

        .order-header h5 {
            margin: 0;
            color: var(--dark-color);
            font-size: 1.1rem;
            font-weight: 600;
        }

        .order-body p {
            margin: 8px 0;
            color: #666;
            display: flex;
            align-items: center;
        }

        .order-body i {
            margin-right: 10px;
            color: var(--primary-color);
            width: 20px;
            text-align: center;
        }

        /* 按钮样式 */
        .btn-complete {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .btn-complete:hover {
            background-color: #FF6A14;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 126, 46, 0.3);
        }

        /* 模态框样式 */
        .modal-content {
            border-radius: 12px;
            border: none;
        }

        .modal-header {
            background-color: var(--primary-color);
            color: white;
            border-radius: 12px 12px 0 0;
            border: none;
        }

        .modal-title {
            font-weight: 600;
        }

        .form-group label {
            color: #666;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 10px;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(255, 126, 46, 0.25);
        }

        /* 空状态样式 */
        .empty-message {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-top: 30px;
        }

        .empty-message i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-message h4 {
            color: #666;
            margin: 15px 0;
        }

        /* 响应式设计 */
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
        <li class="active"><a href="getPendingCompletionOrders"><i class="fa fa-edit"></i> 待完善订单</a></li>
        <li><a href="completedOrders"><i class="fa fa-check-circle"></i> 已完成订单</a></li>
        <li><a href="riderHome"><i class="fa fa-home"></i> 返回主页</a></li>
    </ul>
</div>

<!-- 内容区域 -->
<div class="container content-container">
    <h2 class="page-title">待完善配送信息订单</h2>

    <c:if test="${empty orderlist}">
        <div class="empty-message">
            <i class="fa fa-clipboard"></i>
            <h4>暂无待完善的订单</h4>
            <p class="text-muted">当前没有需要填写配送信息的订单</p>
        </div>
    </c:if>

    <c:forEach items="${orderlist}" var="order">
        <div class="order-card">
            <div class="order-header">
                <h5>订单号：${order.order_on}</h5>
                <span class="text-muted">商家：${order.shop_name}</span>
            </div>
            <div class="order-body">
                <p><i class="fa fa-map-marker"></i> 配送地址：${order.order_address}</p>
                <p><i class="fa fa-money"></i> 订单金额：¥${order.order_price}</p>
                <button class="btn-complete" onclick="showCompletionForm('${order.order_on}')">
                    <i class="fa fa-edit"></i> 填写配送信息
                </button>
            </div>
        </div>
    </c:forEach>
</div>

<!-- 完成订单模态框 -->
<div class="modal fade" id="completeOrderModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">填写配送信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="completeOrderForm">
                    <input type="hidden" id="orderOn" name="orderOn">
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
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="submitCompleteOrder">提交</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    function showCompletionForm(orderOn) {
        $('#orderOn').val(orderOn);
        $('#completeOrderModal').modal('show');
    }

    $(document).ready(function() {
        $('#submitCompleteOrder').click(function() {
            const formData = {
                orderOn: $('#orderOn').val(),
                deliveryDistance: parseFloat($('#deliveryDistance').val()),
                deliveryDuration: parseInt($('#deliveryDuration').val()),
                deliveryFee: parseFloat($('#deliveryFee').val())
            };

            // 表单验证
            if (isNaN(formData.deliveryDistance) || formData.deliveryDistance <= 0) {
                alert('配送距离需为大于0的有效数字');
                return;
            }
            if (isNaN(formData.deliveryDuration) || formData.deliveryDuration <= 0) {
                alert('配送时长需为大于0的有效整数');
                return;
            }
            if (isNaN(formData.deliveryFee) || formData.deliveryFee <= 0) {
                alert('配送费需为大于0的有效数字');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/api/rider/completed-orders/complete',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    if (response.success) {
                        alert('配送信息已保存！');
                        $('#completeOrderModal').modal('hide');
                        location.reload();
                    } else {
                        alert('保存失败：' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('系统错误：' + error);
                    console.error('Error:', xhr.responseText);
                }
            });
        });

        // 实时验证表单
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