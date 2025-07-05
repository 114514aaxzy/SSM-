package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.RiderCompletedOrder;

import java.util.List;

public interface RiderCompletedOrderService {
    // 完成订单
    boolean completeOrder(RiderCompletedOrder order);
    
    // 获取骑手的已完成订单列表
    List<RiderCompletedOrder> getCompletedOrdersByRider(String riderId);
    
    // 获取订单的完成记录
    RiderCompletedOrder getOrderCompletionRecord(String orderOn);
    
    // 获取骑手完成的订单数量
    Integer getCompletedOrderCountByRider(String riderId);
    
    // 获取骑手完成的总收入
    Double getTotalEarningsByRider(String riderId);
    
    // 获取骑手完成的总距离
    Double getTotalDistanceByRider(String riderId);
    
    // 获取骑手完成的订单详情
    RiderCompletedOrder getCompletedOrderByOrderOn(String orderOn);
} 