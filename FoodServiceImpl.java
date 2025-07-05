package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.FoodDao;
import com.sdutcm.wm.pojo.Food;
import com.sdutcm.wm.service.FoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 菜品服务实现类
 * 处理菜品相关的业务逻辑和数据操作
 */
@Service("foodService")
public class FoodServiceImpl implements FoodService {

	@Autowired
	private FoodDao foodDao; // 注入菜品数据访问对象

	/**
	 * 插入新菜品
	 * @param food 菜品实体对象
	 * @return 操作结果（0-菜品已存在，1-插入成功）
	 */
	@Override
	public int insertFood(Food food) {
		// 检查菜品是否已存在（根据food_id和shop_id联合查询）
		Food fd = foodDao.getFood(food.getFood_id(), food.getShop_id());
		if (fd != null) {
			return 0; // 菜品已存在，返回0
		} else {
			// 插入新菜品并返回操作结果
			return foodDao.insertFood(food);
		}
	}

	/**
	 * 获取指定店铺的所有菜品
	 * @param shop_id 店铺ID
	 * @return 菜品列表（若为空则返回null）
	 */
	@Override
	public List<Food> getFoodAll(String shop_id) {
		return foodDao.getFoodAll(shop_id); // 直接返回查询结果，无需null判断（原逻辑冗余）
	}

	/**
	 * 根据菜品ID和店铺ID获取单个菜品
	 * @param food_id 菜品ID
	 * @param shop_id 店铺ID
	 * @return 菜品实体对象（若不存在则返回null）
	 */
	@Override
	public Food getFood(String food_id, String shop_id) {
		return foodDao.getFood(food_id, shop_id);
	}
}