package com.clo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clo.biz.AnalysisInfService;

@Controller
@RequestMapping(value = "/analysis")
public class AnalysisController {
	public static String ANALYSISTENDER = "WEB-INF/clo/compManage/AnalysisTender";
	@Autowired
	@Qualifier("analysisInfService")
	private AnalysisInfService analysisService;

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

}
