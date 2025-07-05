package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.CommentDao;
import com.sdutcm.wm.pojo.Comment;
import com.sdutcm.wm.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;

	@Override
	public int insertComment(Comment comment) {
		// 插入新的评论
		return commentDao.insertComment(comment);
	}

	@Override
	public List<Comment> getCommentsByUserId(String user_id) {
		// 根据用户ID获取所有评论
		return commentDao.getCommentsByUserId(user_id);
	}

	@Override
	public Comment getCommentByOrderOn(String order_on) {
		// 根据订单编号获取评论
		return commentDao.getCommentByOrderOn(order_on);
	}
}