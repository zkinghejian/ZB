package org.hj.zb.pojo;

import lombok.Data;

import java.util.List;

@Data
public class Type {
    private int typeno;
    private String typename;
    private List<Types> types;
}
