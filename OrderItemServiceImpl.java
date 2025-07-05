package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.OrderItemDao;
import com.sdutcm.wm.pojo.Cart;
import com.sdutcm.wm.pojo.OrderItem;
import com.sdutcm.wm.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 订单条目服务实现类
 * 处理订单明细相关的业务逻辑和数据操作
 */
@Service("orderItemService")
public class OrderItemServiceImpl implements OrderItemService {

	@Autowired
	private OrderItemDao orderItemDao; // 注入订单条目数据访问对象

	/**
	 * 根据订单编号获取订单条目列表
	 * @param order_on 订单编号
	 * @return 订单条目列表（若为空则返回null）
	 */
	@Override
	public List<OrderItem> getOrderItem(String order_on) {
		System.out.println("OrderItemService: Getting items for order_on: " + order_on);
		List<OrderItem> orderItem = orderItemDao.getOrderItemAll(order_on);
		System.out.println("OrderItemService: Found " + (orderItem != null ? orderItem.size() : 0) + " items");
		return orderItem; // 直接返回，无需null判断（原代码逻辑冗余）
	}

	/**
	 * 插入单个订单条目
	 * @param orderitem 订单条目实体
	 * @return 插入操作结果（成功返回1，失败返回0）
	 */
	@Override
	public int insertOrderItem(OrderItem orderitem) {
		return orderItemDao.insertOrderItem(orderitem);
	}

	/**
	 * 根据购物车内容构建订单条目并批量插入
	 * @param cart 购物车列表
	 * @param order_on 订单编号
	 * @return 最后一次插入操作的结果（成功返回1，失败返回0）
	 */
	@Override
	public int buildOrderItem(List<Cart> cart, String order_on) {
		int result = 0; // 初始化结果变量

		for (Cart item : cart) { // 使用增强for循环提高可读性
			OrderItem oi = new OrderItem();

			// 从购物车项复制属性到订单条目
			oi.setOrder_on(order_on);
			oi.setFood_id(item.getFood_id());
			oi.setFood_name(item.getFood_name());
			oi.setFood_num(item.getCart_num());
			oi.setFood_price(item.getFood_price());
			oi.setFood_total(item.getCart_total());
			oi.setShop_id(item.getShop_id());
			oi.setShop_name(item.getShop_name());
			oi.setUser_id(item.getUser_id());

			result = orderItemDao.insertOrderItem(oi); // 执行插入操作

			// 可优化点：此处应检查插入结果，若失败可考虑回滚或异常处理
		}

		return result;
	}
}