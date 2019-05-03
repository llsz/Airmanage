package cn.lsz.controller;

import cn.lsz.model.Air;
import cn.lsz.model.Airinfo;
import cn.lsz.model.Datelimit;
import cn.lsz.model.PageBean;
import cn.lsz.service.AirService;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import static cn.lsz.system.Airjudge.*;
import static cn.lsz.system.DataCount.countAir;
import static cn.lsz.system.DataCount.dataLimit;
import static cn.lsz.system.Dateselect.*;
import static cn.lsz.system.ElmanPredict.*;

@Controller
public class AirController {

    @Resource
    private AirService airService;

    /**
     * 初始登陆页面展示
     * */
    @RequestMapping("/show")

    public String showAir(Model model, HttpServletRequest request,String cityid){
        /*展示昨天大气数据*/
        List<Air> airs = airService.selectAir();
        List<Air> today = new ArrayList<Air>();
        for(int i=0; i<airs.size();i++){
            Air aa = countAir(airs.get(i),1);
            today.add(aa);
        }

        model.addAttribute("airs",today);

        Datelimit datelimit = new Datelimit();
        datelimit.setTimeend(getNDateend(-1));
        datelimit.setTimestart(getNDatestart(-4));
        datelimit.setCityid(Integer.parseInt(cityid));
        List<Air> airList = airService.selectAirByDate(datelimit);
        Air air = predictElman(airList);
        long[] d = aqiJudge(air.getAqi());
        model.addAttribute("max",d[0]);
        model.addAttribute("min",d[1]);
        model.addAttribute("air",air);
        model.addAttribute("yestoday",getNDate(-1));
        model.addAttribute("today",new Date());
        return "showAir";
    }

    /**
     * 预测今日数据
     * */
    @RequestMapping("/predict")
    @ResponseBody
    public Airinfo predictAir(String cityid,HttpServletRequest request)throws IOException{
        Datelimit datelimit = new Datelimit();
        datelimit.setTimeend(getNDateend(-1));
        datelimit.setTimestart(getNDatestart(-4));
        datelimit.setCityid(Integer.parseInt(cityid));
        List<Air> airList = airService.selectAirByDate(datelimit);
        Air air = new Air();
        if(cityid == "1"){
            air = predictElman(airList);
        }else if(cityid == "2"){
            air = ly_Elman(airList);
        }else if(cityid == "3"){
            air = np_Elman(airList);
        }else if(cityid == "4"){
            air = nd_Elman(airList);
        }else if(cityid == "5"){
            air = pt_Elman(airList);
        }else if(cityid == "6"){
            air = qz_Elman(airList);
        }else if(cityid == "7"){
            air = sm_Elman(airList);
        }else if(cityid == "8"){
            air = xm_Elman(airList);
        }else {
            air = zz_Elman(airList);
        }

        air.setLevel(levelJudge(air.getAqi()));
        Airinfo airinfo = new Airinfo();
        airinfo.setHealth(healthJudge(air.getAqi()));

        long[] d = aqiJudge(air.getAqi());

        airinfo.setPm25(dataLimit(air.getPm2_5(),5,10));
        airinfo.setPm10(dataLimit(air.getPm10(),10,10));
        airinfo.setSo2(dataLimit(air.getSo2(),1,1));
        airinfo.setNo2(dataLimit(air.getNo2(),10,10));
        airinfo.setO3(dataLimit(air.getO3(),20,10));
        airinfo.setAir(air);
        airinfo.setMax(d[0]);
        airinfo.setMin(d[1]);

        airinfo.setCityname(cityJudge(Integer.parseInt(cityid)));
        return airinfo;
    }

    /**
     * 跳转至历史天气页面
     * */
    @RequestMapping("/showhistory")
    public String showHistory(@RequestParam(value="pageCode",defaultValue = "1",required = false)int pageCode,
                              @RequestParam(value="pageSize",defaultValue = "5",required = false)int pageSize,
                              String cityid, Model model, HttpServletRequest request){
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getFirstDay(new Date()));
        datelimit.setTimeend(getNDateend(-1));
        datelimit.setCityid(Integer.parseInt(cityid));
        Map<String,Object> conMap = new HashMap<String, Object>();

        PageBean<Air> pageBean = airService.findByPage(datelimit,pageCode,pageSize);
        List<Air> airs = airService.selectAirByDate(datelimit);

