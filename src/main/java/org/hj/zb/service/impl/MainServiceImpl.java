package org.hj.zb.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.hj.zb.mapper.MainMapper;
import org.hj.zb.pojo.Type;
import org.hj.zb.service.IMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class MainServiceImpl implements IMainService {

    @Resource
    MainMapper mainMapper;

    @Override
    public List<Type> getTypes() {

        return mainMapper.getTypes();
    }

    @Override
    public List<Map<String, Object>> getShopnames() {
        return mainMapper.getShopnames();
    }

    @Override
    public String addDetails(String details) {
        List<Map> list = JSONObject.parseArray(details,Map.class);
        int i = mainMapper.addDetails(list);
        if(i>0){
            return "success";
        }else{
            return "数据库异常稍后访问";
        }
    }

    @Override
    public List<Map<String,Object>> getDetailsByDate(String date) {
        return mainMapper.getDetailsByDate(date);
    }

    @Override
    public String delDetailById(int id) {
        if(mainMapper.delDetailById(id)>0){
            return "success";
        }
        return "删除失败";
    }

    @Override
    public List<Map<String, Object>> getCosTypes() {
        return mainMapper.getCosTypes();
    }

    @Override
    public String addCoss(String coss) {
        List<Map> list = JSONObject.parseArray(coss,Map.class);
        int i = mainMapper.addCoss(list);
        if(i>0){
            return "success";
        }else{
            return "数据库异常稍后访问";
        }
    }

    @Override
    public String delCosById(int id) {
        if(mainMapper.delCosById(id)>0){
            return "success";
        }
        return "删除失败";
    }

    @Override
    public List<Map<String, Object>> getCossByDate(String date) {
        return mainMapper.getCossByDate(date);
    }
}
