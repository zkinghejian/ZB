package org.hj.zb.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.hj.zb.mapper.MainMapper;
import org.hj.zb.pojo.Type;
import org.hj.zb.service.IMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {

    @Resource
    IMainService mainService;

    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    @RequestMapping("/gettypes")
    @ResponseBody
    public List<Type> getTypes(){

        return mainService.getTypes();
    }

    @RequestMapping("/getshopnames")
    @ResponseBody
    public List<Map<String,Object>> getShopNames(){
        return mainService.getShopnames();
    }

    @RequestMapping(value = "/addDetails",method = RequestMethod.POST)
    @ResponseBody
    public String addDetails(String details){
        return mainService.addDetails(details);
    }

    @RequestMapping(value = "/findDetails",method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String,Object>> findDetailsByDate(String date){
        return mainService.getDetailsByDate(date);
    }

    @RequestMapping(value = "/delDetail/{id}",method = RequestMethod.POST)
    @ResponseBody
    public String delDetailById(@PathVariable("id") int id){
        return mainService.delDetailById(id);
    }


    // 获取顾客类型
    @RequestMapping(value = "/getCosTypes",method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String,Object>> getCosTypes(){
        return mainService.getCosTypes();
    }

    @RequestMapping(value = "/addCoss",method = RequestMethod.POST)
    @ResponseBody
    public String addCoss(String coss){
        return mainService.addCoss(coss);
    }

    @RequestMapping(value = "/delCos/{id}",method = RequestMethod.POST)
    @ResponseBody
    public String delCosById(@PathVariable("id") int id){
        return mainService.delCosById(id);
    }

    @RequestMapping(value = "/findCoss",method = RequestMethod.POST)
    @ResponseBody
    public List<Map<String,Object>> findCossByDate(String date){
        return mainService.getCossByDate(date);
    }

}
