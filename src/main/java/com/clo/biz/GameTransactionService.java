package com.clo.biz;

import com.clo.model.AmountOProvince;

import javax.persistence.Tuple;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by liut on 1/31/18.
 */
public interface GameTransactionService<T> {
    public String  initData(String provinceD,String hallD,String gameD);
    public List<Map<String, T>> amountByPro();
    public List<Map<String,String>> ratioByGameBET();
    public List<Map<String,String>> getTotalBETbyScore();
    public List<Map<String,String>> getHallListByAmount();
    public double getFinalAmount();
}
