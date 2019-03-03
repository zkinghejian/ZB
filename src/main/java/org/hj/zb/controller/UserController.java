package org.hj.zb.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.hj.zb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class UserController {

    @Autowired
    IUserService iUserService;

    @RequestMapping(value="/login",method = RequestMethod.POST)
    @ResponseBody
    public String subLogin(String username,String password,boolean rememberMe){
        UsernamePasswordToken token = new UsernamePasswordToken(username,password,rememberMe);
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token);
        }catch (UnknownAccountException e) {
            return "用户名不存在";
        } catch (IncorrectCredentialsException e) {
            return "密码错误";
        } catch (Exception e) {
            return "认证失败";
        }
        return "success";
    }

    @RequestMapping(value = "/tologin",method = RequestMethod.GET)
    public String test(String name){

        return "login";
    }

    @RequestMapping(value = "/loginout",method = RequestMethod.GET)
    public String test(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:tologin";
    }
}
