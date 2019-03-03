package org.hj.zb.service.impl;

import org.hj.zb.mapper.UserMapper;
import org.hj.zb.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements IUserService {

    @Resource
    UserMapper userMapper;
    @Override
    public String findPassword(String username) {
        return userMapper.getPasswordByUserName(username);
    }

    @Override
    public List<Map<String, Object>> getUser() {

        return userMapper.getUser();
    }
}