        List<Date> dates = findDates(datelimit.getTimestart(),datelimit.getTimeend());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        model.addAttribute("pageBean",pageBean);
        model.addAttribute("airs",airs);
        model.addAttribute("cityid",cityid);
        model.addAttribute("city",cityJudge(datelimit.getCityid()));
        model.addAttribute("time1",sdf.format(datelimit.getTimestart()));
        model.addAttribute("time2",sdf.format(datelimit.getTimeend()));
        model.addAttribute("dates",dates);
        return "history";
    }

    /**
     * 搜索历史污染物信息
     * */
    @RequestMapping("/history")
    public String historyData(@RequestParam(value="pageCode",defaultValue = "1",required = false)int pageCode,
                              @RequestParam(value="pageSize",defaultValue = "5",required = false)int pageSize,
                              @RequestParam(value ="timestart",required =false) String timestart,
                              @RequestParam(value = "timeend",required = false) String timeend,
                              String cityid,Model model,HttpServletRequest request){
        Datelimit datelimit = new Datelimit();
        if(timestart == null || timestart == "" || timeend == null || timeend == ""){
            datelimit.setTimestart(getFirstDay(new Date()));
            datelimit.setTimeend(getNDateend(-1));

        }else {
            Date start = toDate(timestart);
            Date end = toDate(timeend);
            datelimit.setTimestart(getZero(start));
            datelimit.setTimeend(getNight(end));
        }
        datelimit.setCityid(Integer.parseInt(cityid));
        Map<String,Object> conMap = new HashMap<String, Object>();

        PageBean<Air> pageBean = airService.findByPage(datelimit,pageCode,pageSize);
        List<Air> airs = airService.selectAirByDate(datelimit);

        List<Date> dates = findDates(datelimit.getTimestart(),datelimit.getTimeend());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        model.addAttribute("pageBean",pageBean);
        model.addAttribute("airs",airs);
        model.addAttribute("cityid",cityid);
        model.addAttribute("city",cityJudge(datelimit.getCityid()));
        model.addAttribute("time1",sdf.format(datelimit.getTimestart()));
        model.addAttribute("time2",sdf.format(datelimit.getTimeend()));
        model.addAttribute("dates",dates);
        return "history";
    }

    @RequestMapping("/export")
    public String exportExcel(@RequestParam(value ="timestart",required =false) String timestart,
                              @RequestParam(value = "timeend",required = false) String timeend,
                              String cityid,HttpServletResponse response){
        Datelimit datelimit = new Datelimit();
        if(timestart == "" || timestart == null || timeend == null || timeend == ""){
            datelimit.setTimestart(getFirstDay(new Date()));
            datelimit.setTimeend(getNDateend(-1));

        }else {
            Date start = toDate(timestart);
            Date end = toDate(timeend);
            datelimit.setTimestart(getZero(start));
            datelimit.setTimeend(getNight(end));
        }
        datelimit.setCityid(Integer.parseInt(cityid));
        List<Air> airs = airService.selectAirByDate(datelimit);
        String cityname = cityJudge(Integer.parseInt(cityid));
        /*导出表格*/
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("大气质量数据");
        /*设置单元格格式*/
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中
        sheet.setColumnWidth(0, 256*15);  //第一列宽度
        String time1 = dateToString(datelimit.getTimestart());
        String time2 = dateToString(datelimit.getTimeend());
        HSSFRow row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("日期");
        row1.createCell(1).setCellValue("aqi");
        row1.createCell(2).setCellValue("质量等级");
        row1.createCell(3).setCellValue("PM2.5");
        row1.createCell(4).setCellValue("PM10");
        row1.createCell(5).setCellValue("SO2");
        row1.createCell(6).setCellValue("CO");
        row1.createCell(7).setCellValue("NO2");
        row1.createCell(8).setCellValue("O3");

        for(int i=1;i<airs.size()+1;i++){
            HSSFRow row = sheet.createRow(i);
            row.createCell(0).setCellValue(dateToString(airs.get(i-1).getTime()));
            row.createCell(1).setCellValue(Math.round(airs.get(i-1).getAqi()));
            row.createCell(2).setCellValue(airs.get(i-1).getLevel());
            row.createCell(3).setCellValue(Math.round(airs.get(i-1).getPm2_5()));
            row.createCell(4).setCellValue(Math.round(airs.get(i-1).getPm10()));
            row.createCell(5).setCellValue(Math.round(airs.get(i-1).getSo2()));
            row.createCell(6).setCellValue(String.format("%.1f", airs.get(i-1).getCo()));
            row.createCell(7).setCellValue(Math.round(airs.get(i-1).getNo2()));
            row.createCell(8).setCellValue(Math.round(airs.get(i-1).getO3()));
        }
        HSSFRow row2 = sheet.createRow(airs.size()+1);
        HSSFCell cell = row2.createCell(0);
        cell.setCellValue("数值单位：μg/m3(CO为mg/m3)");
        sheet.addMergedRegion(new CellRangeAddress(airs.size()+1,airs.size()+1,0,3));

        String filename = time1 + "至" + time2 + cityname + "大气质量数据统计" + ".xls";
        try {
            OutputStream output=response.getOutputStream();
            response.reset();
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            filename = new String(filename.getBytes(), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment;filename="+ filename);
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
            wb.write(output);
            output.flush();
            output.close();
        }catch (IOException e){
            e.printStackTrace();
        }


        return null;

    }





}
