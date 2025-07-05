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
 * ��Ʒ�������������Ʒ��ص���ӡ�����չʾ������
 */
@Controller
public class FoodController {

	@Autowired
	private FoodService foodService;    // ��Ʒ�����ע��
	@Autowired
	private ShopService shopService;    // ���̷����ע��


	/**
	 * ��ת����Ӳ�Ʒҳ��
	 * @param model ģ�Ͷ��󣨴��ݵ����б���ͼ��
	 * @param session HTTP�Ự����ȡ��ǰ����ID��
	 * @return ��Ʒ��ӱ�ҳ��·��
	 */
	@RequestMapping("toAddFood")
	public String toAddFood(Model model, HttpSession session) {
		String seller_id = (String) session.getAttribute("id");
		List<Shop> shops = shopService.getShopsBySeller(seller_id);
		model.addAttribute("shops", shops);
		return "seller/addFood";
	}


	/**
	 * �����Ʒ����ύ����
	 * @param request HTTP������󣨻�ȡ�ļ��ϴ�·����
	 * @param food_img ��ƷͼƬ�ļ�����ѡ������
	 * @param food_id ��ƷID
	 * @param food_name ��Ʒ����
	 * @param food_price ��Ʒ�۸�
	 * @param shop_id ����ID����ѡ������Ĭ��ʹ�����ҵ�Ĭ�ϵ��̣�
	 * @param session HTTP�Ự����ȡ��ǰ����ID��
	 * @return �������ҳ�棨�ɹ�/ʧ�ܣ�
	 * @throws IOException �ļ��ϴ��쳣
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
		System.out.println("��ǰ�Ự����ID: " + seller_id);

		// ����ͼƬ�ϴ�
		if (food_img != null && !food_img.isEmpty()) {
			// ��ȡͼƬ�洢·��
			String imgUrl = request.getSession().getServletContext().getRealPath("/static/images/food/");
			System.out.println("ͼƬ�ϴ�·��: " + imgUrl);

			// �����ļ�����ʹ�ò�ƷID��Ϊ�ļ�����
			File filePath = new File(imgUrl + File.separator + food_id + ".jpg");
			if (!filePath.getParentFile().exists()) {
				boolean created = filePath.getParentFile().mkdirs();
				System.out.println("�����ϴ�Ŀ¼: " + created);
			}
			food_img.transferTo(filePath); // ����ͼƬ��������
			imgPath = "static/images/food/" + food_id + ".jpg"; // �������ݿ�洢��ͼƬ·��

			// �������ID����δָ����ʹ������Ĭ�ϵ��̣�
			if (shop_id == null || shop_id.trim().isEmpty()) {
				shop_id = shopService.getDefaultShopID(seller_id);
			}

			System.out.println("ʹ�õ���ID: " + shop_id);

			// ��֤����ID��Ч��
			if (shop_id == null) {
				System.out.println("��ȡ����Ĭ�ϵ���IDʧ��: " + seller_id);
				return "seller/addFoodFail";
			} else {
				// ������Ʒʵ�岢�������ݿ�
				Food food = new Food();
				food.setFood_id(food_id);
				food.setFood_name(food_name);
				food.setFood_price(food_price);
				food.setShop_id(shop_id);
				food.setFood_img(imgPath);

				int i = foodService.insertFood(food);
				System.out.println("��Ʒ������: " + i);
				return i == 0 ? "seller/addFoodFail" : "seller/addFoodSuccess";
			}
		} else {
			System.out.println("δ�ϴ�ͼƬ�ļ�");
			return "seller/addFoodFail";
		}
	}


	/**
	 * ���Ҳ�Ʒ����ҳ��
	 * @param mv ModelAndView����������ͼ�����ݣ�
	 * @param shop_id ����ID����ѡ������Ϊ��ʱ��ѯ���е��̲�Ʒ��
	 * @return ������Ʒ�б��ModelAndView����
	 */
	@RequestMapping("foodManage")
	public ModelAndView getFoodAll(ModelAndView mv, @RequestParam(value = "shop_id", required = false) String shop_id) {
		List<Food> food = foodService.getFoodAll(shop_id);
		mv.addObject("foodlist", food);
		mv.setViewName("seller/foodManage");
		return mv;
	}


	/**
	 * �û��˲�Ʒչʾҳ��
	 * @param mv ModelAndView����������ͼ�����ݣ�
	 * @param shop_id ����ID����ѯָ�����̵Ĳ�Ʒ��
	 * @return ������Ʒ�б��ModelAndView����
	 */
	@RequestMapping(value = "showFood", method = RequestMethod.GET)
	public ModelAndView showFood(ModelAndView mv, @RequestParam String shop_id) {
		List<Food> food = foodService.getFoodAll(shop_id);
		mv.addObject("foodlist", food);
		mv.setViewName("user/showFood");
		return mv;
	}
}