package org.hj.zb.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.hj.zb.realm.MyShiroRealm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.apache.shiro.mgt.SecurityManager;

import javax.sql.DataSource;
import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {

    @Autowired
    private DruidDataSource druidDataSource;
    @Bean
    public MyShiroRealm myShiroRealm(){
        MyShiroRealm myShiroRealm = new MyShiroRealm();
        myShiroRealm.setDataSource(druidDataSource);
        return myShiroRealm;
    }

    // shiro 安全管理器
    @Bean
    public SecurityManager securityManager(){
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(myShiroRealm());
        return securityManager;
    }


    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(){
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        shiroFilter.setLoginUrl("/tologin");
        shiroFilter.setUnauthorizedUrl("/tologin");
        shiroFilter.setSuccessUrl("/main");
        shiroFilter.setSecurityManager(securityManager());
        // 过滤器集合
        Map<String,String> filterChainDefinitioinMap = new LinkedHashMap<String, String>();
        filterChainDefinitioinMap.put("/css/**","anon");
        filterChainDefinitioinMap.put("/fonts/**","anon");
        filterChainDefinitioinMap.put("/js/**","anon");
        filterChainDefinitioinMap.put("/img/**","anon");
        filterChainDefinitioinMap.put("/tologin","anon");
        filterChainDefinitioinMap.put("/login","anon");
        filterChainDefinitioinMap.put("/**","authc");
        //filterChainDefinitioinMap.put("/testpermissions" ,"perms[\"admin:update\",\"admin:delete\"]");

        shiroFilter.setFilterChainDefinitionMap(filterChainDefinitioinMap);
        return shiroFilter;
    }


}
