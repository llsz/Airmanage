package cn.lsz.service.impl;

import cn.lsz.dao.AirDao;
import cn.lsz.model.Air;
import cn.lsz.model.Datelimit;
import cn.lsz.model.PageBean;
import cn.lsz.service.AirService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AirServiceImpl implements AirService{
    @Resource
    private AirDao airDao;

    public List<Air> selectAir(){
        return this.airDao.selectAir();
    }
    public Air selectTheAir(Date time,int cityid){
        return airDao.selectTheAir(time,cityid);
    }

    public List<Air> selectAirByDate(Datelimit datelimit){
        return this.airDao.selectAirByDate(datelimit);
    }

    public boolean addAir(Air air){
        return this.airDao.addAir(air);
    }

    public boolean updateAir(Air air){
        return this.airDao.updateAir(air);
    }

    public boolean delAir(Datelimit datelimit){
        return this.airDao.delAir(datelimit);

    }

    public PageBean<Air> findByPage(Datelimit datelimit,int pageCode, int pageSize){
        PageBean<Air> pageBean = new PageBean<Air>();
        Map<String,Object> conMap = new HashMap<String, Object>();
        //封装当前页面信息
        pageBean.setPageCode(pageCode);
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = airDao.selectCount(datelimit);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num = Math.ceil(tc/pageSize);
        pageBean.setTotalPage(num.intValue());

        //设置limit分页起始位置
        conMap.put("cityid",datelimit.getCityid());
        conMap.put("timestart",datelimit.getTimestart());
        conMap.put("timeend",datelimit.getTimeend());
        conMap.put("start",(pageCode - 1) * pageSize);
        conMap.put("size", pageBean.getPageSize());



        //封装每页显示的数据
        List<Air> list = airDao.findByPage(conMap);
        pageBean.setBeanList(list);
        return pageBean;
    }
}
