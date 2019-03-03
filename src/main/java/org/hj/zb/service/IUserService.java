package org.hj.zb.service;

import java.util.List;
import java.util.Map;

public interface IUserService {
    String findPassword(String username);
    List<Map<String,Object>> getUser();

}
