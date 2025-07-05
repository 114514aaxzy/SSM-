package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.RiderCompletedOrder;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RiderCompletedOrderDao {
    // 插入完成的订单记录
    int insertCompletedOrder(RiderCompletedOrder order);
    
    // 根据骑手ID查询已完成的订单
    List<RiderCompletedOrder> getCompletedOrdersByRider(@Param("riderId") String riderId);
    
    // 根据订单编号查询完成记录
    RiderCompletedOrder getCompletedOrderByOrderOn(@Param("orderOn") String orderOn);
    
    // 查询骑手的完成订单统计
    Integer getCompletedOrderCountByRider(@Param("riderId") String riderId);
    
    // 获取骑手总收入
    Double getTotalEarningsByRider(@Param("riderId") String riderId);
    
    // 获取骑手总距离
    Double getTotalDistanceByRider(@Param("riderId") String riderId);
} 