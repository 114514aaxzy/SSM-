package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao {
	public int insertOrder(Order order);
	public int deleteOrderByOn(String order_on);
	public int updateOrder(Order order);
	public Order getOrder(String order_on);
	public List<Order> getOrderAll();
	public List<Order> getOrderAllByUser(String user_id);
	public List<Order> getOrderAllByShop(String shop_id);
	public List<Order> getOrderAllByRider(String rider_id);
	public List<Order> getOrderAllByStatus(@Param("order_status") int order_status);
	
	// 获取指定状态和骑手的订单列表
	List<Order> getOrdersByStatusAndRider(@Param("status") int status, @Param("riderId") String riderId);
}
