package cn.lsz.controller;

import cn.lsz.model.Air;
import cn.lsz.model.Datelimit;
import cn.lsz.model.PageBean;
import cn.lsz.service.AirService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cn.lsz.system.Airjudge.cityJudge;
import static cn.lsz.system.Airjudge.levelJudge;
import static cn.lsz.system.Airjudge.level_Judge;
import static cn.lsz.system.Dateselect.*;

@Controller
public class AirmangerController {
    @Resource
    private AirService airService;

    /**
     * 管理员主界面
     * @return
     */
    @RequestMapping("/showAir")
    public String showHistory(@RequestParam(value="pageCode",defaultValue = "1",required = false)int pageCode,
                              @RequestParam(value="pageSize",defaultValue = "5",required = false)int pageSize,
                              @RequestParam(value ="timestart",required =false) String timestart,
                              @RequestParam(value = "timeend",required = false) String timeend,
                              @RequestParam(value = "cityid",required = false)String cityid,
                              Model model,HttpServletRequest request){
        System.out.println(cityid);
        Datelimit datelimit = new Datelimit();
        if(timestart == "" || timestart == null || timeend == null || timeend == ""){
            datelimit.setTimestart(getFirstDay(new Date()));
            datelimit.setTimeend(new Date());

        }else {
            Date start = toDate(timestart);
            Date end = toDate(timeend);
            datelimit.setTimestart(getZero(start));
            datelimit.setTimeend(getNight(end));
        }
        if(cityid == null || cityid == ""){
            datelimit.setCityid(0);
        }else {
            datelimit.setCityid(Integer.parseInt(cityid));
        }

        Map<String,Object> conMap = new HashMap<String, Object>();

        PageBean<Air> pageBean = airService.findByPage(datelimit,pageCode,pageSize);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        model.addAttribute("pageBean",pageBean);
        model.addAttribute("cityid",cityid);

        model.addAttribute("time1",sdf.format(datelimit.getTimestart()));
        model.addAttribute("time2",sdf.format(datelimit.getTimeend()));
        return "adminView";
    }

    /**
     * 删除污染物信息
     * @param time
     * @param cityid
     * @param request
     * @return
     */
    @RequestMapping("/delAir")
    @ResponseBody
    public String airDel(String time,String cityid,HttpServletRequest request){
        String status = "no";
        Date date = dateToDate(time);
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getZero(date));
        datelimit.setTimeend(getNight(date));
        datelimit.setCityid(Integer.parseInt(cityid));
        if(airService.delAir(datelimit)){
            status = "ok";
        }

        return status;
    }


    @RequestMapping("getAir")
    public String getAir(String time, String cityid,
                         Model model,HttpServletRequest request){

        Date date = dateToDate(time);
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getZero(date));
        datelimit.setTimeend(getNight(date));
        datelimit.setCityid(Integer.parseInt(cityid));
        Air air = airService.selectAirByDate(datelimit).get(0);

        model.addAttribute("air",air);
        return "airEdit";

    }

    /*修改数据*/
    @RequestMapping("/editAir")
    @ResponseBody
    public String editAir(Air air,Model model,HttpServletRequest request){
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getZero(air.getTime()));
        datelimit.setTimeend(getNight(air.getTime()));
        datelimit.setCityid(air.getCityid());
        Date date = airService.selectAirByDate(datelimit).get(0).getTime();
        air.setTime(date);
        //air.setLevel(levelJudge(air.getAqi()));
        String status = "no";
        if(airService.updateAir(air)){
            status = "ok";
        }
        return status;
    }

    /**
     * 跳转至添加页面
     * @return
     */
    @RequestMapping("/addview")
    public String addView(){
        return "airAdd";
    }

    /**
     * 检查信息是否存在
     * @param time
     * @param cityid
     * @param request
     * @return
     */
    @RequestMapping("/checkAir")
    @ResponseBody
    public String checkAir(String time,String cityid,HttpServletRequest request){
        String status = "no";
        Date date = toDate(time);
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getZero(date));
        datelimit.setTimeend(getNight(date));
        datelimit.setCityid(Integer.parseInt(cityid));
        if(airService.selectAirByDate(datelimit).size() == 0){
            status = "ok";
        }
        return status;
    }

    /**
     * 添加污染物信息
     * @param air
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/addAir")
    @ResponseBody
    public String addAir(Air air,Model model,HttpServletRequest request){
        air.setLevel(level_Judge(air.getAqi()));
        String status = "no";
        if(airService.addAir(air)){
            status = "ok";
        }
        return status;
    }
}
