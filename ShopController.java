package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Shop;
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
import java.util.List;

/**
 * 店铺控制器：处理店铺相关的注册、管理、展示等请求
 */
@Controller
public class ShopController {

	@Autowired
	private ShopService shopService;    // 店铺服务层注入
	/**
	 * 卖家店铺管理页面
	 * @param mv ModelAndView对象（设置视图和数据）
	 * @param session HTTP会话（获取当前卖家ID）
	 * @return 包含卖家店铺列表的ModelAndView对象
	 */
	@RequestMapping("shopManage")
	public ModelAndView shopManage(ModelAndView mv, HttpSession session) {
		String seller_id = (String) session.getAttribute("id");
		List<Shop> shops = shopService.getShopsBySeller(seller_id);
		mv.addObject("shops", shops);
		mv.setViewName("seller/shopManage");
		return mv;
	}
	/**
	 * 跳转到店铺注册页面
	 * @param model 模型对象（绑定店铺实体到表单）
	 * @param shop 店铺实体对象（初始化表单数据）
	 * @return 店铺注册表单页面路径
	 */
	@RequestMapping(value = "toRegistShop", method = RequestMethod.GET)
	public String toRegistShop(Model model, Shop shop) {
		model.addAttribute("shop", shop);
		return "seller/registShop";
	}


	/**
	 * 处理店铺注册提交请求
	 * @param shop 绑定表单数据的店铺实体（含注册信息）
	 * @param result 数据校验结果（验证表单输入合法性）
	 * @param session HTTP会话（获取当前卖家ID）
	 * @return 注册结果页面或重定向到店铺管理页
	 */
	@RequestMapping(value = "shopRegist", method = RequestMethod.POST)
	public String registShop(@Valid Shop shop, BindingResult result, HttpSession session) {
		String seller_id = (String) session.getAttribute("id");
		Shop sp = shopService.getShopById(shop.getShop_id());

		// 校验店铺ID是否已存在
		if (sp != null) {
			return "seller/registFail";
		}

		// 校验表单数据，若有错误则返回注册页面
		if (result.hasErrors()) {
			return "seller/registShop";
		}
		// 保存店铺信息（设置卖家ID并插入数据库）
		else {
			String phone = shop.getShop_phone();  // 临时保存手机号
			shop.setSeller_id(seller_id);         // 设置卖家ID
			shop.setShop_phone(phone);            // 恢复手机号

			shopService.insertShop(shop);
			return "redirect:shopManage";  // 注册成功后重定向到店铺管理页
		}
	}


	/**
	 * 展示所有店铺（用户端）
	 * @param mv ModelAndView对象（设置视图和数据）
	 * @return 包含所有店铺列表的ModelAndView对象
	 */
	@RequestMapping("showShop")
	public ModelAndView showShop(ModelAndView mv) {
		List<Shop> shop = shopService.getShop();
		mv.addObject("shoplist", shop);
		mv.setViewName("user/showShop");
		return mv;
	}


	/**
	 * 展示指定ID的店铺详情（骑手端）
	 * @param shop_id 店铺ID（通过请求参数获取）
	 * @param mv ModelAndView对象（设置视图和数据）
	 * @return 包含店铺详情的ModelAndView对象
	 */
	@RequestMapping(value = "getShop", method = RequestMethod.GET)
	public ModelAndView getShop(@RequestParam("shop_id") String shop_id, ModelAndView mv) {
		Shop shop = shopService.getShopById(shop_id);
		mv.addObject("shop", shop);
		mv.setViewName("rider/showShop");
		return mv;
	}
}