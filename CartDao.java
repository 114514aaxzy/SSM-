package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.Cart;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartDao {
	public int insertCart(Cart cart);
	public int deleteCartByUser(String user_id);
	public int deleteCartByID(@Param("cart_id") String cart_id);
	public int deleteCartByShop(String shop_id);
	public int updateCart(Cart cart);
	public Cart getCart(String cart_id);
	public List<Cart> getCartByUser(String user_id);
	public Cart getCartByID(
		@Param("food_id") String food_id, 
		@Param("shop_id") String shop_id, 
		@Param("user_id") String user_id
	);
	
}
