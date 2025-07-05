package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.OrderDao;
import com.sdutcm.wm.dao.SellerDao;
import com.sdutcm.wm.dao.ShopDao;
import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.Seller;
import com.sdutcm.wm.pojo.Shop;
import com.sdutcm.wm.service.SellerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SellerServiceImpl implements SellerService {

	@Autowired
	private SellerDao sellerDao;
	@Autowired
	private ShopDao shopDao;
	@Autowired
	private OrderDao orderDao;

	@Override
	public Seller selectSellerById(String se_id, String se_pwd) {
		// 根据卖家ID获取卖家信息
		Seller seller = sellerDao.getSeller(se_id);

		// 如果卖家不存在，返回null
		if(seller==null){
			return null;
		}else{
			// 如果卖家存在，验证密码是否匹配
			if(seller.getSeller_id().equals(se_id)&&seller.getSeller_pwd().equals(se_pwd))
				return seller;
			else
				return null;
		}
	}

	@Override
	public List<Seller> allSeller() {
		// 获取所有卖家信息
		List<Seller> seller = sellerDao.getSellerAll();

		// 如果卖家列表为空，返回null
		if(seller==null)
			return null;
		else
			return seller;
	}

	@Override
	public int registSeller(Seller seller) {
		// 检查卖家ID是否已存在
		Seller se = sellerDao.getSeller(seller.getSeller_id());
		if(se != null)
			return 0; // 如果卖家已存在，返回0
		else{
			// 插入新卖家
			int i = sellerDao.insertSeller(seller);
			if(i==0)
				return 0; // 如果插入失败，返回0
			else
				return 1; // 如果插入成功，返回1
		}
	}

	@Override
	public int deleteSeller(String seller_id) {
		// 初始化返回值
		int i = 0;
		int result = 0;
		// 根据卖家ID获取卖家的店铺
		Shop shop = shopDao.getShop(seller_id);
		if(shop == null){
			// 如果卖家没有店铺，直接删除卖家
			i = sellerDao.deleteSeller(seller_id);
			return i;
		}
		else
		{
			// 获取该店铺的所有订单
			List<Order> order = orderDao.getOrderAllByShop(shop.getShop_id());
			if(order == null || order.isEmpty()){
				// 如果店铺没有订单，删除卖家和店铺
				i = sellerDao.deleteSeller(seller_id);
				shopDao.deleteShopBySeller(seller_id);
				return i;
			}
			else
			{
				// 检查订单状态
				for(Order list : order){
					if((list.getOrder_status()==1)||(list.getOrder_status()==3)
							||(list.getOrder_status()==4)||(list.getOrder_status()==5)){
						// 如果有未完成的订单，返回0
						result = 10;
					}
				}
				if(result != 10){
					// 如果所有订单都已完成，删除卖家和店铺
					i = sellerDao.deleteSeller(seller_id);
					shopDao.deleteShopBySeller(seller_id);
					return i;
				}
				else
					return 0; // 如果有未完成的订单，返回0
			}
		}
	}

	@Override
	public Seller getSeller(String seller_id) {
		// 根据卖家ID获取卖家信息
		Seller seller = sellerDao.getSeller(seller_id);
		if(seller==null)
			return null;
		else
			return seller;
	}

	@Override
	public int updateSeller(Seller seller) {
		// 更新卖家信息
		int i = sellerDao.updateSeller(seller);
		return i;
	}

}