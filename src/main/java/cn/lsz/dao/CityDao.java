package cn.lsz.dao;

import cn.lsz.model.City;

public interface CityDao {
    City selectCityById(int cityid);
    City selectCityByName(String name);
}
