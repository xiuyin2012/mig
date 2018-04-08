package com.clo.util;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liut on 2/4/18.
 */
public class DataInitial<T> {
    public  List<T> getDataFromTXT(String pathNm){
        File file=new File(pathNm);
        FileReader fileReader = null;
        BufferedReader bufferedReader = null;
        String temp = null;
        String [] tempArray = null;
        List<T> rtnList = new ArrayList<>();
        try {
            fileReader = new FileReader(file);
            bufferedReader = new BufferedReader(fileReader);
            int length;
            //byte[] bytes = new byte[1024];
            //put data to bytes
            while((temp=bufferedReader.readLine())!=null){
                tempArray = temp.split("\\s+");
                String fileName = file.getName();
                String simpleFileNm = fileName.substring(fileName.indexOf("/",-1)+1,fileName.indexOf("."));
                if ("province".equals(simpleFileNm)){
                    getProinceData(tempArray,rtnList);
                }
                if(("hall").equals(simpleFileNm)){
                    getHallData(tempArray,rtnList);
                }
                if(("game").equals(simpleFileNm)){
                    getGameData(tempArray,rtnList);
                }
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            try {
                fileReader.close();
                bufferedReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return rtnList;
    }
    private void getProinceData(String[] tempArray,List<T> rtnList){
        //Map<String,Map<String,String>> proKeyMap = new HashMap<>();
        Map<String,String> proModelMap = new HashMap<>();
        proModelMap.put("proId",tempArray[0]);
        proModelMap.put("proNm",tempArray[1]);
        //proKeyMap.put(tempArray[0],proModelMap);
        rtnList.add((T) proModelMap);
    }
    private void getHallData(String[] tempArray,List<T> rtnList){
        //Map<String,Map<String,String>> hallKeyMap = new HashMap<>();
        Map<String,String> hallModelMap = new HashMap<>();
        hallModelMap.put("proId",tempArray[0]);
        hallModelMap.put("proNm",tempArray[1]);
        hallModelMap.put("hallId",tempArray[2]);
        hallModelMap.put("hallNm",tempArray[3]);
        //hallKeyMap.put(tempArray[0],hallModelMap);
        rtnList.add((T) hallModelMap);
    }
    private void  getGameData(String[] tempArray,List<T> rtnList){
        Map<String,String> gameModelMap = new HashMap<>();
        gameModelMap.put("gameId",tempArray[0]);
        gameModelMap.put("gameNm",tempArray[1]);
        rtnList.add((T) gameModelMap);
    }
}
