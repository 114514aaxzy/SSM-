package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.Shop;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShopDao {
	public int insertShop(Shop shop);
	public int deleteShop(String shop_id);
	public int deleteShopBySeller(String seller_id);
	public int updateShop(Shop shop);
	public Shop getShop(String seller_id);
	public Shop getShopByID(String shop_id);
	public List<Shop> getShopAll();
	public List<Shop> getShopsBySeller(String seller_id);
}
