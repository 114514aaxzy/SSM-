package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.Rider;
import com.sdutcm.wm.pojo.RiderCompletedOrder;
import com.sdutcm.wm.service.OrderService;
import com.sdutcm.wm.service.RiderService;
import com.sdutcm.wm.service.RiderCompletedOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * 骑手控制器，处理骑手相关的HTTP请求
 */
@Controller
public class RiderController {

	@Autowired
	private RiderService riderService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private RiderCompletedOrderService riderCompletedOrderService;

	/**
	 * 获取所有骑手信息，返回给管理员页面
	 * @param mv ModelAndView对象，用于设置视图和数据
	 * @return 包含骑手列表的ModelAndView对象
	 */
	@RequestMapping("getAllRider")
	public ModelAndView getAllRider(ModelAndView mv){
		List<Rider> rider = riderService.allRider();
		mv.addObject("riderlist", rider);
		mv.setViewName("admin/getAllRider");
		return mv;
	}

	/**
	 * 删除指定ID的骑手
	 * @param rider_id 骑手ID
	 * @return 删除成功或失败的视图名称
	 */
	@RequestMapping(value="deleteRider", method= RequestMethod.GET)
	public String deleteRider(@RequestParam String rider_id){
		int i = riderService.deleteRider(rider_id);
		if(i == 0)
			return "admin/deleteFail";
		else return "admin/deleteSuccess";
	}

	/**
	 * 骑手管理页面，显示骑手个人信息
	 * @param mv ModelAndView对象
	 * @param session HTTP会话，用于获取当前登录骑手ID
	 * @return 包含骑手信息的ModelAndView对象
	 */
	@RequestMapping(value="riderManage", method=RequestMethod.GET)
	public ModelAndView riderManage(ModelAndView mv, HttpSession session) {
		String rider_id = (String) session.getAttribute("id");
		Rider rider = riderService.getRider(rider_id);
		mv.addObject("rider", rider);
		mv.setViewName("rider/riderManage");
		return mv;
	}

	/**
	 * 获取状态为4（待分配）的订单列表
	 * @param mv ModelAndView对象
	 * @return 包含待分配订单列表的ModelAndView对象
	 */
	@RequestMapping(value="getStatusFourOrder", method=RequestMethod.GET)
	public ModelAndView getStatusFourOrder(ModelAndView mv) {
		// 获取状态为4的订单并获取所有相关的订单
		List<Order> orderlist = orderService.getOrderAllByStatus(4);
		mv.addObject("orderlist", orderlist);
		mv.setViewName("rider/statusFourOrder");
		return mv;
	}

	/**
	 * 获取状态为5（已分配给当前骑手）的订单列表
	 * @param mv ModelAndView对象
	 * @param session HTTP会话，用于获取当前骑手ID
	 * @return 包含已分配订单列表的ModelAndView对象
	 */
	@RequestMapping(value="getStatusFiveOrder", method=RequestMethod.GET)
	public ModelAndView getStatusFiveOrder(ModelAndView mv, HttpSession session) {
		String rider_id = (String) session.getAttribute("id");
		// 获取状态为5的订单并获取所有相关的订单
		List<Order> allOrders = orderService.getOrderAllByStatus(5);
		mv.addObject("orderlist", allOrders);
		mv.setViewName("rider/statusFiveOrder");
		return mv;
	}

	/**
	 * 骑手抢单功能
	 * @param order_on 订单编号
	 * @param session HTTP会话，用于获取当前骑手ID
	 * @return 重定向到待分配订单列表页面
	 */
	@RequestMapping(value="grabOrder", method=RequestMethod.GET)
	public String grabOrder(String order_on, HttpSession session) {
		String rider_id = (String) session.getAttribute("id");
		Order order = orderService.getOrderByOn(order_on);
		if(order != null && order.getOrder_status() == 4) {
			order.setRider_id(rider_id);
			order.setOrder_status(5); // 将状态改为已分配
			orderService.updateOrder(order);
		}
		return "redirect:getStatusFourOrder";
	}

	/**
	 * 骑手首页
	 * @return 骑手首页视图名称
	 */
	@RequestMapping(value="riderHome", method=RequestMethod.GET)
	public String riderHome() {
		return "rider/riderHome";
	}

	// 添加别名映射，保持向后兼容
	@RequestMapping(value="toRiderHomePage", method=RequestMethod.GET)
	public String toRiderHomePage() {
		return "redirect:riderHome";
	}

	/**
	 * 跳转到骑手信息更新页面
	 * @param session HTTP会话，用于获取当前骑手ID
	 * @param model 模型对象，用于传递骑手信息到视图
	 * @return 骑手信息更新页面视图名称
	 */
	@RequestMapping(value="toUpdateRider", method=RequestMethod.GET)
	public String toUpdate(HttpSession session, Model model) {
		String rider_id = (String) session.getAttribute("id");
		Rider rider = riderService.getRider(rider_id);
		model.addAttribute("rider", rider);
		return "rider/updateRider";
	}

