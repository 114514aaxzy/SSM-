package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.CartDao;
import com.sdutcm.wm.pojo.Cart;
import com.sdutcm.wm.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("cartService")
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDao cartDao;

	@Override
	public List<Cart> getCart(String user_id) {
		// 根据用户ID获取购物车列表
		List<Cart> cart = cartDao.getCartByUser(user_id);
		// 如果购物车列表为空，返回null
		if(cart == null)
			return null;
		else
			return cart;
	}

	@Override
	public int insertCart(Cart cart) {
		// 插入新的购物车项
		int i = cartDao.insertCart(cart);
		return i;
	}

	@Override
	public int deleteCartUser(String user_id) {
		// 删除指定用户的购物车
		int i = cartDao.deleteCartByUser(user_id);
		return i;
	}

	@Override
	public Cart getCartByID(String food_id, String shop_id, String user_id) {
		// 根据商品ID、店铺ID和用户ID获取购物车项
		Cart cart = cartDao.getCartByID(food_id, shop_id, user_id);
		// 如果购物车项不存在，返回null
		if(cart == null)
			return null;
		else
			return cart;
	}

	@Override
	public int updateCart(Cart cart) {
		// 更新购物车项
		int i = cartDao.updateCart(cart);
		return i;
	}

	@Override
	public Cart getCartByCart(String cart_id) {
		// 根据购物车项ID获取购物车项
		Cart cart = cartDao.getCart(cart_id);
		// 如果购物车项不存在，返回null
		if(cart == null)
			return null;
		else
			return cart;
	}

	@Override
	public int deleteCartByID(String cart_id) {
		// 删除指定的购物车项
		int i = cartDao.deleteCartByID(cart_id);
		return i;
	}

}