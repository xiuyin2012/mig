package com.clo.domain;

/**
 * Created by root on 1/31/18.
 */
public class GameTransaction {
    private int tranId;
    private int provinceId;
    private int hallId;

    public void setTranId(int tranId) {
        this.tranId = tranId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    public void setHallId(int hallId) {
        this.hallId = hallId;
    }

    public void setGameAmount(double gameAmount) {
        this.gameAmount = gameAmount;
    }

    public void setGameCount(int gameCount) {
        this.gameCount = gameCount;
    }

    private double gameAmount;

    public int getTranId() {
        return tranId;
    }

    public int getProvinceId() {
        return provinceId;
    }

    public int getHallId() {
        return hallId;
    }

    public double getGameAmount() {
        return gameAmount;
    }

    public int getGameCount() {
        return gameCount;
    }

    private int gameCount;


}
