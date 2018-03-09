package com.clo.domain;

/**
 * Created by root on 1/31/18.
 */
public class Province {
    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    public void setProvinceNm(String provinceNm) {
        this.provinceNm = provinceNm;
    }

    public String getProvinceNm() {
        return provinceNm;
    }

    private int provinceId;
    private String provinceNm;
}
