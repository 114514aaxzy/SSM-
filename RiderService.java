package com.sdutcm.wm.service;

import com.sdutcm.wm.pojo.Rider;

import java.util.List;

public interface RiderService {
	
	public Rider selectRiderById(String ri_id, String ri_pwd);
	public List<Rider> allRider();
	public int registRider(Rider rider);
	public int deleteRider(String rider_id);
	public Rider getRider(String rider_id);
	public int updateRider(Rider rider);
}

