package com.clo.biz.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.clo.biz.AnalysisInfService;

@Service("analysisInfService")
public class AnalysisServiceImpl implements AnalysisInfService {
	public Map<String, Object> getRechargeCount(int interValTime) {
		Map<String, Object> map = new HashMap<String, Object>();

		/*
		 * //�˴���ʱ��������ݣ���Ҫ��÷���jedis���ص����� String redisKey = "key";
		 * 
		 * //�˴�����web��spark��ͳһ����Ϣ���� Message msg = null; byte[] rtnObjBytes =
		 * JedisUtil.rpop(redisKey.getBytes()); try { msg =
		 * (Message)ObjectUtil.bytesToObject(rtnObjBytes); } catch (Exception e)
		 * { // TODO Auto-generated catch block e.printStackTrace(); }
		 * if(msg!=null){ // TODO
		 * System.out.println(msg.getId()+"   "+msg.getContent()); }
		 */
		Date date = new Date();
		double count = 0;
		map.put("time", date.getTime() + 8 * 60 * 60 * 1000);
		if (6 > date.getHours() || 8 < date.getHours()) {
			count = Math.floor(10000000 * Math.random());
		}
		map.put("count", count);
		return map;
	}
}
