package org.hj.zb;

import org.hj.zb.mapper.MainMapper;
import org.hj.zb.pojo.Type;
import org.hj.zb.service.IMainService;
import org.hj.zb.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = {ZbApplication.class})
@MapperScan(basePackages = "org.hj.zb.mapper")
public class ZbApplicationTests {

    @Autowired
    private IUserService iUserService;
    @Autowired
    private IMainService iMainService;

    @Test
    public void contextLoads() {
        //String password = iUserService.findPassword("admin");
        List<Map<String,Object>> list = iUserService.getUser();
        for (Map<String,Object> map:list) {
            System.out.println(map.get("id"));
            System.out.println(map.get("username"));
            System.out.println(map.get("password"));
        }


    }
    @Test
    public void test1(){
        List<Type> list = iMainService.getTypes();
        /*for (Map<String,Object> map:list) {
            System.out.println(map.get("typesno"));
            System.out.println(map.get("typesname"));
            System.out.println(((Map<String,Object>)map.get("types")).get("typeid"));
            System.out.println(((Map<String,Object>)map.get("types")).get("typename"));
        }*/
    }
    @Test
    public void testGetShopNames(){
        List<Map<String,Object>> names = iMainService.getShopnames();
        for(Map map:names){
            System.out.println(map.get("id"));
            System.out.println(map.get("shopname"));
        }
    }

    @Test
    public void testFindDetailsByDate(){
        List<Map<String,Object>> list = iMainService.getDetailsByDate("2019-01-25");
        for (Map<String,Object> map: list) {
            System.out.println(map.get("id"));
            System.out.println(map.get("shopname"));
            System.out.println(map.get("money"));
        }
    }


}

