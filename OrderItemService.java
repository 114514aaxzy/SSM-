package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.Cart;
import com.sdutcm.wm.pojo.OrderItem;

import java.util.List;

public interface OrderItemService {
	public List<OrderItem> getOrderItem(String order_on);
	public int insertOrderItem(OrderItem orderitem);
	public int buildOrderItem(List<Cart> cart, String order_on);
}
