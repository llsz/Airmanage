package cn.lsz.controller;

import cn.lsz.model.Admin;
import cn.lsz.model.Air;
import cn.lsz.model.Datelimit;
import cn.lsz.model.PageBean;
import cn.lsz.service.AdminService;
import cn.lsz.service.AirService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static cn.lsz.system.Dateselect.getFirstDay;
import static cn.lsz.system.Dateselect.getNDateend;


@Controller
@RequestMapping("/admin")
public class AdminController {
    @Resource
    private AdminService adminService;
    @Resource
    private AirService airService;


    @RequestMapping("/toadmin")
    public String toAdmin(HttpServletRequest request){
        return "adminLogin";
    }

    /**
     * 检查id,密码
     * @param id
     * @param password
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/checklogin")
    @ResponseBody
    public String checkLogin(String id, String password, HttpServletRequest request)throws IOException{
        request.setCharacterEncoding("utf-8");
        String status = "no";
        Admin admin = adminService.selectAdmin(id,password);
        Admin admin1 = adminService.selectAdminById(id);
        if(admin != null){
            status = "ok";
        }else {
            if(admin1 != null){
                status = "pwdError";
            }else {
                status = "idError";
            }
        }

        return status;
    }

    /**
     * 跳转至管理员界面
     * @param id
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/login")
    public String adminLogin(@RequestParam(value="pageCode",defaultValue = "1",required = false)int pageCode,
                             @RequestParam(value="pageSize",defaultValue = "5",required = false)int pageSize,
                             String id,Model model, HttpServletRequest request){
        Admin admin = adminService.selectAdminById(id);

        if(admin != null){
            model.addAttribute("id",admin.getId());
            Datelimit datelimit = new Datelimit();
            datelimit.setTimestart(getFirstDay(new Date()));
            datelimit.setTimeend(getNDateend(-1));
            datelimit.setCityid(0);

            Map<String,Object> conMap = new HashMap<String, Object>();

            PageBean<Air> pageBean = airService.findByPage(datelimit,pageCode,pageSize);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            model.addAttribute("cityid","0");
            model.addAttribute("pageBean",pageBean);
            model.addAttribute("time1",sdf.format(datelimit.getTimestart()));
            model.addAttribute("time2",sdf.format(datelimit.getTimeend()));
            model.addAttribute("id",id);
            return "adminView";
        }else {
            return "adminLogin";
        }
    }



}
