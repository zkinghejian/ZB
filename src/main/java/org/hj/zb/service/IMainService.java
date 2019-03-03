package org.hj.zb.service;

import org.hj.zb.pojo.Type;

import java.util.List;
import java.util.Map;

public interface IMainService {
    List<Type> getTypes();

    List<Map<String,Object>> getShopnames();

    String addDetails(String details);

    // 获取改日期的记账情况
    List<Map<String,Object>> getDetailsByDate(String date);

    String delDetailById(int id);
    List<Map<String,Object>> getCosTypes();

    String addCoss(String coss);

    String delCosById(int id);

    List<Map<String, Object>> getCossByDate(String date);
}
