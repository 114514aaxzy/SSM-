package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.User;
import com.sdutcm.wm.service.UserService;
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

@Controller
public class UserController {
	// 自动注入UserService，用于处理用户相关业务逻辑
	@Autowired
	private UserService userService;

	/**
	 * 跳转到用户主页
	 * @return 用户主页视图名
	 */
	@RequestMapping("toUserHomePage")
	public String toHomePage() {
		return "user/homePage";
	}

	/**
	 * 跳转到用户展示食品页面
	 * @return 用户展示食品页面视图名
	 */
	@RequestMapping("toUserShowFood")
	public String toShowFood() {
		return "user/showFood";
	}

	/**
	 * 获取所有用户信息
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @return 包含所有用户信息的视图
	 */
	@RequestMapping("getAllUser")
	public ModelAndView getAllUser(ModelAndView mv) {
		// 调用UserService获取所有用户信息
		List<User> user = userService.allUser();
		// 将用户列表添加到模型中
		mv.addObject("userlist", user);
		// 设置视图名为"admin/getAllUser"
		mv.setViewName("admin/getAllUser");
		return mv;
	}

	/**
	 * 用户管理页面
	 * @param mv ModelAndView对象，用于添加模型数据和设置视图
	 * @param session 当前会话
	 * @return 用户管理页面
	 */
	@RequestMapping("userManageInUser")
	public ModelAndView userManage(ModelAndView mv, HttpSession session) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 根据用户ID获取用户信息
		User user = userService.getUser(user_id);
		// 将用户信息添加到模型中
		mv.addObject("user", user);
		// 设置视图名为"user/userManage"
		mv.setViewName("user/userManage");
		return mv;
	}
	/**
	 * 跳转到用户更新页面
	 * @param session 当前会话
	 * @param model Model对象，用于添加模型数据
	 * @return 用户更新页面视图名
	 */
	@RequestMapping(value = "toUpdateUser", method = RequestMethod.GET)
	public String toUpdateUser(HttpSession session, Model model) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 根据用户ID获取用户信息
		User user = userService.getUser(user_id);
		// 将用户信息添加到模型中
		model.addAttribute("user", user);
		return "user/updateUser";
	}
	/**
	 * 更新用户信息
	 * @param session 当前会话
	 * @param user 用户对象，包含更新后的用户信息
	 * @param result BindingResult对象，用于检查用户输入的合法性
	 * @return 更新成功或失败的视图名
	 */
	@RequestMapping(value = "updateUser", method = RequestMethod.POST)
	public String updateUser(HttpSession session, @Valid User user, BindingResult result) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 根据用户ID获取当前用户信息
		User us = userService.getUser(user_id);

		// 如果用户输入有误，返回更新页面
		if (result.hasErrors())
			return "user/updateUser";
		else {
			// 更新用户信息
			us.setUser_pwd(user.getUser_pwd());
			us.setUser_name(user.getUser_name());
			us.setUser_sex(user.getUser_sex());
			us.setUser_phone(user.getUser_phone());

			// 调用UserService更新用户信息
			int i = userService.updateUser(us);
			if (i == 0)
				return "user/updateFail";
			else return "user/updateSuccess";
		}
	}
	/**
	 * 跳转到用户充值页面
	 * @return 用户充值页面视图名
	 */
	@RequestMapping("toDeposit")
	public String toDeposit() {
		return "user/deposit";
	}

	/**
	 * 用户充值
	 * @param session 当前会话
	 * @param balance 充值金额
	 * @return 充值成功页面视图名
	 */
	@RequestMapping(value = "deposit")
	public String deposit(HttpSession session, @RequestParam double balance) {
		// 从会话中获取用户ID
		String user_id = (String) session.getAttribute("id");
		// 根据用户ID获取用户信息
		User user = userService.getUser(user_id);
		// 更新用户余额
		user.setUser_balance(user.getUser_balance() + balance);
		// 调用UserService更新用户信息
		userService.updateUser(user);
		return "user/depositSuccess";
	}
}