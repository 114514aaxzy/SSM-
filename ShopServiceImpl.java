package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.ShopDao;
import com.sdutcm.wm.pojo.Shop;
import com.sdutcm.wm.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 店铺服务实现类
 * 处理店铺相关的业务逻辑和数据操作
 */
@Service("shopService")
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao shopDao; // 注入店铺数据访问对象

	/**
	 * 根据卖家ID获取店铺信息
	 * @param seller_id 卖家ID
	 * @return 店铺实体（若不存在则返回null）
	 */
	@Override
	public Shop getShopBySeller(String seller_id) {
		return shopDao.getShop(seller_id);
	}

	/**
	 * 获取卖家的默认店铺ID（实际调用getDefaultShopID）
	 * @param seller_id 卖家ID
	 * @return 店铺ID（若不存在则返回null）
	 */
	@Override
	public String getShopID(String seller_id) {
		return getDefaultShopID(seller_id);
	}

	/**
	 * 获取卖家的默认店铺ID（返回第一个店铺）
	 * @param seller_id 卖家ID
	 * @return 店铺ID（若不存在则返回null）
	 */
	@Override
	public String getDefaultShopID(String seller_id) {
		List<Shop> shops = shopDao.getShopsBySeller(seller_id);
		if (shops != null && !shops.isEmpty()) {
			return shops.get(0).getShop_id();
		}
		return null;
	}

	/**
	 * 插入新店铺
	 * @param shop 店铺实体
	 * @return 插入结果（1-成功，0-失败）
	 */
	@Override
	public int insertShop(Shop shop) {
		return shopDao.insertShop(shop);
	}

	/**
	 * 获取所有店铺列表
	 * @return 店铺列表（若为空则返回null）
	 */
	@Override
	public List<Shop> getShop() {
		return shopDao.getShopAll(); // 直接返回，无需冗余的null判断
	}

	/**
	 * 根据店铺ID获取店铺名称
	 * @param shop_id 店铺ID
	 * @return 店铺名称（若不存在则返回null）
	 */
	@Override
	public String getShopName(String shop_id) {
		Shop shop = shopDao.getShopByID(shop_id);
		return shop != null ? shop.getShop_name() : null;
	}

	/**
	 * 根据店铺ID获取店铺完整信息
	 * @param shop_id 店铺ID
	 * @return 店铺实体（若不存在则返回null）
	 */
	@Override
	public Shop getShopById(String shop_id) {
		return shopDao.getShopByID(shop_id); // 简化返回逻辑
	}

	/**
	 * 根据卖家ID获取其所有店铺
	 * @param seller_id 卖家ID
	 * @return 店铺列表（若为空则返回null）
	 */
	@Override
	public List<Shop> getShopsBySeller(String seller_id) {
		return shopDao.getShopsBySeller(seller_id);
	}
}