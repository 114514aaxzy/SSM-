package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.UserDao;
import com.sdutcm.wm.pojo.User;
import com.sdutcm.wm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Override
	public User selectUserById(String user_id, String user_pwd) {
		// 根据用户ID获取用户信息
		User user = userDao.getUser(user_id);

		// 如果用户不存在，返回null
		if(user==null){
			return null;
		}else{
			// 如果用户存在，验证密码是否匹配
			if(user.getUser_id().equals(user_id)&&user.getUser_pwd().equals(user_pwd))
				return user;
			else
				return null;
		}
	}

	@Override
	public List<User> allUser() {
		// 获取所有用户信息
		List<User> user = userDao.getUserAll();

		// 如果用户列表为空，返回null
		if(user==null)
			return null;
		else
			return user;
	}

	@Override
	public User getUser(String user_id) {
		// 根据用户ID获取用户信息
		User user = userDao.getUser(user_id);
		return user;
	}

	@Override
	public int updateUser(User user) {
		// 更新用户信息
		int i = userDao.updateUser(user);
		return i;
	}

	@Override
	public int registUser(User user) {
		// 检查用户ID是否已存在
		User ur = userDao.getUser(user.getUser_id());
		if(ur != null)
			return 0; // 如果用户已存在，返回0
		else{
			// 插入新用户
			int i = userDao.insertUser(user);
			if(i==0)
				return 0; // 如果插入失败，返回0
			else
				return 1; // 如果插入成功，返回1
		}

	}

	@Override
	public int deleteUser(String user_id) {
		// 删除用户
		return userDao.deleteUser(user_id);
	}

}