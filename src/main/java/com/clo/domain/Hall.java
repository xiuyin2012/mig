package com.clo.domain;

/**
 * Created by root on 1/31/18.
 */
public class Hall {
    private int id;
    private String hallNm;

    public void setId(int id) {
        this.id = id;
    }

    public void setHallNm(String hallNm) {
        this.hallNm = hallNm;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    public String getHallNm() {
        return hallNm;
    }

    public int getProvinceId() {
        return provinceId;
    }

    public int getId() {
        return id;
    }

    private int provinceId;
}
