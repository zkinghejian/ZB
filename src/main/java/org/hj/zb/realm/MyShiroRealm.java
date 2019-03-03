package org.hj.zb.realm;

import org.apache.shiro.authc.*;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.util.ByteSource;
import org.hj.zb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;

public class MyShiroRealm extends JdbcRealm {

    @Autowired
    IUserService iUserService;
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        // 获取用户名
        String username = (String)token.getPrincipal();
        if(username==null) {
            throw new UnknownAccountException();
        }
        String password = iUserService.findPassword(username);

        //logger.info("数据库密码："+password);
        if(password==null) {
            throw new UnknownAccountException();
        }

        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(username,password, ByteSource.Util.bytes("hejian"),this.getName());

        return simpleAuthenticationInfo;
    }
}
