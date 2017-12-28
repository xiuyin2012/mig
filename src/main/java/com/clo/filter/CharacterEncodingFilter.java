package com.clo.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class CharacterEncodingFilter implements javax.servlet.Filter {
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Map<String, String> paras = new HashMap<String, String>();
		@SuppressWarnings("rawtypes")
		Enumeration names = httpRequest.getParameterNames();
		while (names.hasMoreElements()) {
			String key = (String) names.nextElement();
			paras.put(key,
					new String(request.getParameter(key).getBytes("iso8859-1"),
							"utf-8"));
		}
		chain.doFilter(new ConvertedRequest(httpRequest, paras), response);
	}

	public void init(FilterConfig config) throws ServletException {
	}

	public void destroy() {
	}

	private class ConvertedRequest extends HttpServletRequestWrapper {
		private Map<String, String> paras;

		public ConvertedRequest(HttpServletRequest request,
				Map<String, String> paras) {
			super(request);
			this.paras = paras;
		}

		@Override
		public String getParameter(String key) {
			return this.paras.get(key);
		}
	}
}
