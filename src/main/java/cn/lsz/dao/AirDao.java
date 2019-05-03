package cn.lsz.dao;

import cn.lsz.model.Air;
import cn.lsz.model.DateAll;
import cn.lsz.model.Datelimit;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AirDao {
    List<Air> selectAir();   //查询昨日数据
    List<Air> selectAirByDate(Datelimit datelimit);
    Air selectTheAir(Date time,int cityid);
    boolean addAir(Air air);   //添加大气质量数据
    boolean delAir(Datelimit datelimit);
    boolean updateAir(Air air); //修改

    /*分页查询单个城市*/
    int selectCount(Datelimit datelimit);  //查询单个城市记录数
    List<Air> findByPage(Map<String,Object> conMap);

    /*分页查询*/
    /*int selectAllCount(DateAll dateAll);  //总记录数
    List<Air> findCondition(Map<String,Object> conMap);*/


}
