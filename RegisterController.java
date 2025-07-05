package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Rider;
import com.sdutcm.wm.pojo.Seller;
import com.sdutcm.wm.pojo.User;
import com.sdutcm.wm.service.RiderService;
import com.sdutcm.wm.service.SellerService;
import com.sdutcm.wm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;

/**
 * 注册控制器：处理卖家、骑手、普通用户的注册请求
 */
@Controller
public class RegisterController {

	@Autowired
	private SellerService sellerService;    // 卖家服务层注入
	@Autowired
	private RiderService riderService;      // 骑手服务层注入
	@Autowired
	private UserService userService;        // 普通用户服务层注入


	/**
	 * 卖家注册页面初始化
	 * @param seller 卖家实体对象（用于表单数据绑定）
	 * @param model 模型对象（传递数据到视图）
	 * @return 卖家注册表单页面路径
	 */
	@RequestMapping(value = "sellerCheck", method = RequestMethod.GET)
	public String sellerRigisterInit(Seller seller, Model model) {
		model.addAttribute("seller", seller);
		return "admin/sellerCheck";
	}


	/**
	 * 处理卖家注册提交请求
	 * @param seller 绑定表单数据的卖家实体（含注册信息）
	 * @param result 数据校验结果（验证表单输入合法性）
	 * @return 注册结果页面（成功/失败）
	 */
	@RequestMapping(value = "sellerregist", method = RequestMethod.POST)
	public String SellerRegist(@Valid Seller seller, BindingResult result) {
		// 校验表单数据，若有错误则返回注册页面
		if (result.hasErrors()) {
			return "admin/sellerCheck";
		}
		// 调用服务层注册卖家，根据返回结果跳转页面
		else {
			int i = sellerService.registSeller(seller);
			return i == 0 ? "admin/registFail" : "admin/registSuccess";
		}
	}


	/**
	 * 骑手注册页面初始化
	 * @param rider 骑手实体对象（用于表单数据绑定）
	 * @param model 模型对象（传递数据到视图）
	 * @return 骑手注册表单页面路径
	 */
	@RequestMapping(value = "riderCheck", method = RequestMethod.GET)
	public String reiderRigisterInit(Rider rider, Model model) {
		model.addAttribute("rider", rider);
		return "admin/riderCheck";
	}


	/**
	 * 处理骑手注册提交请求
	 * @param rider 绑定表单数据的骑手实体（含注册信息）
	 * @param result 数据校验结果（验证表单输入合法性）
	 * @return 注册结果页面（成功/失败）
	 */
	@RequestMapping(value = "riderregist", method = RequestMethod.POST)
	public String RiderRegist(@Valid Rider rider, BindingResult result) {
		// 校验表单数据，若有错误则返回注册页面
		if (result.hasErrors()) {
			return "admin/riderCheck";
		}
		// 调用服务层注册骑手，根据返回结果跳转页面
		else {
			int i = riderService.registRider(rider);
			return i == 0 ? "admin/registFail" : "admin/registSuccess";
		}
	}


	/**
	 * 普通用户注册页面初始化
	 * @param model 模型对象（初始化User实体并传递到视图）
	 * @return 普通用户注册表单页面路径
	 */
	@RequestMapping(value = "userCheck", method = RequestMethod.GET)
	public String userRigisterInit(Model model) {
		model.addAttribute("user", new User());
		return "user/userCheck";
	}


	/**
	 * 处理普通用户注册提交请求
	 * @param user 绑定表单数据的用户实体（含注册信息）
	 * @param result 数据校验结果（验证表单输入合法性）
	 * @param model 模型对象（传递错误信息到失败页面）
	 * @return 注册结果页面（成功/失败）
	 */
	@RequestMapping(value = "userregist", method = RequestMethod.POST)
	public String UserRegist(@Valid User user, BindingResult result, Model model) {
		// 校验表单数据，若有错误则返回注册页面
		if (result.hasErrors()) {
			return "user/userCheck";
		}
		// 调用服务层注册用户，根据返回结果跳转页面
		else {
			int i = userService.registUser(user);
			if (i == 0) {
				model.addAttribute("message", "注册失败，用户ID已存在");
				return "user/registFail";
			} else {
				return "user/registSuccess";
			}
		}
	}
}