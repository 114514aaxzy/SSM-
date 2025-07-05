package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.OrderItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderItemDao {
	public int insertOrderItem(OrderItem orderitem);
	public int deleteOrderItem(String order_on);
	public List<OrderItem> getOrderItemAll(@Param("order_on")String order_on);

}
