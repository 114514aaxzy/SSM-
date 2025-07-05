package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.Seller;

import java.util.List;

public interface SellerService {
	
	public Seller selectSellerById(String se_id, String se_pwd);
	public List<Seller> allSeller();
	public int registSeller(Seller seller);
	public int deleteSeller(String seller_id);
	public Seller getSeller(String seller_id);
	public int updateSeller(Seller seller);

}
