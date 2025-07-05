<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>山中医外卖系统 - 账户充值</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style>
		/* 全局样式重置与基础设置 */
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: "Microsoft YaHei", sans-serif;
		}
		body {
			background-color: #fff;
			color: #333;
		}
		a {
			text-decoration: none;
			color: inherit;
		}

		/* 顶部导航栏样式 */
		.top-nav {
			display: flex;
			align-items: center;
			padding: 10px 20px;
			background-color: #ff8000;
		}
		.top-nav .btn-group {
			display: flex;
			gap: 10px;
		}
		.top-nav .btn {
			background-color: #fff;
			color: #ff8000;
			padding: 8px 16px;
			border-radius: 20px;
			font-size: 14px;
			cursor: pointer;
			border: none;
		}
		.top-nav .btn:hover {
			opacity: 0.9;
		}

		/* 主内容容器样式 */
		.container {
			width: 90%;
			max-width: 1200px;
			margin: 30px auto;
			background-color: #fff;
			border-radius: 8px;
			padding: 20px;
		}

		/* 标题样式 */
		.container h2 {
			font-size: 20px;
			color: #ff8000;
			border-left: 4px solid #ff8000;
			padding-left: 10px;
			margin-bottom: 20px;
		}

		/* 选项组通用样式 */
		.form-group {
			margin-bottom: 25px;
		}
		.form-group label {
			display: block;
			margin-bottom: 8px;
			font-size: 14px;
			color: #666;
		}

		/* 充值金额选项样式 */
		.amount-radio-group {
			display: flex;
			gap: 15px;
			flex-wrap: wrap;
		}
		.amount-radio-group .radio-item {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			width: 100px;
			height: 36px;
			border: 1px solid #ddd;
			border-radius: 4px;
			cursor: pointer;
			transition: all 0.3s ease;
		}
		.amount-radio-group .radio-item input {
			display: none;
		}
		.amount-radio-group .radio-item span {
			font-size: 14px;
		}
		.amount-radio-group .radio-item:hover {
			border-color: #ff8000;
		}
		.amount-radio-group .radio-item input:checked + span {
			color: #ff8000;
			font-weight: bold;
		}

		/* 充值方式选项样式 */
		.payway-radio-group {
			display: flex;
			gap: 15px;
			flex-wrap: wrap;
		}
		.payway-radio-group .radio-item {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			width: 120px;
			height: 40px;
			border: 1px solid #ddd;
			border-radius: 4px;
			cursor: pointer;
			transition: all 0.3s ease;
		}
		.payway-radio-group .radio-item input {
			display: none;
		}
		.payway-radio-group .radio-item span {
			font-size: 14px;
		}
		.payway-radio-group .radio-item:hover {
			border-color: #ff8000;
		}
		.payway-radio-group .radio-item input:checked + span {
			color: #ff8000;
			font-weight: bold;
		}

		/* 确认充值按钮样式 */
		.confirm-btn {
			display: block;
			width: 180px;
			height: 44px;
			line-height: 44px;
			text-align: center;
			background-color: #ff8000;
			color: #fff;
			border-radius: 22px;
			font-size: 16px;
			margin: 0 auto;
			cursor: pointer;
			border: none;
			transition: all 0.3s ease;
		}
		.confirm-btn:hover {
			opacity: 0.9;
			transform: translateY(-2px);
		}

		/* 响应式适配 */
		@media (max-width: 768px) {
			.amount-radio-group {
				gap: 10px;
			}
			.amount-radio-group .radio-item {
				width: calc(50% - 5px);
			}
			.payway-radio-group {
				gap: 10px;
			}
			.payway-radio-group .radio-item {
				width: calc(50% - 5px);
			}
		}
	</style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="top-nav">
	<div class="btn-group">
		<button class="btn">账户充值</button>
		<a href="toUserHomePage" class="btn">返回</a>
	</div>
</div>

<!-- 主内容容器 -->
<div class="container">
	<h2>账户充值</h2>
	<form action="deposit" method="post">
		<!-- 充值金额选项 -->
		<div class="form-group">
			<label>充值金额</label>
			<div class="amount-radio-group">
				<label class="radio-item">
					<input type="radio" name="balance" value="0.5" />
					<span>0.5元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="1.0" />
					<span>1.0元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="2.0" />
					<span>2.0元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="5.0" />
					<span>5.0元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="10.0" />
					<span>10元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="20.0" />
					<span>20元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="50.0" />
					<span>50元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="100.0" />
					<span>100元</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="balance" value="500.0" />
					<span>500元</span>
				</label>
			</div>
		</div>

		<!-- 充值方式选项 -->
		<div class="form-group">
			<label>充值方式</label>
			<div class="payway-radio-group">
				<label class="radio-item">
					<input type="radio" name="payway" value="微信" />
					<span>微信支付</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="payway" value="支付宝" />
					<span>支付宝支付</span>
				</label>
				<label class="radio-item">
					<input type="radio" name="payway" value="银行卡" />
					<span>银行卡支付</span>
				</label>
			</div>
		</div>

		<!-- 确认充值按钮 -->
		<button type="submit" class="confirm-btn">确认充值</button>
	</form>
</div>
</body>
</html>