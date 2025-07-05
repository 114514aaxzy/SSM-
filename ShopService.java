package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.Shop;

import java.util.List;

public interface ShopService {
	public Shop getShopBySeller(String seller_id);
	public List<Shop> getShopsBySeller(String seller_id);
	public Shop getShopById(String shop_id);
	public String getShopID(String seller_id);
	public String getDefaultShopID(String seller_id);
	public int insertShop(Shop shop);
	public List<Shop> getShop();
	public String getShopName(String shop_id);

}
