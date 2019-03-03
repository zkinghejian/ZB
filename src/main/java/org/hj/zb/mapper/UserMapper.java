package org.hj.zb.mapper;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    String getPasswordByUserName(String username);

    List<Map<String,Object>> getUser();
}
