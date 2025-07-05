package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Cart;
import com.sdutcm.wm.pojo.Food;
import com.sdutcm.wm.service.CartService;
import com.sdutcm.wm.service.FoodService;
import com.sdutcm.wm.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {
	// 自动注入CartService，用于处理购物车相关业务逻辑
	@Autowired
	private CartService cartService;
	// 自动注入FoodService，用于处理食品相关业务逻辑
	@Autowired
	private FoodService foodService;
	// 自动注入ShopService，用于处理店铺相关业务逻辑
	@Autowired
	private ShopService shopService;

	/**
	 * 添加商品到购物车
	 * @param food_id 商品ID
	 * @param shop_id 店铺ID
	 * @param session 当前会话
	 * @return 重定向到店铺页面
	 */
	@RequestMapping(value = "addCart", method = RequestMethod.GET)
	public String addCart(@RequestParam String food_id, @RequestParam String shop_id, HttpSession session) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 根据用户ID获取购物车列表
		List<Cart> cartlist = cartService.getCart(user_id);
		// 根据店铺ID获取店铺名称
		String shop_name = shopService.getShopName(shop_id);

		// 如果购物车为空
		if ((cartlist == null) || cartlist.isEmpty()) {
			// 根据商品ID和店铺ID获取商品信息
			Food food = foodService.getFood(food_id, shop_id);
			// 创建一个新购物车项
			Cart cart = new Cart();
			cart.setCart_num(1); // 设置购物车数量为1
			cart.setCart_total(food.getFood_price()); // 设置购物车总价为商品价格
			cart.setFood_id(food_id); // 设置商品ID
			cart.setFood_name(food.getFood_name()); // 设置商品名称
			cart.setFood_price(food.getFood_price()); // 设置商品价格
			cart.setShop_id(shop_id); // 设置店铺ID
			cart.setUser_id(user_id); // 设置用户ID
			cart.setShop_name(shop_name); // 设置店铺名称
			// 将购物车项插入数据库
			cartService.insertCart(cart);
		} else {
			// 如果购物车中已有商品，且店铺ID与当前添加的商品店铺ID不同
			if (!(cartlist.get(0).getShop_id()).equals(shop_id)) {
				// 删除该用户的所有购物车项
				cartService.deleteCartUser(user_id);
				// 获取商品信息
				Food food = foodService.getFood(food_id, shop_id);
				// 创建新购物车项
				Cart cart = new Cart();
				cart.setCart_num(1);
				cart.setCart_total(food.getFood_price());
				cart.setFood_id(food_id);
				cart.setFood_name(food.getFood_name());
				cart.setFood_price(food.getFood_price());
				cart.setShop_id(shop_id);
				cart.setUser_id(user_id);
				cart.setShop_name(shop_name);
				// 插入购物车项
				cartService.insertCart(cart);
			} else {
				// 如果购物车中已有该商品
				Cart cart = cartService.getCartByID(food_id, shop_id, user_id);
				if (cart == null) {
					// 创建新购物车项
					Cart ca = new Cart();
					Food food = foodService.getFood(food_id, shop_id);
					ca.setCart_num(1);
					ca.setCart_total(food.getFood_price());
					ca.setFood_id(food_id);
					ca.setFood_name(food.getFood_name());
					ca.setFood_price(food.getFood_price());
					ca.setShop_id(shop_id);
					ca.setUser_id(user_id);
					ca.setShop_name(shop_name);
					// 插入购物车项
					cartService.insertCart(ca);
				} else {
					// 如果购物车中已有该商品，数量加1
					int k = cart.getCart_num();
					cart.setCart_num(++k);
					cart.setCart_total(cart.getCart_num() * cart.getFood_price());
					// 更新购物车项
					cartService.updateCart(cart);
				}
			}
		}
		// 重定向到店铺页面
		return "redirect:showFood?shop_id=" + shop_id;
	}

	/**
	 * 查看购物车
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 购物车页面
	 */
	@RequestMapping(value = "myCart", method = RequestMethod.GET)
	public ModelAndView myCart(ModelAndView mv, HttpSession session) {
		// 根据用户ID获取购物车列表
		List<Cart> cart = cartService.getCart((String) session.getAttribute("id"));
		double totalprice = 0; // 初始化总价为0
		// 遍历购物车列表，计算总价
		for (Cart list : cart)
			totalprice += list.getCart_total();
		// 将总价和购物车列表添加到模型中
		mv.addObject("totalprice", totalprice);
		mv.addObject("cartlist", cart);
		// 设置视图名为"user/myCart"
		mv.setViewName("user/myCart");
		return mv;
	}

	/**
	 * 修改购物车商品数量
	 * @param param 操作类型，"add"表示增加，"minus"表示减少
	 * @param cart_id 购物车项ID
	 * @param session 当前会话
	 * @return 重定向到购物车页面
	 */
	@RequestMapping(value = "changeCart", method = RequestMethod.GET)
	public ModelAndView changeNum(@RequestParam String param, @RequestParam String cart_id,
								  HttpSession session) {
		// 根据购物车项ID获取购物车项
		Cart cart = cartService.getCartByCart(cart_id);
		if (param.equals("add")) {
			// 如果操作类型为增加，数量加1
			cart.setCart_num(cart.getCart_num() + 1);
			cart.setCart_total(cart.getFood_price() * cart.getCart_num());
			// 更新购物车项
			cartService.updateCart(cart);
		}

		if (param.equals("minus")) {
			// 如果操作类型为减少
			if (cart.getCart_num() <= 1) {
				// 如果数量为1，删除购物车项
				cartService.deleteCartByID(cart_id);
			} else {
				// 否则，数量减1
				cart.setCart_num(cart.getCart_num() - 1);
				cart.setCart_total(cart.getFood_price() * cart.getCart_num());
				// 更新购物车项
				cartService.updateCart(cart);
			}
		}
		// 重定向到购物车页面
		return new ModelAndView("redirect:myCart", (HttpStatus) null);
	}

	/**
	 * 购物车结算
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 结算页面
	 */
	@RequestMapping(value = "account", method = RequestMethod.GET)
	public ModelAndView account(ModelAndView mv, HttpSession session) {
		// 根据用户ID获取购物车列表
		List<Cart> cart = cartService.getCart((String) session.getAttribute("id"));
		double totalprice = 0; // 初始化总价为0
		// 遍历购物车列表，计算总价
		for (Cart list : cart)
			totalprice += list.getCart_total();
		// 将总价和购物车列表添加到模型中
		mv.addObject("totalprice", totalprice);
		mv.addObject("cartlist", cart);
		// 设置视图名为"user/account"
		mv.setViewName("user/account");
		return mv;
	}

}