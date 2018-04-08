package com.clo.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clo.biz.GameTransactionService;
import com.clo.util.JedisPoolUtils;
import com.clo.util.JedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clo.biz.AnalysisInfService;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.Tuple;

@Controller
@RequestMapping(value = "/analysis")
public class AnalysisController {
	public static String ANALYSISTENDER = "WEB-INF/clo/compManage/AnalysisTender";
	public static String INITPAGE="WEB-INF/clo/monitor/hallSpector";
	public static String INITDATA="WEB-INF/clo/monitor/initData";
	@Autowired
	@Qualifier("analysisInfService")
	private AnalysisInfService analysisService;

	public void setGameTransactionService(GameTransactionService gameTransactionService) {
		this.gameTransactionService = gameTransactionService;
	}

	public GameTransactionService getGameTransactionService() {
		return gameTransactionService;
	}

	@Autowired
	@Qualifier("gameTransactionService")
	private GameTransactionService gameTransactionService;

	public AnalysisInfService getAnalysisInfService() {
		return analysisService;
	}

	public void setAnalysisInfService(AnalysisInfService analysisInfService) {
		this.analysisService = analysisInfService;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getRechargeCount.do")
	public Map<String, Object> getRechargeCount(HttpServletRequest request,
			HttpServletResponse response, int interValTime) {
		return analysisService.getRechargeCount(interValTime);
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getAnalysisTender.do")
	public String getAnalysisTender(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println(ANALYSISTENDER);
		return ANALYSISTENDER;
	}

	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/geTransByPro.do")
	@ResponseBody
	public List<Map<String,String>> getLofts(HttpServletRequest request,
									HttpServletResponse response) {
		List<Map<String,String>> trans = gameTransactionService.amountByPro();
		return trans;
	}
	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/ratioByGameBET.do")
	@ResponseBody
	public List<Map<String,String>> ratioByGameBET(HttpServletRequest request,
												   HttpServletResponse response){
		return gameTransactionService.ratioByGameBET();
	}
	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getTotalBETbyScore.do")
	@ResponseBody
	public List<Map<String,String>> getTotalBETbyScore(HttpServletRequest request,
										 HttpServletResponse response){
		return gameTransactionService.getTotalBETbyScore();
	}
	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getHallListByAmount.do")
	@ResponseBody
	public List<Map<String,String>> getHallListByAmount(HttpServletRequest request,
										 HttpServletResponse response){
		return gameTransactionService.getHallListByAmount();
	}
	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getFinalAmount.do")
	@ResponseBody
	public double getFinalAmount(HttpServletRequest request,
										  HttpServletResponse response){
		return gameTransactionService.getFinalAmount();
	}
	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/initPage.do")
	public String forwardToInitPage(HttpServletRequest request,
								 HttpServletResponse response){
		return INITPAGE;
	}

	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/initData.do")
	@ResponseBody
	public String initData(HttpServletRequest request,
									HttpServletResponse response,String provinceD,String hallD,String gameD){
/*		String provinceD = String.valueOf(request.getSession().getAttribute("provinceD"));
		String hallD = String.valueOf(request.getSession().getAttribute("hallD"));
		String gameD = String.valueOf(request.getSession().getAttribute("gameD"));*/
		return gameTransactionService.initData(provinceD,hallD,gameD);
	}
	/**
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/inition.do")
	public String inition(HttpServletRequest request,
						HttpServletResponse response){
		return INITDATA;
	}

}
