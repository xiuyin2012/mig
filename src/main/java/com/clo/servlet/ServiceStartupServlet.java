package com.clo.servlet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.clo.cache.Ehcache;
import com.clo.util.JedisUtil;

@SuppressWarnings("serial")
public class ServiceStartupServlet extends HttpServlet {

	public ServiceStartupServlet() {
		super();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Servlet#init(javax.servlet.ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		@SuppressWarnings("unused")
		WebApplicationContext wac = WebApplicationContextUtils
				.getWebApplicationContext(this.getServletContext());
		// Client.class.getClassLoader().loadClass("mytry.Client");
		// JedisUtil.class.getClassLoader()

		// ¶¨ÒåserverTypeÈÝÆ÷ 1:appserver,2:dbserver
		/*
		 * List<Object> appServers = new ArrayList<Object>(); List<Object>
		 * dbServers = new ArrayList<Object>(); List<Object> drServers = new
		 * ArrayList<Object>(); List<Object> dwServers = new
		 * ArrayList<Object>(); List<Object> webServers = new
		 * ArrayList<Object>();
		 * 
		 * 
		 * Ehcache.createCache("cmKpiEwCache"); WebApplicationContext context =
		 * WebApplicationContextUtils
		 * .getRequiredWebApplicationContext(this.getServletContext());
		 * CmKpiEwInfService cmKpiEwService = (CmKpiEwInfService)
		 * context.getBean("cmKpiEwService"); Paging page = new Paging();
		 * 
		 * List<CmKpiEw> cmKpiEws = cmKpiEwService.findCmKpiEwByServer(page);
		 * 
		 * 
		 * for(CmKpiEw cmKpiEw : cmKpiEws){ //String key =
		 * cmKpiEw.getServerTypeId
		 * ()+":"+cmKpiEw.getKpiSeq()+":"+cmKpiEw.getMeasId();
		 * if("1".equals(cmKpiEw.getServerTypeId())){ appServers.add(cmKpiEw); }
		 * if("2".equals(cmKpiEw.getServerTypeId())){ dbServers.add(cmKpiEw); }
		 * if("3".equals(cmKpiEw.getServerTypeId())){ drServers.add(cmKpiEw); }
		 * if("4".equals(cmKpiEw.getServerTypeId())){ dwServers.add(cmKpiEw); }
		 * if("5".equals(cmKpiEw.getServerTypeId())){ webServers.add(cmKpiEw); }
		 * }
		 * 
		 * Ehcache.addehCache("cmKpiEwCache", "1", appServers);
		 * Ehcache.addehCache("cmKpiEwCache", "2", dbServers);
		 * Ehcache.addehCache("cmKpiEwCache", "3", drServers);
		 * Ehcache.addehCache("cmKpiEwCache", "4", dwServers);
		 * Ehcache.addehCache("cmKpiEwCache", "5", webServers);
		 */

	}

	public void destroy() {
		super.destroy();
		/* JedisUtil.destroy(); */
		try {
			// Ehcache.destoryAllCache();
			// WorkflowDefinitionCache.clearCache();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
