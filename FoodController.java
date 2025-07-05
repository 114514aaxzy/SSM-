package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Food;
import com.sdutcm.wm.pojo.Shop;
import com.sdutcm.wm.service.FoodService;
import com.sdutcm.wm.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * 菜品控制器：处理菜品相关的添加、管理、展示等请求
 */
@Controller
public class FoodController {

	@Autowired
	private FoodService foodService;    // 菜品服务层注入
	@Autowired
	private ShopService shopService;    // 店铺服务层注入


	/**
	 * 跳转到添加菜品页面
	 * @param model 模型对象（传递店铺列表到视图）
	 * @param session HTTP会话（获取当前卖家ID）
	 * @return 菜品添加表单页面路径
	 */
	@RequestMapping("toAddFood")
	public String toAddFood(Model model, HttpSession session) {
		String seller_id = (String) session.getAttribute("id");
		List<Shop> shops = shopService.getShopsBySeller(seller_id);
		model.addAttribute("shops", shops);
		return "seller/addFood";
	}


	/**
	 * 处理菜品添加提交请求
	 * @param request HTTP请求对象（获取文件上传路径）
	 * @param food_img 菜品图片文件（可选参数）
	 * @param food_id 菜品ID
	 * @param food_name 菜品名称
	 * @param food_price 菜品价格
	 * @param shop_id 店铺ID（可选参数，默认使用卖家的默认店铺）
	 * @param session HTTP会话（获取当前卖家ID）
	 * @return 操作结果页面（成功/失败）
	 * @throws IOException 文件上传异常
	 */
	@RequestMapping(value = "addFood", method = RequestMethod.POST)
	public String addFood(HttpServletRequest request,
						  @RequestParam(value = "food_img", required = false) MultipartFile food_img,
						  @RequestParam String food_id,
						  @RequestParam String food_name,
						  @RequestParam double food_price,
						  @RequestParam(required = false) String shop_id,
						  HttpSession session) throws IOException {

		String imgPath = null;
		String seller_id = (String) session.getAttribute("id");
		System.out.println("当前会话卖家ID: " + seller_id);

		// 处理图片上传
		if (food_img != null && !food_img.isEmpty()) {
			// 获取图片存储路径
			String imgUrl = request.getSession().getServletContext().getRealPath("/static/images/food/");
			System.out.println("图片上传路径: " + imgUrl);

			// 构建文件对象（使用菜品ID作为文件名）
			File filePath = new File(imgUrl + File.separator + food_id + ".jpg");
			if (!filePath.getParentFile().exists()) {
				boolean created = filePath.getParentFile().mkdirs();
				System.out.println("创建上传目录: " + created);
			}
			food_img.transferTo(filePath); // 保存图片到服务器
			imgPath = "static/images/food/" + food_id + ".jpg"; // 设置数据库存储的图片路径

			// 处理店铺ID（若未指定则使用卖家默认店铺）
			if (shop_id == null || shop_id.trim().isEmpty()) {
				shop_id = shopService.getDefaultShopID(seller_id);
			}

			System.out.println("使用店铺ID: " + shop_id);

			// 验证店铺ID有效性
			if (shop_id == null) {
				System.out.println("获取卖家默认店铺ID失败: " + seller_id);
				return "seller/addFoodFail";
			} else {
				// 构建菜品实体并插入数据库
				Food food = new Food();
				food.setFood_id(food_id);
				food.setFood_name(food_name);
				food.setFood_price(food_price);
				food.setShop_id(shop_id);
				food.setFood_img(imgPath);

				int i = foodService.insertFood(food);
				System.out.println("菜品插入结果: " + i);
				return i == 0 ? "seller/addFoodFail" : "seller/addFoodSuccess";
			}
		} else {
			System.out.println("未上传图片文件");
			return "seller/addFoodFail";
		}
	}


	/**
	 * 卖家菜品管理页面
	 * @param mv ModelAndView对象（设置视图和数据）
	 * @param shop_id 店铺ID（可选参数，为空时查询所有店铺菜品）
	 * @return 包含菜品列表的ModelAndView对象
	 */
	@RequestMapping("foodManage")
	public ModelAndView getFoodAll(ModelAndView mv, @RequestParam(value = "shop_id", required = false) String shop_id) {
		List<Food> food = foodService.getFoodAll(shop_id);
		mv.addObject("foodlist", food);
		mv.setViewName("seller/foodManage");
		return mv;
	}


	/**
	 * 用户端菜品展示页面
	 * @param mv ModelAndView对象（设置视图和数据）
	 * @param shop_id 店铺ID（查询指定店铺的菜品）
	 * @return 包含菜品列表的ModelAndView对象
	 */
	@RequestMapping(value = "showFood", method = RequestMethod.GET)
	public ModelAndView showFood(ModelAndView mv, @RequestParam String shop_id) {
		List<Food> food = foodService.getFoodAll(shop_id);
		mv.addObject("foodlist", food);
		mv.setViewName("user/showFood");
		return mv;
	}
}