package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.RiderCompletedOrder;
import com.sdutcm.wm.service.RiderCompletedOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ��������ɶ���������
 * ������������ɶ����Ĳ�ѯ����ɶ���������
 */
@Controller
@RequestMapping("/rider/completed-orders")
public class RiderCompletedOrderController {

    @Autowired
    private RiderCompletedOrderService riderCompletedOrderService; // ע����������ɶ�������

    /**
     * ��ȡ��������ɶ����б�ͳ����Ϣ
     * @param session HTTP�Ự����ȡ��ǰ����ID��
     * @return ��������ɶ�����ͳ�����ݵ�ModelAndView����
     */
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getCompletedOrders(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        String riderId = (String) session.getAttribute("id");

        try {
            // ��ȡ���ֵ�����ɶ����б�
            List<RiderCompletedOrder> completedOrders = riderCompletedOrderService.getCompletedOrdersByRider(riderId);
            mv.addObject("completedOrders", completedOrders);

            // ��ȡ��������ͳ������
            Double totalEarnings = riderCompletedOrderService.getTotalEarningsByRider(riderId);     // ������
            Double totalDistance = riderCompletedOrderService.getTotalDistanceByRider(riderId);     // �����;���
            Integer completedOrderCount = riderCompletedOrderService.getCompletedOrderCountByRider(riderId);  // ����ɶ�����

            mv.addObject("totalEarnings", totalEarnings);
            mv.addObject("totalDistance", totalDistance);
            mv.addObject("completedOrderCount", completedOrderCount);
            mv.setViewName("rider/completedOrders");  // ��ת����������ɶ���ҳ��
        } catch (Exception e) {
            mv.addObject("error", "��ȡ����ʧ�ܣ�" + e.getMessage());
            mv.setViewName("error");  // �쳣ʱ��ת������ҳ��
        }

        return mv;
    }

    /**
     * ����������ɶ���������API�ӿڣ�
     * @param order ������ɶ�������Ϣ
     * @param session HTTP�Ự����ȡ��ǰ����ID��
     * @return �������������JSON��Ӧ
     */
    @RequestMapping(value = "/complete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> completeOrder(RiderCompletedOrder order, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String riderId = (String) session.getAttribute("id");
        order.setRiderId(riderId);  // ���õ�ǰ����ID��������ɼ�¼

        try {
            boolean success = riderCompletedOrderService.completeOrder(order);  // ���÷������ɶ���
            response.put("success", success);
            response.put("message", success ? "���������" : "����ʧ��");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "ϵͳ����" + e.getMessage());
        }

        return response;
    }
}