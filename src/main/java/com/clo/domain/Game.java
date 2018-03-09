package com.clo.domain;

/**
 * Created by root on 1/31/18.
 */
public class Game {
    private int gameId;

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public void setGameNm(int gameNm) {
        this.gameNm = gameNm;
    }

    public int getGameId() {
        return gameId;
    }

    public int getGameNm() {
        return gameNm;
    }

    private int gameNm;

}
