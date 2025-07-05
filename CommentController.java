package com.sdutcm.wm.controller;

import com.sdutcm.wm.pojo.Comment;
import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.OrderItem;
import com.sdutcm.wm.service.CommentService;
import com.sdutcm.wm.service.OrderItemService;
import com.sdutcm.wm.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;

@Controller
public class CommentController {

    // 自动注入CommentService，用于处理评论相关业务逻辑
    @Autowired
    private CommentService commentService;

    // 自动注入OrderService，用于处理订单相关业务逻辑
    @Autowired
    private OrderService orderService;

    // 自动注入OrderItemService，用于处理订单项相关业务逻辑
    @Autowired
    private OrderItemService orderItemService;

    /**
     * 添加评论
     * @param order_on 订单编号
     * @param shop_id 店铺ID
     * @param comment_content 评论内容
     * @param session 当前会话
     * @return 重定向到用户评论列表页面
     */
    @RequestMapping(value = "addComment", method = RequestMethod.POST)
    public String addComment(String order_on, String shop_id, String comment_content, HttpSession session) {
        // 从会话中获取用户ID
        String user_id = (String) session.getAttribute("id");

        // 创建一个新的评论对象
        Comment comment = new Comment();
        comment.setOrder_on(order_on); // 设置订单编号
        comment.setShop_id(shop_id); // 设置店铺ID
        comment.setUser_id(user_id); // 设置用户ID
        comment.setComment_content(comment_content); // 设置评论内容
        comment.setComment_time(new Timestamp(System.currentTimeMillis())); // 设置评论时间

        // 调用CommentService插入评论
        commentService.insertComment(comment);

        // 重定向到用户评论列表页面
        return "redirect:getUserComments";
    }

    /**
     * 获取用户的所有评论
     * @param session 当前会话
     * @param mv ModelAndView对象，用于添加模型数据和设置视图
     * @return 包含用户所有评论的视图
     */
    @RequestMapping(value = "getUserComments", method = RequestMethod.GET)
    public ModelAndView getUserComments(HttpSession session, ModelAndView mv) {
        // 从会话中获取用户ID
        String user_id = (String) session.getAttribute("id");
        // 调用CommentService获取用户的所有评论
        List<Comment> commentList = commentService.getCommentsByUserId(user_id);
        // 将评论列表添加到模型中
        mv.addObject("commentList", commentList);
        // 设置视图名为"user/commentList"
        mv.setViewName("user/commentList");
        return mv;
    }

    /**
     * 查看评论详情
     * @param order_on 订单编号
     * @param mv ModelAndView对象，用于添加模型数据和设置视图
     * @return 包含评论详情的视图
     */
    @RequestMapping(value = "viewCommentDetail", method = RequestMethod.GET)
    public ModelAndView viewCommentDetail(@RequestParam String order_on, ModelAndView mv) {
        // 获取订单信息
        Order order = orderService.getOrderByOn(order_on);
        mv.addObject("order", order);

        // 获取订单项信息
        List<OrderItem> orderItems = orderItemService.getOrderItem(order_on);
        mv.addObject("orderItems", orderItems);

        // 获取评论信息
        Comment comment = commentService.getCommentByOrderOn(order_on);
        mv.addObject("comment", comment);

        // 设置视图名为"user/commentDetail"
        mv.setViewName("user/commentDetail");
        return mv;
    }
}