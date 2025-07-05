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
 * 骑手已完成订单控制器
 * 处理骑手已完成订单的查询和完成订单的请求
 */
@Controller
@RequestMapping("/rider/completed-orders")
public class RiderCompletedOrderController {

    @Autowired
    private RiderCompletedOrderService riderCompletedOrderService; // 注入骑手已完成订单服务

    /**
     * 获取骑手已完成订单列表及统计信息
     * @param session HTTP会话（获取当前骑手ID）
     * @return 包含已完成订单和统计数据的ModelAndView对象
     */
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView getCompletedOrders(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        String riderId = (String) session.getAttribute("id");

        try {
            // 获取骑手的已完成订单列表
            List<RiderCompletedOrder> completedOrders = riderCompletedOrderService.getCompletedOrdersByRider(riderId);
            mv.addObject("completedOrders", completedOrders);

            // 获取骑手配送统计数据
            Double totalEarnings = riderCompletedOrderService.getTotalEarningsByRider(riderId);     // 总收益
            Double totalDistance = riderCompletedOrderService.getTotalDistanceByRider(riderId);     // 总配送距离
            Integer completedOrderCount = riderCompletedOrderService.getCompletedOrderCountByRider(riderId);  // 已完成订单数

            mv.addObject("totalEarnings", totalEarnings);
            mv.addObject("totalDistance", totalDistance);
            mv.addObject("completedOrderCount", completedOrderCount);
            mv.setViewName("rider/completedOrders");  // 跳转到骑手已完成订单页面
        } catch (Exception e) {
            mv.addObject("error", "获取数据失败：" + e.getMessage());
            mv.setViewName("error");  // 异常时跳转到错误页面
        }

        return mv;
    }

    /**
     * 处理骑手完成订单的请求（API接口）
     * @param order 骑手完成订单的信息
     * @param session HTTP会话（获取当前骑手ID）
     * @return 包含操作结果的JSON响应
     */
    @RequestMapping(value = "/complete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> completeOrder(RiderCompletedOrder order, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String riderId = (String) session.getAttribute("id");
        order.setRiderId(riderId);  // 设置当前骑手ID到订单完成记录

        try {
            boolean success = riderCompletedOrderService.completeOrder(order);  // 调用服务层完成订单
            response.put("success", success);
            response.put("message", success ? "订单已完成" : "操作失败");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "系统错误：" + e.getMessage());
        }

        return response;
    }
}