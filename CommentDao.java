package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.Comment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentDao {
	public int insertComment(Comment comment);
	public List<Comment> getCommentsByUserId(@Param("user_id") String user_id);
	public Comment getCommentByOrderOn(@Param("order_on") String order_on);
}
