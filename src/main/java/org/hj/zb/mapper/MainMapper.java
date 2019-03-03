package org.hj.zb.mapper;

import org.apache.ibatis.annotations.Param;
import org.hj.zb.pojo.Type;

import java.util.List;
import java.util.Map;

public interface MainMapper {
    // 获取收支/
    List<Type> getTypes();

    List<Map<String,Object>> getShopnames();

    int addDetails(@Param("list") List<Map> list);

    // 获取改日期的记账情况
    List<Map<String,Object>> getDetailsByDate(@Param("date") String date);

    int delDetailById(@Param("id") int id);

    List<Map<String,Object>> getCosTypes();

    int addCoss(@Param("list") List<Map> list);

    int delCosById(int id);

    List<Map<String, Object>> getCossByDate(String date);
}
