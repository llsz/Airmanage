package cn.lsz.service.impl;

import cn.lsz.dao.CityDao;
import cn.lsz.model.City;
import cn.lsz.service.CityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CityServiceImpl implements CityService{

    @Resource
    private CityDao cityDao;

    public City selectCityById(int id){
        return this.cityDao.selectCityById(id);
    }

    public City selectCityByName(String name){
        return this.cityDao.selectCityByName(name);
    }
}
