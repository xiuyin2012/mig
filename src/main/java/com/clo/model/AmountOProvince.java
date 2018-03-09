package com.clo.model;

/**
 * Created by root on 1/31/18.
 */
public class AmountOProvince {
    private int provinceId;
    private int provinceNm;

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    public void setProvinceNm(int provinceNm) {
        this.provinceNm = provinceNm;
    }

    public void setGameAmount(double gameAmount) {
        this.gameAmount = gameAmount;
    }

    private double gameAmount;

    public int getProvinceId() {
        return provinceId;
    }

    public int getProvinceNm() {
        return provinceNm;
    }

    public double getGameAmount() {
        return gameAmount;
    }
}
