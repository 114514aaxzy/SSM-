package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.OrderDao;
import com.sdutcm.wm.dao.UserDao;
import com.sdutcm.wm.pojo.Cart;
import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.User;
import com.sdutcm.wm.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	@Autowired
	private UserDao userDao;

	@Override
	public List<Order> getOrderAll() {
		// 获取所有订单
		List<Order> order = orderDao.getOrderAll();
		if(order==null)
			return null;
		else
			return order;
	}

	@Override
	public List<Order> getOrderByShop(String shop_id) {
		// 根据店铺ID获取所有订单
		List<Order> order = orderDao.getOrderAllByShop(shop_id);
		return order;
	}

	@Override
	public Order getOrderByOn(String order_on) {
		// 根据订单编号获取订单
		Order order = orderDao.getOrder(order_on);
		if(order == null)
			return null;
		else
			return order;
	}

	@Override
	public int updateOrder(Order order) {
		// 更新订单信息
		int i = orderDao.updateOrder(order);
		return i;
	}

	@Override
	public int buildOrder(Timestamp date, String order_on,
						  String order_address, double totalprice, Cart cart, String user_id)
	{
		// 根据用户ID获取用户信息
		User user = userDao.getUser(user_id);

		// 创建新的订单
		Order order = new Order();
		order.setOrder_address(order_address); // 设置订单地址
		order.setOrder_on(order_on); // 设置订单编号
		order.setOrder_pay(totalprice); // 设置订单支付金额
		order.setOrder_price(totalprice); // 设置订单总价
		order.setOrder_status(1); // 设置订单状态为1（待处理）
		order.setOrder_time(date); // 设置订单时间
		order.setShop_id(cart.getShop_id()); // 设置店铺ID
		order.setUser_id(cart.getUser_id()); // 设置用户ID
		order.setShop_name(cart.getShop_name()); // 设置店铺名称
		order.setUser_phone(user.getUser_phone()); // 设置用户电话

		// 插入订单
		int i = orderDao.insertOrder(order);
		return i;
	}

	@Override
	public List<Order> getOrderAllByUser(String user_id) {
		// 根据用户ID获取所有订单
		List<Order> order =orderDao.getOrderAllByUser(user_id);
		return order;
	}

	@Override
	public List<Order> getOrderAllByStatus(int order_status) {
		// 根据订单状态获取所有订单
		List<Order> order = orderDao.getOrderAllByStatus(order_status);
		if((order == null)||(order.isEmpty()))
			return null;
		else
			return order;
	}

	@Override
	public List<Order> getOrdersByStatusAndRider(int status, String riderId) {
		// 根据订单状态和骑手ID获取所有订单
		return orderDao.getOrdersByStatusAndRider(status, riderId);
	}

}