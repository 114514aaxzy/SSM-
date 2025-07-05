package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.Seller;
import com.sdutcm.wm.pojo.Shop;
import com.sdutcm.wm.service.OrderService;
import com.sdutcm.wm.service.SellerService;
import com.sdutcm.wm.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
public class SellerController {

	@Autowired
	private SellerService sellerService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ShopService shopService;

	/**
	 * 跳转到卖家主页
	 * @return 卖家主页视图名
	 */
	@RequestMapping("toSellerHomePage")
	public String toHomePage(){
		return "seller/homePage";
	}

	/**
	 * 获取所有卖家信息
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @return 包含所有卖家信息的视图
	 */
	@RequestMapping("getAllSeller")
	public ModelAndView getAllSeller(ModelAndView mv) {
		// 调用SellerService获取所有卖家信息
		List<Seller> seller = sellerService.allSeller();
		// 将卖家列表添加到模型中
		mv.addObject("sellerlist", seller);
		// 设置视图名为"admin/getAllSeller"
		mv.setViewName("admin/getAllSeller");
		return mv;
	}

	/**
	 * 删除卖家
	 * @param seller_id 卖家ID
	 * @return 删除成功或失败的视图名
	 */
	@RequestMapping(value="deleteSeller", method= RequestMethod.GET)
	public String deleteSeller(@RequestParam String seller_id){
		// 调用SellerService删除卖家
		int i = sellerService.deleteSeller(seller_id);
		if(i == 0)
			return "admin/deleteFail";
		else
			return "admin/deleteSuccess";
	}

	/**
	 * 获取当前卖家信息
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 包含当前卖家信息的视图
	 */
	@RequestMapping(value="sellerManageInSeller")
	public ModelAndView getSeller(ModelAndView mv , HttpSession session){
		// 从会话中获取卖家ID
		String seller_id = (String) session.getAttribute("id");
		// 根据卖家ID获取卖家信息
		Seller seller = sellerService.getSeller(seller_id);
		// 将卖家信息添加到模型中
		mv.addObject("seller", seller);
		// 设置视图名为"seller/sellerManage"
		mv.setViewName("seller/sellerManage");
		return mv;
	}

	/**
	 * 卖家订单管理
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 包含卖家订单管理信息的视图
	 */
	@RequestMapping(value="orderManageInSeller", method=RequestMethod.GET)
	public ModelAndView orderManageInSeller(ModelAndView mv, HttpSession session) {
		// 从会话中获取卖家ID
		String seller_id = (String) session.getAttribute("id");
		System.out.println("Current seller_id from session: " + seller_id);

		// 根据卖家ID获取卖家信息
		Seller seller = sellerService.getSeller(seller_id);
		if(seller != null) {
			// 获取该卖家的所有店铺
			List<Shop> shops = shopService.getShopsBySeller(seller_id);
			if(shops != null && !shops.isEmpty()) {
				// 用于存储所有店铺的订单
				List<Order> allOrders = new ArrayList<>();

				// 获取所有店铺的订单
				for(Shop shop : shops) {
					String shop_id = shop.getShop_id();
					System.out.println("Processing orders for shop_id: " + shop_id);
					List<Order> shopOrders = orderService.getOrderByShop(shop_id);
					if(shopOrders != null) {
						allOrders.addAll(shopOrders);
					}
				}

				System.out.println("Total orders found across all shops: " + allOrders.size());

				// 按状态分类订单
				List<Order> pendingOrders = new ArrayList<>();    // 待处理订单（状态1）
				List<Order> processingOrders = new ArrayList<>(); // 正在处理订单（状态3）
				List<Order> readyOrders = new ArrayList<>();      // 准备完成订单（状态4）
				List<Order> deliveringOrders = new ArrayList<>(); // 正在配送订单（状态5）
				List<Order> completedOrders = new ArrayList<>();  // 已完成订单（状态6）
				List<Order> rejectedOrders = new ArrayList<>();   // 已拒绝订单（状态2）

				for(Order order : allOrders) {
					System.out.println("Processing order: " + order.getOrder_on() + ", status: " + order.getOrder_status());
					switch(order.getOrder_status()) {
						case 1: pendingOrders.add(order); break;
						case 2: rejectedOrders.add(order); break;
						case 3: processingOrders.add(order); break;
						case 4: readyOrders.add(order); break;
						case 5: deliveringOrders.add(order); break;
						case 6: completedOrders.add(order); break;
					}
				}

				// 添加店铺信息到ModelAndView
				mv.addObject("shops", shops);

				// 添加各类订单到ModelAndView
				mv.addObject("pendingOrders", pendingOrders);
				mv.addObject("processingOrders", processingOrders);
				mv.addObject("readyOrders", readyOrders);
				mv.addObject("deliveringOrders", deliveringOrders);
				mv.addObject("completedOrders", completedOrders);
				mv.addObject("rejectedOrders", rejectedOrders);
			} else {
				System.out.println("No shops found for seller_id: " + seller_id);
			}
		} else {
			System.out.println("No seller found for seller_id: " + seller_id);
		}

		mv.setViewName("seller/orderManage");
		return mv;
	}

	/**
	 * 更新订单状态
	 * @param order_on 订单编号
	 * @param status 新状态
	 * @return 重定向到订单管理页面
	 */
	@RequestMapping(value="updateOrderStatus", method=RequestMethod.POST)
	public String updateOrderStatus(@RequestParam String order_on, @RequestParam int status) {
		// 根据订单编号获取订单
		Order order = orderService.getOrderByOn(order_on);
		if(order != null) {
			// 更新订单状态
			order.setOrder_status(status);
			orderService.updateOrder(order);
		}
		return "redirect:orderManageInSeller";
	}

	/**
	 * 跳转到更新卖家信息页面
	 * @param session 当前会话
	 * @param model Model对象，用于添加模型数据
	 * @return 更新卖家信息页面视图名
	 */
	@RequestMapping(value="toUpdateSeller", method=RequestMethod.GET)
	public String toUpdate(HttpSession session, Model model){
		// 从会话中获取卖家ID
		String seller_id = (String) session.getAttribute("id");
		// 根据卖家ID获取卖家信息
		Seller seller = sellerService.getSeller(seller_id);
		// 将卖家信息添加到模型中
		model.addAttribute("seller", seller);
		return "seller/updateSeller";
	}

	/**
	 * 更新卖家信息
	 * @param seller 卖家对象，包含更新后的卖家信息
	 * @param result BindingResult对象，用于检查卖家输入的合法性
	 * @return 更新成功或失败的视图名
	 */
	@RequestMapping(value="updateSeller", method=RequestMethod.POST)
	public String update(@Valid Seller seller, BindingResult result){
		if(result.hasErrors())
			return "seller/updateSeller";
		else{
			// 调用SellerService更新卖家信息
			int i = sellerService.updateSeller(seller);
			if(i == 0)
				return "seller/updateFail";
			else
				return "seller/updateSuccess";
		}
	}

}