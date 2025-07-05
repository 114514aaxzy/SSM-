package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.RiderCompletedOrder;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RiderCompletedOrderDao {
    // ������ɵĶ�����¼
    int insertCompletedOrder(RiderCompletedOrder order);
    
    // ��������ID��ѯ����ɵĶ���
    List<RiderCompletedOrder> getCompletedOrdersByRider(@Param("riderId") String riderId);
    
    // ���ݶ�����Ų�ѯ��ɼ�¼
    RiderCompletedOrder getCompletedOrderByOrderOn(@Param("orderOn") String orderOn);
    
    // ��ѯ���ֵ���ɶ���ͳ��
    Integer getCompletedOrderCountByRider(@Param("riderId") String riderId);
    
    // ��ȡ����������
    Double getTotalEarningsByRider(@Param("riderId") String riderId);
    
    // ��ȡ�����ܾ���
    Double getTotalDistanceByRider(@Param("riderId") String riderId);
} 