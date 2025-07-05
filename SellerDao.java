package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.Seller;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SellerDao {
	
	public int insertSeller(Seller seller);
	public int deleteSeller(String seller_id);
	public int updateSeller(Seller seller);
	public Seller getSeller(String seller_id);
	public List<Seller> getSellerAll();
	
}
