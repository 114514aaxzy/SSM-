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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpSession;

@Controller
@SessionAttributes(value={"id", "userType"})
public class LoginController {
	@Autowired
	private UserService userService;
	@Autowired
	private SellerService sellerService;
	@Autowired
	private RiderService riderService;

	/**
	 * 跳转到登录页面
	 * @return 登录页面的视图名称
	 */
	@RequestMapping(value = "tologin")
	public String tologin() {
		return "login";
	}

	/**
	 * 跳转到首页
	 * @return 首页的视图名称
	 */
	@RequestMapping("toIndex")
	public String toIndex(){
		return "redirect:/index.jsp";
	}

	/**
	 * 处理用户登录请求
	 * @param id 用户输入的ID
	 * @param pwd 用户输入的密码
	 * @param person 用户类型（用户、卖家、骑手）
	 * @param model 用于添加模型数据
	 * @param session 当前会话
	 * @return 登录成功或失败的视图名称
	 */
	@RequestMapping(value = "login")
	public String login(String id, String pwd, String person, Model model, HttpSession session) {
		System.out.println("Login attempt - ID: " + id + ", Type: " + person);

		if ((id == null) || (pwd == null)) {
			return "loginFail";
		}

		switch(person) {
			case "user":
				User user = userService.selectUserById(id, pwd);
				if (user != null) {
					model.addAttribute("id", id);
					model.addAttribute("userType", "user");
					model.addAttribute("name", user.getUser_name());
					return "user/homePage";
				}
				break;

			case "seller":
				Seller seller = sellerService.selectSellerById(id, pwd);
				if (seller != null) {
					System.out.println("Seller login successful - ID: " + id);
					model.addAttribute("id", id);
					model.addAttribute("userType", "seller");
					model.addAttribute("name", seller.getSeller_name());
					// 直接设置session属性以确保可用
					session.setAttribute("id", id);
					session.setAttribute("userType", "seller");
					return "seller/homePage";
				}
				break;

			case "rider":
				Rider rider = riderService.selectRiderById(id, pwd);
				if (rider != null) {
					model.addAttribute("id", id);
					model.addAttribute("userType", "rider");
					model.addAttribute("name", rider.getRider_name());
					// 设置session属性
					session.setAttribute("id", id);
					session.setAttribute("userType", "rider");
					return "redirect:riderHome";
				}
				break;
		}

		return "loginFail";
	}

	/**
	 * 用户退出登录
	 * @param session 当前会话
	 * @return 登录页面的视图名称
	 */
	@RequestMapping(value="quit")
	public String quit(HttpSession session){
		session.invalidate();
		return "login";
	}

	/**
	 * 用户注销会话
	 * @param session 当前会话
	 * @param sessionStatus 会话状态
	 * @return 重定向到登录页面
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session, SessionStatus sessionStatus) {
		// 清除session中的所有属性
		session.invalidate();
		// 清除@SessionAttributes设置的属性
		sessionStatus.setComplete();
		// 重定向到登录页面
		return "redirect:/";
	}

}