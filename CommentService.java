package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.Comment;

import java.util.List;

public interface CommentService {
	int insertComment(Comment comment);
	List<Comment> getCommentsByUserId(String user_id);
	Comment getCommentByOrderOn(String order_on);
}
