package org.hj.zb.util;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.ss.usermodel.CellStyle;
import org.hj.zb.service.IMainService;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

public class ExcelUtil {

    @Resource
    IMainService mainService;

    public HSSFWorkbook getHSSWB(String shopname,String starttime,String endtime){
        //创建HSSFWorkbook对象(excel的文档对象)
        HSSFWorkbook wb = new HSSFWorkbook();
        return null;
    }
    // 生成客源分析表格
    public HSSFSheet getKYFXSheet(HSSFWorkbook wb,String shopname,String starttime,String endtime){
        //建立新的sheet对象（excel的表单）
        HSSFSheet sheet=wb.createSheet("客源分析");
        //在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row0=sheet.createRow(0);
        row0.createCell(0).setCellValue("客源分析_"+shopname+"("+starttime+"-"+endtime+")");
        HSSFRow row1 = sheet.createRow(1);
        // 获取客源类型
        List<Map<String,Object>> types = mainService.getCosTypes();
        for (int i=0;i<types.size();i++) {
            row1.createCell(i+1).setCellValue(types.get(i).get("costypename").toString());
        }
        // 合计
        row1.createCell(types.size()+1).setCellValue("合计");

        HSSFRow row2 = sheet.createRow(2);
        row2.createCell(0).setCellValue("日期");
        String[] ts = {"上午","人数","下午","人数","合计","人数","人均"};
        for(int i=0;i<3;i++){
            for(int j=0;j<ts.length;j++){
                
            }
        }
        return null;
    }
}
