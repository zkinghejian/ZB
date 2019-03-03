package org.hj.zb;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"org.hj.zb"})
@MapperScan("org.hj.zb.mapper")
public class ZbApplication {

    public static void main(String[] args) {
        SpringApplication.run(ZbApplication.class, args);
    }

}

