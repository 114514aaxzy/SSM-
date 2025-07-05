package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.OrderItem;
import com.sdutcm.wm.service.OrderItemService;
import com.sdutcm.wm.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class OrderItemController {

	@Autowired
	private OrderItemService orderItemService;

	@Autowired
	private OrderService orderService;

	/**
	 * 获取订单项信息（管理员视角）
	 * @param order_on 订单编号
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @return 包含订单项信息的视图
	 */
	@RequestMapping(value="getItem",method= RequestMethod.GET)
	public ModelAndView getOrderItem(@RequestParam String order_on, ModelAndView mv){
		// 调用OrderItemService获取订单项列表
		List<OrderItem> itemlist = orderItemService.getOrderItem(order_on);
		// 将订单项列表添加到模型中
		mv.addObject("orderitem", itemlist);
		// 设置视图名为"admin/getItem"
		mv.setViewName("admin/getItem");
		return mv;
	}

	/**
	 * 获取订单项信息（商家视角）
	 * @param order_on 订单编号
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @return 包含订单项信息的视图
	 */
	@RequestMapping(value="getItemShop", method=RequestMethod.GET)
	public ModelAndView getOrderItemShop(@RequestParam String order_on, ModelAndView mv){
		// 调用OrderItemService获取订单项列表
		List<OrderItem> item = orderItemService.getOrderItem(order_on);
		// 将订单项列表添加到模型中
		mv.addObject("orderitem", item);
		// 设置视图名为"seller/getItem"
		mv.setViewName("seller/getItem");
		return mv;
	}

	/**
	 * 获取订单项信息（用户视角）
	 * @param order_on 订单编号
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @return 包含订单项信息的视图
	 */
	@RequestMapping(value="getUserItem",method=RequestMethod.GET)
	public ModelAndView getUserOrderItem(@RequestParam String order_on, ModelAndView mv){
		System.out.println("Getting order items for order_on: " + order_on);

		// 获取订单信息
		Order order = orderService.getOrderByOn(order_on);
		mv.addObject("order", order);

		// 获取订单项列表
		List<OrderItem> itemlist = orderItemService.getOrderItem(order_on);
		System.out.println("Found items: " + (itemlist != null ? itemlist.size() : 0));
		if(itemlist != null && !itemlist.isEmpty()) {
			for(OrderItem item : itemlist) {
				System.out.println("Item: " + item.getFood_name() + ", Price: " + item.getFood_price() + ", Quantity: " + item.getFood_num());
			}
		}
		mv.addObject("orderitem", itemlist);
		mv.setViewName("user/getItem");
		return mv;
	}
}