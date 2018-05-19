package com.ssss.jde.security.webservices.proxy.client;

import java.rmi.RemoteException;
import java.util.Properties;

import javax.servlet.ServletContext;

import org.apache.axis2.AxisFault;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.ssss.jde.security.webservices.proxy.client.JDESecurityWSStub;
import com.ssss.ttr.common.ApplicationConstants;


public class SSJDESecurityWSClient {
	
	private static Logger logger = LogManager.getLogger("com.ssss.ttr.action.LoginController->SSJDESecurityWSClient.class");
	
	public static int ValidateUser(String userId, String userPass, String programId, String ComputerId, ServletContext servletCtx) throws Exception{
		
		logger.info("In SSJDESecurityWSClient->ValidateUser userId => " + userId + ", programId => " + programId  + ", ComputerId => " + ComputerId + ")");
		
		int authResult = 0;
		
		JDESecurityWSStub stub;
		logger.info("SSJDESecurityWSClient->ValidateUser getting ApplicationProperties");
				
		Properties props = (Properties) servletCtx.getAttribute("ApplicationProperties");

		String instLoc = (String) props.get(ApplicationConstants.INST_LOC);
		
		String bssvAuthProxyWebServiceURL = (String) props.get(ApplicationConstants.SSJDESECURITYWS_URL);

		/*if (instLoc.equals("DMZ") && bssvAuthProxyWebServiceURL.startsWith("//"))
			bssvAuthProxyWebServiceURL = "https:" + bssvAuthProxyWebServiceURL;
		else*/ if (instLoc.equals("NETWORK") && bssvAuthProxyWebServiceURL.startsWith("//"))
			bssvAuthProxyWebServiceURL = "http:" + bssvAuthProxyWebServiceURL;
		
		//String bssvAuthProxyWebServiceURL = "http://localhost:8080/SSJDESecurityWS/services/JDESecurityWS.JDESecurityWSHttpSoap11Endpoint";
		
		logger.info("SSJDESecurityWSClient->ValidateUser bssvAuthProxyWebServiceURL " + bssvAuthProxyWebServiceURL);
		
		logger.info("Preparing auth web service stub");
		
		stub = new JDESecurityWSStub(bssvAuthProxyWebServiceURL); 
		JDESecurityWSStub.ValidateUser vUserIn = new JDESecurityWSStub.ValidateUser();
		
		vUserIn.setUserId(userId);
		vUserIn.setUserPass(userPass);
		
		logger.info("validate user via auth web service");
		
		authResult = stub.validateUser(vUserIn).get_return();

		logger.info("validate user result " + authResult);

		return authResult;
	}

}
