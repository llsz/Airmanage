package cn.lsz.service;

import cn.lsz.model.Air;
import cn.lsz.model.Datelimit;
import cn.lsz.model.PageBean;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface AirService {
    List<Air> selectAir();   //查询今日数据
    Air selectTheAir(Date time,int cityid);
    List<Air> selectAirByDate(Datelimit datelimit);
    boolean addAir(Air air);   //添加大气质量数据
    boolean delAir(Datelimit datelimit);
    boolean updateAir(Air air);

    //单个分页
    PageBean<Air> findByPage(Datelimit datelimit,int pageCode, int pageSize);

}
