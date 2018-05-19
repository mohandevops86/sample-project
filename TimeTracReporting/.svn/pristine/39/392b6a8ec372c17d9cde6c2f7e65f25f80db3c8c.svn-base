package com.ssss.ttr.util;

import java.util.Properties;

import javax.servlet.ServletContext;
import javax.ws.rs.core.Context;

import com.ssss.ttr.bean.ErrorEmailHeaderBean;
import com.ssss.ttr.common.ApplicationConstants;

public class CommonUtilities {
	@Context
	ServletContext context;
	
	public ErrorEmailHeaderBean getEmailInfoFromProperties(Properties props){
		
		ErrorEmailHeaderBean bean = new ErrorEmailHeaderBean();
    	bean.setEnvLoc((String) props.get(ApplicationConstants.ENV_LOC));
		bean.setErrorFromEmail((String) props.get(ApplicationConstants.ERROR_FROM_EMAIL));
    	bean.setErrorToEmail((String) props.get(ApplicationConstants.ERROR_TO_EMAIL));        	
    	bean.setErrorSubject((String) props.get(ApplicationConstants.ERROR_SUBJECT) + " (" + bean.getEnvLoc() + ")");        	
    	bean.setErrorSmtpHost((String) props.get(ApplicationConstants.ERROR_SMTP_HOST));
		return bean;
	}

}
