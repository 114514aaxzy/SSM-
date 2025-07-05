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
	 * ��ת����¼ҳ��
	 * @return ��¼ҳ�����ͼ����
	 */
	@RequestMapping(value = "tologin")
	public String tologin() {
		return "login";
	}

	/**
	 * ��ת����ҳ
	 * @return ��ҳ����ͼ����
	 */
	@RequestMapping("toIndex")
	public String toIndex(){
		return "redirect:/index.jsp";
	}

	/**
	 * �����û���¼����
	 * @param id �û������ID
	 * @param pwd �û����������
	 * @param person �û����ͣ��û������ҡ����֣�
	 * @param model �������ģ������
	 * @param session ��ǰ�Ự
	 * @return ��¼�ɹ���ʧ�ܵ���ͼ����
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
					// ֱ������session������ȷ������
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
					// ����session����
					session.setAttribute("id", id);
					session.setAttribute("userType", "rider");
					return "redirect:riderHome";
				}
				break;
		}

		return "loginFail";
	}

	/**
	 * �û��˳���¼
	 * @param session ��ǰ�Ự
	 * @return ��¼ҳ�����ͼ����
	 */
	@RequestMapping(value="quit")
	public String quit(HttpSession session){
		session.invalidate();
		return "login";
	}

	/**
	 * �û�ע���Ự
	 * @param session ��ǰ�Ự
	 * @param sessionStatus �Ự״̬
	 * @return �ض��򵽵�¼ҳ��
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session, SessionStatus sessionStatus) {
		// ���session�е���������
		session.invalidate();
		// ���@SessionAttributes���õ�����
		sessionStatus.setComplete();
		// �ض��򵽵�¼ҳ��
		return "redirect:/";
	}

}