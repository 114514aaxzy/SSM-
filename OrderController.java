package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Cart;
import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.User;
import com.sdutcm.wm.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Controller
public class OrderController {
	// 自动注入OrderService，用于处理订单相关业务逻辑
	@Autowired
	private OrderService orderService;
	// 自动注入ShopService，用于处理店铺相关业务逻辑
	@Autowired
	private ShopService shopService;
	// 自动注入UserService，用于处理用户相关业务逻辑
	@Autowired
	private UserService userService;
	// 自动注入CartService，用于处理购物车相关业务逻辑
	@Autowired
	private CartService cartService;
	// 自动注入OrderItemService，用于处理订单项相关业务逻辑
	@Autowired
	private OrderItemService orderItemService;

	/**
	 * 获取用户的订单列表
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 包含用户订单列表的视图
	 */
	@RequestMapping(value = "getUserOrder", method = RequestMethod.GET)
	public ModelAndView getUserOrder(ModelAndView mv, HttpSession session) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 调用OrderService获取用户的订单列表
		List<Order> orderList = orderService.getOrderAllByUser(user_id);
		// 将订单列表添加到模型中
		mv.addObject("Userorder", orderList);
		// 设置视图名为"user/getOrder"
		mv.setViewName("user/getOrder");
		return mv;
	}

	/**
	 * 获取用户的所有配送中订单
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 包含用户所有配送中订单的视图
	 */
	@RequestMapping(value = "getSendOrder", method = RequestMethod.GET)
	public ModelAndView getSendOrder(ModelAndView mv, HttpSession session) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		System.out.println("Getting sending orders for user_id: " + user_id);

		// 调用OrderService获取用户的订单列表
		List<Order> allOrders = orderService.getOrderAllByUser(user_id);
		System.out.println("Total orders found: " + (allOrders != null ? allOrders.size() : 0));

		// 创建一个列表用于存储配送中订单
		List<Order> sendingOrders = new ArrayList<>();

		// 筛选状态为3(已接单)、4(可取货)、5(已送出)的订单
		if (allOrders != null) {
			for (Order order : allOrders) {
				int status = order.getOrder_status();
				System.out.println("Order " + order.getOrder_on() + " status: " + status);
				if (status >= 3 && status <= 5) {
					sendingOrders.add(order);
				}
			}
		}

		System.out.println("Sending orders found: " + sendingOrders.size());
		// 将配送中订单列表添加到模型中
		mv.addObject("Userorder", sendingOrders);
		// 设置视图名为"user/getSendOrder"
		mv.setViewName("user/getSendOrder");
		return mv;
	}

	/**
	 * 支付订单
	 * @param order_address 订单地址
	 * @param session 当前会话
	 * @return 支付成功或失败的视图名
	 */
	@RequestMapping(value = "payOrder", method = RequestMethod.POST)
	public String payOrder(String order_address, HttpSession session) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 根据用户ID获取用户信息
		User user = userService.getUser(user_id);
		// 根据用户ID获取购物车列表
		List<Cart> cart = cartService.getCart(user_id);
		double totalprice = 0;

		// 计算购物车总价
		for (Cart list : cart)
			totalprice += list.getCart_total();
		// 如果用户余额不足
		if (totalprice > user.getUser_balance())
			return "user/payFail";

		else {
			// 修改：使用正确的java.sql.Timestamp
			Timestamp date = new Timestamp(System.currentTimeMillis());
			int i = (int) (Math.random() * 900 + 100);
			String order_on = date.toString() + i;

			// 调用OrderService创建订单
			orderService.buildOrder(date, order_on, order_address, totalprice, cart.get(0), user_id);
			// 调用OrderItemService创建订单项
			orderItemService.buildOrderItem(cart, order_on);
			// 删除用户购物车中的商品
			cartService.deleteCartUser(user_id);
			// 更新用户余额
			user.setUser_balance(user.getUser_balance() - totalprice);
			userService.updateUser(user);
			return "user/paySuccess";
		}
	}

	/**
	 * 确认收货
	 * @param order_on 订单编号
	 * @return 重定向到配送中订单页面
	 */
	@RequestMapping(value = "arrive", method = RequestMethod.GET)
	public String arrive(@RequestParam String order_on) {
		// 获取订单
		Order order = orderService.getOrderByOn(order_on);
		if (order != null) {
			// 更新订单状态为用户已确认收货但等待骑手填写配送信息(7)
			order.setOrder_status(7);
			orderService.updateOrder(order);
			System.out.println("Order " + order_on + " has been confirmed by user, waiting for rider details");
		} else {
			System.out.println("Order " + order_on + " not found");
		}

		// 重定向到配送中订单页面
		return "redirect:getSendOrder";
	}

}