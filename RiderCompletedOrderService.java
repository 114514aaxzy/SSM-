package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.RiderCompletedOrder;

import java.util.List;

public interface RiderCompletedOrderService {
    // ��ɶ���
    boolean completeOrder(RiderCompletedOrder order);
    
    // ��ȡ���ֵ�����ɶ����б�
    List<RiderCompletedOrder> getCompletedOrdersByRider(String riderId);
    
    // ��ȡ��������ɼ�¼
    RiderCompletedOrder getOrderCompletionRecord(String orderOn);
    
    // ��ȡ������ɵĶ�������
    Integer getCompletedOrderCountByRider(String riderId);
    
    // ��ȡ������ɵ�������
    Double getTotalEarningsByRider(String riderId);
    
    // ��ȡ������ɵ��ܾ���
    Double getTotalDistanceByRider(String riderId);
    
    // ��ȡ������ɵĶ�������
    RiderCompletedOrder getCompletedOrderByOrderOn(String orderOn);
} 