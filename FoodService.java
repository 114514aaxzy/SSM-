package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.Food;

import java.util.List;

public interface FoodService {
	
	public int insertFood(Food food);
	public List<Food> getFoodAll(String shop_id);
	public Food getFood(String food_id, String shop_id);


}
