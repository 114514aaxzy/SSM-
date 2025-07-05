package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.User;

import java.util.List;

public interface UserService {
	
	public User selectUserById(String user_id, String user_pwd);
	public List<User> allUser();
	public User getUser(String user_id);
	public int updateUser(User user);
	public int registUser(User user);
	public int deleteUser(String user_id);

}
