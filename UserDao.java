package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
	
	public int insertUser(User user);
	public int deleteUser(String user_id);
	public int updateUser(User user);
	public User getUser(String user_id);
	public List<User> getUserAll();

}
