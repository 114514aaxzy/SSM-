package com.sdutcm.wm.dao;

import com.sdutcm.wm.pojo.Rider;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RiderDao {
	
	public int insertRider(Rider rider);
	public int deleteRider(String rider_id);
	public int updateRider(Rider rider);
	public Rider getRider(String rider_id);
	public List<Rider> getRiderAll();

}