	/**
	 * 更新骑手信息
	 * @param rider 包含更新信息的骑手对象
	 * @param result 数据绑定结果，用于验证数据
	 * @return 更新成功或失败的视图名称
	 */
	@RequestMapping(value="updateRider", method=RequestMethod.POST)
	public String update(@Valid Rider rider, BindingResult result){
		if(result.hasErrors())
			return "rider/updateRider";
		else{
			int i = riderService.updateRider(rider);
			if(i == 0)
				return "rider/updateFail";
			else return "rider/updateSuccess";
		}
	}

	/**
	 * 获取骑手已完成订单统计信息和列表
	 * @param mv ModelAndView对象
	 * @param session HTTP会话，用于获取当前骑手ID
	 * @return 包含已完成订单信息的ModelAndView对象
	 */
	@RequestMapping(value="completedOrders", method=RequestMethod.GET)
	public ModelAndView completedOrders(ModelAndView mv, HttpSession session) {
		String riderId = (String) session.getAttribute("id");

		// 获取统计数据
		List<RiderCompletedOrder> completedOrders = riderCompletedOrderService.getCompletedOrdersByRider(riderId);
		Double totalEarnings = riderCompletedOrderService.getTotalEarningsByRider(riderId);
		Double totalDistance = riderCompletedOrderService.getTotalDistanceByRider(riderId);
		Integer completedOrderCount = riderCompletedOrderService.getCompletedOrderCountByRider(riderId);

		// 添加到ModelAndView
		mv.addObject("completedOrders", completedOrders);
		mv.addObject("totalEarnings", totalEarnings);
		mv.addObject("totalDistance", totalDistance);
		mv.addObject("completedOrderCount", completedOrderCount);
		mv.setViewName("rider/completedOrders");

		return mv;
	}

	/**
	 * 骑手完成订单的API接口
	 * @param order 包含完成订单信息的对象
	 * @param session HTTP会话，用于获取当前骑手ID
	 * @return 包含操作结果的JSON对象
	 */
	@RequestMapping(value="/api/rider/completed-orders/complete", method=RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> completeOrder(@RequestBody RiderCompletedOrder order, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		String riderId = (String) session.getAttribute("id");

		try {
			// 验证数据
			if (order.getDeliveryDistance() <= 0 ||
					order.getDeliveryDuration() <= 0 ||
					order.getDeliveryFee() <= 0) {
				response.put("success", false);
				response.put("message", "配送信息不能为负数或零");
				return response;
			}

			// 更新订单状态为已完成
			Order existingOrder = orderService.getOrderByOn(order.getOrderOn());
			if (existingOrder != null && (existingOrder.getOrder_status() == 5 || existingOrder.getOrder_status() == 7)) {
				// 设置骑手ID
				order.setRiderId(riderId);
				order.setCompletionTime(new Date());

				// 记录配送完成信息
				boolean success = riderCompletedOrderService.completeOrder(order);

				if (success) {
					// 更新原订单状态
					existingOrder.setOrder_status(6); // 设置为已完成
					orderService.updateOrder(existingOrder);

					response.put("success", true);
					response.put("message", "订单已完成");
				} else {
					response.put("success", false);
					response.put("message", "保存配送记录失败");
				}
			} else {
				response.put("success", false);
				response.put("message", "订单状态不正确或订单不存在");
			}
		} catch (Exception e) {
			e.printStackTrace(); // 记录错误日志
			response.put("success", false);
			response.put("message", "系统错误：" + e.getMessage());
		}

		return response;
	}

	/**
	 * 获取已完成订单的详细信息
	 * @param orderOn 订单编号
	 * @param mv ModelAndView对象
	 * @return 包含订单详细信息的ModelAndView对象
	 */
	@RequestMapping(value="getCompletedOrderDetail", method=RequestMethod.GET)
	public ModelAndView getCompletedOrderDetail(@RequestParam String orderOn, ModelAndView mv) {
		// 获取完成订单记录
		RiderCompletedOrder completedOrder = riderCompletedOrderService.getCompletedOrderByOrderOn(orderOn);

		// 获取原始订单信息
		Order order = orderService.getOrderByOn(orderOn);

		mv.addObject("completedOrder", completedOrder);
		mv.addObject("order", order);
		mv.setViewName("rider/orderDetail");
		return mv;
	}

	/**
	 * 获取待确认完成的订单列表（状态为7）
	 * @param session HTTP会话，用于获取当前骑手ID
	 * @param model 模型对象，用于传递订单列表到视图
	 * @return 待确认完成订单列表页面视图名称
	 */
	@RequestMapping(value="getPendingCompletionOrders", method=RequestMethod.GET)
	public String getPendingCompletionOrders(HttpSession session, Model model) {
		String riderId = (String) session.getAttribute("id");
		List<Order> pendingOrders = orderService.getOrdersByStatusAndRider(7, riderId);
		model.addAttribute("orderlist", pendingOrders);
		return "rider/pendingCompletionOrders";
	}

}