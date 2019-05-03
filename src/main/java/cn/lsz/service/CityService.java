package cn.lsz.service;

import cn.lsz.model.City;

public interface CityService {
    City selectCityById(int cityid);
    City selectCityByName(String cityname);
}
