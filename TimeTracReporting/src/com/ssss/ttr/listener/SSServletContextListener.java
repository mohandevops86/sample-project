package com.ssss.ttr.listener;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.ssss.ttr.common.ApplicationConstants;

public class SSServletContextListener 
               implements ServletContextListener{
	private static final Logger logger = LogManager.getLogger("com.ssss.ttr.listener.SSServletContextListener");
	private static ServletContext context;
	public void contextDestroyed(ServletContextEvent ctxEvent) {
		
		logger.info("ServletContextListener destroyed.");
		
	}
 
        //Run this before web application is started	
	public void contextInitialized(ServletContextEvent ctxEvent) {
		
		logger.info("ServletContextListener context initialized");		
		
		ServletContext ctx = ctxEvent.getServletContext();
		
		logger.info("ServletContextListener loading config file");
		
		loadConfig(ctx);
				
	}
	
	private void loadConfig(ServletContext ctx){		
		
		String configFile = ctx.getInitParameter("configFile");
		
		logger.info("Reading config file: " + configFile);
		
		try{
			
			InputStream is = ctx.getResourceAsStream(configFile);  
			Properties props = new Properties();
			
			props.load(is);
			
			ctx.setAttribute("ApplicationProperties", props);
			ctx.setAttribute("loginAutocompleteUrl", props.getProperty(ApplicationConstants.SS_JDE_USERS_WS_URL));	
			ctx.setAttribute("impersonateAutocompleteUrl", props.getProperty(ApplicationConstants.SS_JDE_IMPERSONATE_USERS_WS_URL));
			ctx.setAttribute("it_help_desk_email", props.getProperty(ApplicationConstants.IT_HELP_DESK_EMAIL));
			
			
		} catch (IOException e) {
			
			logger.error("loadConfig ERROR => ", e);
			
		}  						
		
		logger.info("Config File Load succeeded.");
	}
	public ServletContext getAppnServletContext(){
		return this.context;
	}
}