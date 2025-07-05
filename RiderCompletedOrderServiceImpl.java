package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.RiderCompletedOrderDao;
import com.sdutcm.wm.pojo.RiderCompletedOrder;
import com.sdutcm.wm.service.RiderCompletedOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 骑手完成订单服务实现类
 * 处理骑手已完成订单的业务逻辑和数据操作
 */
@Service("riderCompletedOrderService")
@Transactional // 声明式事务管理，确保数据库操作的原子性
public class RiderCompletedOrderServiceImpl implements RiderCompletedOrderService {

    @Autowired
    private RiderCompletedOrderDao riderCompletedOrderDao; // 注入数据访问对象

    /**
     * 记录订单完成信息
     * @param order 包含订单完成信息的实体对象
     * @return 操作结果（true-成功，false-失败）
     */
    @Override
    public boolean completeOrder(RiderCompletedOrder order) {
        try {
            // 调用DAO层插入完成订单记录
            riderCompletedOrderDao.insertCompletedOrder(order);
            return true;
        } catch (Exception e) {
            e.printStackTrace(); // 打印异常堆栈信息（生产环境建议使用日志框架）
            return false;
        }
    }

    /**
     * 根据骑手ID获取已完成订单列表
     * @param riderId 骑手ID
     * @return 已完成订单列表
     */
    @Override
    public List<RiderCompletedOrder> getCompletedOrdersByRider(String riderId) {
        return riderCompletedOrderDao.getCompletedOrdersByRider(riderId);
    }

    /**
     * 根据订单编号获取订单完成记录
     * @param orderOn 订单编号
     * @return 订单完成记录实体
     */
    @Override
    public RiderCompletedOrder getOrderCompletionRecord(String orderOn) {
        return riderCompletedOrderDao.getCompletedOrderByOrderOn(orderOn);
    }

    /**
     * 计算骑手总收益
     * @param riderId 骑手ID
     * @return 总收益金额
     */
    @Override
    public Double getTotalEarningsByRider(String riderId) {
        return riderCompletedOrderDao.getTotalEarningsByRider(riderId);
    }

    /**
     * 计算骑手总配送距离
     * @param riderId 骑手ID
     * @return 总配送距离
     */
    @Override
    public Double getTotalDistanceByRider(String riderId) {
        return riderCompletedOrderDao.getTotalDistanceByRider(riderId);
    }

    /**
     * 计算骑手已完成订单数量
     * @param riderId 骑手ID
     * @return 已完成订单数量
     */
    @Override
    public Integer getCompletedOrderCountByRider(String riderId) {
        return riderCompletedOrderDao.getCompletedOrderCountByRider(riderId);
    }

    /**
     * 根据订单编号获取完成订单记录（与getOrderCompletionRecord为同一方法的不同命名）
     * @param orderOn 订单编号
     * @return 订单完成记录实体
     */
    @Override
    public RiderCompletedOrder getCompletedOrderByOrderOn(String orderOn) {
        return riderCompletedOrderDao.getCompletedOrderByOrderOn(orderOn);
    }
}