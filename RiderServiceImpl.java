package com.sdutcm.wm.service.impl;

import com.sdutcm.wm.dao.OrderDao;
import com.sdutcm.wm.dao.RiderDao;
import com.sdutcm.wm.pojo.Order;
import com.sdutcm.wm.pojo.Rider;
import com.sdutcm.wm.service.RiderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("riderService")
@Transactional
public class RiderServiceImpl implements RiderService {

	@Autowired
//	@Qualifier("riderDao")
	private RiderDao riderDao;

	@Autowired
	private OrderDao orderDao;

	@Override
	public Rider selectRiderById(String ri_id, String ri_pwd) {
		// 根据骑手ID获取骑手信息
		Rider rider = riderDao.getRider(ri_id);

		// 如果骑手不存在，返回null
		if(rider==null){
			return null;
		} else{
			// 如果骑手存在，验证密码是否匹配
			if(rider.getRider_id().equals(ri_id)&&rider.getRider_pwd().equals(ri_pwd))
				return rider;
			else
				return null;
		}
	}

	@Override
	public List<Rider> allRider() {
		// 获取所有骑手信息
		List<Rider> rider = riderDao.getRiderAll();

		// 如果骑手列表为空，返回null
		if(rider==null)
			return null;
		else
			return rider;
	}

	@Override
	public int registRider(Rider rider) {
		// 检查骑手ID是否已存在
		Rider re = riderDao.getRider(rider.getRider_id());
		if(re != null)
			return 0; // 如果骑手已存在，返回0
		else{
			// 插入新骑手
			int i = riderDao.insertRider(rider);
			if(i==0)
				return 0; // 如果插入失败，返回0
			else
				return 1; // 如果插入成功，返回1
		}
	}

	@Override
	public int deleteRider(String rider_id) {
		// 检查骑手是否有未完成的订单
		int i = 0;
		List<Order> order = orderDao.getOrderAllByRider(rider_id);
		if((order == null)||(order.isEmpty())){
			// 如果没有未完成的订单，删除骑手
			i = riderDao.deleteRider(rider_id);
			return i;
		}
		else
		{
			// 如果有未完成的订单，返回0
			for(Order list : order)
			{
				if(list.getOrder_status() == 5)
					return 0;
			}
			// 如果没有未完成的订单，删除骑手
			i = riderDao.deleteRider(rider_id);
			return i;
		}
	}

	@Override
	public Rider getRider(String rider_id) {
		// 根据骑手ID获取骑手信息
		Rider rider = riderDao.getRider(rider_id);
		if(rider == null)
			return null;
		else
			return rider;
	}

	@Override
	public int updateRider(Rider rider) {
		// 更新骑手信息
		int i = riderDao.updateRider(rider);
		return i;
	}

}