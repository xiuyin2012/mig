package com.clo.biz.impl;

import com.clo.biz.GameTransactionService;
import com.clo.util.DataInitial;
import com.clo.util.JedisPoolUtils;
import com.clo.util.TwoTuple;
import com.sun.deploy.panel.ITreeNode;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.Pipeline;
import redis.clients.jedis.Response;
import redis.clients.jedis.Tuple;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.*;

/**
 * Created by liut on 1/31/18.
 */
@Service("gameTransactionService")
public class GameTransactionServiceImp<T> implements GameTransactionService {
    public String initData(String provinceD,String hallD,String gameD){
        Jedis jedis = JedisPoolUtils.getJedis();
        Pipeline pipeline = jedis.pipelined();
        List<Map<String,String>> proListLocal = null;
        List<Map<String,String>> hallList = null;
        List<Map<String,String>> gameList = null;
        //check the swith to import
        String importSwitch =jedis.get("importAction");
        if(!("1").equals(importSwitch)){
            jedis.close();
            return "0";
        }
            try {
                //get Object that load the data of txt to redis
                DataInitial dataInitial = new DataInitial();
                //read 1 province data 2 hall data from txt
                proListLocal = dataInitial.getDataFromTXT(provinceD);
                hallList = dataInitial.getDataFromTXT(hallD);
                gameList = dataInitial.getDataFromTXT(gameD);
                //add to hash object of province and hall to redis
                for(Iterator<Map<String,String>> it = proListLocal.listIterator();it.hasNext();){
                    Map<String,String> proMap = it.next();
                    pipeline.hset(("pro"+proMap.get("proId")).getBytes("utf-8"),"id".getBytes(),("pro"+proMap.get("proId")).getBytes("utf-8"));
                    pipeline.hset(("pro"+proMap.get("proId")).getBytes(),"name".getBytes(), proMap.get("proNm").getBytes("utf-8"));

                    pipeline.lpush("proList".getBytes(),("pro"+proMap.get("proId")).getBytes("utf-8")); //push proList
                }
                pipeline.sync();
                for (Iterator<Map<String,String>> it = hallList.listIterator();it.hasNext();){
                    Map<String,String> hallMap = it.next();
                    pipeline.hset(hallMap.get("hallId"),"hallId", hallMap.get("hallId"));
                    pipeline.hset(hallMap.get("hallId"),"proId", "pro"+hallMap.get("proId"));
                    pipeline.hset(hallMap.get("hallId").getBytes(),"hallNm".getBytes(), hallMap.get("hallNm").getBytes("utf-8"));
                    pipeline.hset(hallMap.get("hallId").getBytes(),"proNm".getBytes(), hallMap.get("proNm").getBytes("utf-8"));

                    pipeline.lpush("hallList",hallMap.get("hallId"));    //push hallList
                }
                pipeline.sync();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
                return "2";
            }

        List<String> proList2 = jedis.lrange("proList",0,-1);
        List<String> hallList2 = jedis.lrange("hallList",0,-1);

        for(Iterator<String> it = proList2.listIterator();it.hasNext();){
            String pro = it.next();
            Set<String> pros = new HashSet<>();
            Map<String,String> proMap = jedis.hgetAll(pro);
            String hallRef = pro+"hallsSet";
            jedis.hset(pro,"halls",hallRef);
            for(Iterator<String> it2 = hallList2.listIterator();it2.hasNext();){
                String hall = it2.next();
                Map<String,String> hallMap = jedis.hgetAll(hall);
                if(pro.equals(hallMap.get("proId"))){
                    jedis.sadd(hallRef,hallMap.get("hallId"));
                }
            }
        }


/*        construct data
        24 	连环夺宝
        26 	趣味高尔夫
        25 	好运射击
        21 	三江风光
        11 	幸运五彩
        12 	开心一刻
        13 	四花选五*/
        try {
/*            String[] list1 = {"24","26","25","21","11","12","13"};
            String[] list2 = {"连环夺宝","趣味高尔夫","好运射击","三江风光","幸运五彩","开心一刻","四花选五"};*/
            for (ListIterator<Map<String,String>> it = gameList.listIterator();it.hasNext();){
                Map<String,String> gameMap = it.next();
                jedis.hset(("g"+gameMap.get("gameId")).getBytes(), "id".getBytes(),gameMap.get("gameId").getBytes("utf-8"));
                jedis.hset(("g"+gameMap.get("gameId")).getBytes(), "name".getBytes(),gameMap.get("gameNm").getBytes("utf-8"));

                pipeline.lpush("gmList","g"+gameMap.get("gameId"));
            }
/*            for (int i=0;i<7;i++) {
                jedis.hset(("g"+list1[i]).getBytes(), "id".getBytes(), list1[i].getBytes("utf-8"));
                jedis.hset(("g"+list1[i]).getBytes(),"name".getBytes(),list2[i].getBytes("utf-8"));
            }*/
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        jedis.close();
        return "1";

        //end initData
    }

    public double getFinalAmount(){
        double amount=0.0;
        Jedis jedis = JedisPoolUtils.getJedis();
        Set<Tuple> halls = jedis.zrangeWithScores("hall",0,-1);
        for(Iterator<Tuple> it = halls.iterator(); it.hasNext();){
            Tuple item = it.next();
            if (amount == 0.0) amount = item.getScore();
            else amount+=item.getScore();
        }
        jedis.close();
        return amount;
    }
    public List<Map<String,T>> getHallListByAmount(){
        Jedis jedis = JedisPoolUtils.getJedis();
        Pipeline pipeline = jedis.pipelined();
        List<Map<String,T>> rtnList = new ArrayList<>();
        Set<Tuple> halls = jedis.zrevrangeWithScores("hall",0,-1);
        for (Iterator<Tuple> it=halls.iterator();it.hasNext();){
            Tuple item = it.next();
            Map<String,T> itemMap = new HashMap<>();
            Response<String> hallNmResp= pipeline.hget(item.getElement(),"hallNm");
            itemMap.put("hallNm",(T)hallNmResp);
            DecimalFormat decimalFormat = new DecimalFormat("#,##0.00");//格式化设置
            itemMap.put("amount",(T)String.valueOf(decimalFormat.format(item.getScore())));
            rtnList.add(itemMap);
        }
        pipeline.sync();
        for (Map<String,T> itemRtnList:rtnList){
            Response<String> hallNmResp = (Response<String>) itemRtnList.get("hallNm");
            itemRtnList.put("hallNm",(T)hallNmResp.get());
        }
        jedis.close();
        return rtnList;
    }
    public List<Map<String,String>> getTotalBETbyScore(){
        Jedis jedis = JedisPoolUtils.getJedis();
        List<Map<String,String>> rtnList = new ArrayList<>();
        Set<Tuple> scoreSet = jedis.zrevrangeWithScores("score",0,-1);
        List<Map<String,String>> rtnArrayList = new ArrayList<>();
        for (Iterator<Tuple> it=scoreSet.iterator();it.hasNext();){
            Tuple item = it.next();
            Map<String,String> itemMap = new HashMap<>();
            itemMap.put(item.getElement(),String.valueOf(item.getScore()));
            Map<String,String> mapItem = new HashMap<>();
            mapItem.put("score",item.getElement());
            mapItem.put("amount",String.valueOf(item.getScore()));//{item.getElement(),String.valueOf(item.getScore())};
            rtnArrayList.add(mapItem);
            rtnArrayList.sort(new Comparator<Map<String, String>>() {
                @Override
                public int compare(Map<String, String> o1, Map<String, String> o2) {
                    int i=0;
                    int diff=Integer.parseInt(o1.get("score"))-Integer.parseInt(o2.get("score"));
                    if(diff!=0){
                        return i=(diff>0?1:-1);
                    }
                    return i;
                 }
            });
            //rtnList.add(itemMap);
        }
        jedis.close();
        return rtnArrayList;
    }
    public List<Map<String,String>> ratioByGameBET(){
        Jedis jedis = JedisPoolUtils.getJedis();
        Pipeline pipeline = jedis.pipelined();
        //"g"+id as game id of hashObject,gmList as game table
        List<String> gmList = jedis.lrange("gmList",0,-1);
        List<Response<Map<String,String>>> gmMapRespList = new ArrayList<>();
        for(String gm:gmList){
            Response<Map<String,String>> gmResp = pipeline.hgetAll(gm);
            gmMapRespList.add(gmResp);
        }
        pipeline.sync();
        List<TwoTuple<Map<String,String>,Response<String>>> gameMapAndAmount = new ArrayList<>();
        for(Response<Map<String,String>> respItem:gmMapRespList){
            String gameId = respItem.get().get("id");
            Response<String> amount = pipeline.get(gameId);
            gameMapAndAmount.add(new TwoTuple<>((Map<String,String>)respItem.get(),amount));

        }
        pipeline.sync();
        List<String> ratiosStr = new ArrayList<>();
        List<Map<String,String>> rtnList = new ArrayList<>();
        //double finalAmount=0.0;
        for(ListIterator<TwoTuple<Map<String,String>,Response<String>>> it = gameMapAndAmount.listIterator();it.hasNext();){
            TwoTuple<Map<String,String>,Response<String>> gameMapAndAmountItem = it.next();
            String rationsValue = "0";
            String rationsGet = gameMapAndAmountItem.second.get();
            Map<String,String> gameMap = gameMapAndAmountItem.first;

            ratiosStr.add(gameMapAndAmountItem.second.get());
            if(null!=rationsGet)rationsValue = rationsGet;
            gameMap.put("ratio",rationsValue);
            rtnList.add(gameMap);
        }
        //for(int j=0;j<rtnList.size();j++)rtnList.get(j).put("ratio",String.valueOf(Double.parseDouble(rtnList.get(j).get("ratio"))/finalAmount));



/*
        construct data
        24 	连环夺宝
        26 	趣味高尔夫
        25 	好运射击
        21 	三江风光
        11 	幸运五彩
        12 	开心一刻
        13 	四花选五
        try {
            String[] list1 = {"24","26","25","21","11","12","13"};
            String[] list2 = {"连环夺宝","趣味高尔夫","好运射击","三江风光","幸运五彩","开心一刻","四花选五"};
            for (int i=0;i<7;i++) {
                jedis.hset(("g"+list1[i]).getBytes(), "id".getBytes(), list1[i].getBytes("utf-8"));
                jedis.hset(("g"+list1[i]).getBytes(),"name".getBytes(),list2[i].getBytes("utf-8"));
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }*/


        jedis.close();
        return rtnList;
    }
    public List<Map<String, T>> amountByPro() {
        Jedis jedis = JedisPoolUtils.getJedis();
        Pipeline pipeline = jedis.pipelined();
        List respList = new ArrayList();
        //proList as province table,hallList as hall tabled,proId+hallsSet as halls set ref,proId+"interSet" as middn resultSet
        //new
        List<String> pros = jedis.lrange("proList", 0, -1);
        List<Response<Map<String, String>>> proMapRespList = new ArrayList<>();
        //Map<K,V> proRespMap = new HashMap<>();
        for (String proId : pros) {
            Response<Map<String, String>> proModel = pipeline.hgetAll(proId);
            proMapRespList.add(proModel);
        }
        pipeline.sync();  //get provinceInfo
        List<TwoTuple<Map<String, String>, Response<Set<Tuple>>>> interSetHallsRespList = new ArrayList<>();
        for (Response<Map<String, String>> proItem : proMapRespList) {
            String proId = proItem.get().get("id");
            String halls = proItem.get().get("halls");
            pipeline.zinterstore(proId + "interSet", proId + "hallsSet", "hall");
            Response<Set<Tuple>> interSethalls = pipeline.zrangeWithScores(proId + "interSet", 0, -1);
            interSetHallsRespList.add(new TwoTuple<>(proItem.get(), interSethalls));
        }
        pipeline.sync();
        List<Map<String, T>> resultList = new ArrayList<>();
        for (TwoTuple<Map<String, String>, Response<Set<Tuple>>> interhalls : interSetHallsRespList) {
            Map<String, T> proResult = (Map<String, T>) interhalls.first;
            Response<Set<Tuple>> interhallsResp = interhalls.second;
            double amount = 0.0;
            ;
            Iterable iterable;
            for (Iterator<Tuple> it = interhallsResp.get().iterator(); it.hasNext(); ) {
                if (amount == 0.0) amount = it.next().getScore()-1;
                else amount+=it.next().getScore()-1;
            }
            proResult.put("amount", (T) new Double(amount));
            resultList.add(proResult);
            sortByAmount(resultList);
        }
            //end done data

        //initData   order:1
/*        if(1==1){
            try {
                //get Object that load the data of txt to redis
                DataInitial dataInitial = new DataInitial();
                //read 1 province data 2 hall data from txt
                List<Map<String,String>> proList = dataInitial.getDataFromTXT("/application/province.txt");
                List<Map<String,String>> hallList = dataInitial.getDataFromTXT("/application/hall.txt");
                //add to hash object of province and hall to redis
                for (Map<String,String> proMap:proList){
                    jedis.hset(proMap.get("proId"),"id", proMap.get("proId"));
                    jedis.hset(proMap.get("proId").getBytes(),"name".getBytes(), proMap.get("proNm").getBytes("utf-8"));

                    jedis.lpush("proList",proMap.get("proId"); //push proList
                }
                for (Map<String,String> hallMap:hallList){
                    jedis.hset(hallMap.get("hallId"),"hallId", hallMap.get("hallId"));
                    jedis.hset(hallMap.get("hallId"),"proId", hallMap.get("proId"));
                    jedis.hset(hallMap.get("hallId").getBytes(),"hallNm".getBytes(), hallMap.get("hallNm").getBytes("utf-8"));
                    jedis.hset(hallMap.get("hallId").getBytes(),"proNm".getBytes(), hallMap.get("proNm").getBytes("utf-8"));

                    jedis.lpush("hallList",hallMap.get("hallId");    //push hallList
                }
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            return new ArrayList<>();
        }*/
/*        List<String> proList = jedis.lrange("proList",0,-1);
        List<String> hallList = jedis.lrange("hallList",0,-1);
        for(String pro:proList){
            Set<String> pros = new HashSet<>();
            Map<String,String> proMap = jedis.hgetAll(pro);
            String hallRef = pro+"hallsSet";
            jedis.hset(pro,"halls",hallRef);
            for(String hall:hallList){
                Map<String,String> hallMap = jedis.hgetAll(hall);
                if(pro.equals(hallMap.get("proId"))){
                    jedis.sadd(hallRef,hallMap.get("hallId"));
                }
            }
        }*/
    //end initData
            pipeline.sync();
            jedis.close();
            return resultList;
            //new String(str.getBytes("gbk"),"utf-8")
    }
    private void sortByAmount(List comparatorList){
        Collections.sort(comparatorList, new Comparator<Map<String,T>>() {

            @Override
            public int compare(Map<String,T> o1, Map<String,T> o2) {
                int i = 0;
                double diff = ((Double) o1.get("amount")).doubleValue() - ((Double) o2.get("amount")).doubleValue();
                if (diff != 0.0) {
                    return i=(diff > 0.0 ? -1 : 1);
                }
                return i;
            }
        });
    }
}
