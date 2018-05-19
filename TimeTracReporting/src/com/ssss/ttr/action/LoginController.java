package com.ssss.ttr.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.opensymphony.xwork2.ActionSupport;
import com.ssss.jde.security.webservices.proxy.client.SSJDESecurityWSClient;
import com.ssss.ttr.common.ApplicationConstants;


public class LoginController extends ActionSupport{
	
	private static Logger logger = LogManager
			.getLogger("com.ssss.ttr.action.LoginController");
	private static final long serialVersionUID = 1L;
	private static final String LOGIN = "login";
	

	public String login() throws Exception {
		
		logger.info("Entered LoginController: In login()");
		
		HttpServletRequest request = ServletActionContext.getRequest();
		ServletContext ctx = request.getServletContext();
		HttpSession session = request.getSession(true);
		String lJdeUserId = "";
		String lFullName = "";
		String labn8 = "";
	
		try{
			
			logger.info("login => getting ApplicationProperties");
			Properties props = (Properties) ctx.getAttribute("ApplicationProperties");
			String instLoc = (String) props.get(ApplicationConstants.INST_LOC);
			logger.info("login => instance location " + instLoc);
			String jdeUserIdStr = request.getParameter("abn");
			String jdePass = request.getParameter("password");

			if (session.getAttribute("jdeUserId") != null && !session.getAttribute("jdeUserId").equals(""))
				return SUCCESS;			
			
		/*	if ((session.getAttribute("jdeUserId") != null && instLoc.equals("NETWORK"))
				|| (jdeUserIdStr == null && instLoc.equals("NETWORK")))
				return NET_LOGIN;*/
			logger.info("login => userid ABN:" + jdeUserIdStr);
				
			logger.info("User validation");
				
			
			if (null == lJdeUserId || lJdeUserId.equals(""))
				lJdeUserId = jdeUserIdStr;
			
			int validUserPass = SSJDESecurityWSClient.ValidateUser(jdeUserIdStr, jdePass, null,  null, ctx);	
			//int validUserPass = connectToJDEAuthenticate(jdeUserIdStr, jdePass, props);
			logger.info("User validation validUserPass " + validUserPass);
			if (validUserPass != 1){
				request.setAttribute("invalidLogin", true);
				return LOGIN;
			}
			
			
			lFullName = "";
			StringBuilder sbUserLoginRecord = new StringBuilder("");
			StringTokenizer st = null; 			
			boolean doesUserExistInJde = isValidUser(request, lFullName, lJdeUserId, sbUserLoginRecord, instLoc);
				
			st = new StringTokenizer(sbUserLoginRecord.toString(), "|");
				
				labn8 = "";
				if (st.hasMoreElements())
					lFullName = (String) st.nextElement();
				
				if (st.hasMoreElements())
					labn8 = (String) st.nextElement();
				
				if (st.hasMoreElements())
					lJdeUserId = (String) st.nextElement();

				if (lFullName.equals(""))
					lFullName = lJdeUserId;
			session.setAttribute("abn8", labn8);
			session.setAttribute("fullName", lFullName);
			logger.info("abn8:"+labn8);
			logger.info("lFullName:"+lFullName);
			sbUserLoginRecord = null;
			logger.info("login => success ");
			
			//------------------------------------------------------------------------------------------
			/*// check and update the impersonate list
			 call the impersonate all restful service .
			 loop through the json array and check if logged in user is there
			 if(logged in user is not in the list)
				 call restricted impersonate webservice Call
				 and 
			
			
			*/
			
			
			//------------------------------------------------------------------------------------------
			
		} catch (Exception e){
			
			logger.error("login => error ", e);
			return ERROR;
			
		}
		
		return SUCCESS;
	}

	public int connectToJDEAuthenticate(String jdeUserIdStr, String jdePass, Properties props) {
		int authResult = 0;
		String authenticateUrl = (String) props.get(ApplicationConstants.SSJDESECURITYWS_URL);	
		
		String httpUrl = "http:" + authenticateUrl + "?userId="+jdeUserIdStr+"&userPass="+jdePass;
		HttpClient client = null;
		BufferedReader rd = null;

		try {
			
			client = new DefaultHttpClient();
			HttpGet httpGet = new HttpGet(httpUrl);
			httpGet.addHeader("accept", "application/json");
			HttpResponse httpResponse = client.execute(httpGet);
			int respCode = httpResponse.getStatusLine().getStatusCode();
			
			if (respCode != 200){
				throw new Exception("Server Error HttpClient user validation error: " + respCode);
			}
			
			rd = new BufferedReader(new InputStreamReader(httpResponse
					.getEntity().getContent()));

			StringBuffer result = new StringBuffer();
			String line = "";

			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			if (null != result) {
				
				logger.info("Webservice authResult:" + result);
				authResult = Integer.parseInt(result.toString());
			}
				
		} catch (ClientProtocolException e) {
			logger.error("isValidUser ClientProtocolException ERROR => ", e);
		} catch (IOException e) {
			logger.error("isValidUser IOException ERROR => ", e);
	
		}catch (Exception e) {
			logger.error("isValidUser Exception ERROR => ", e);
	
		}  finally {
			if (null != rd)
				rd = null;
			if (null != client)
				try {
					client.getConnectionManager().shutdown();
				} catch (Exception e) {
					// just log trace no need to print or catch anywhere else
					logger.error("isValidUser Finally Exception ERROR => ", e);
					
				}
		}
		
		logger.info("AuthenticateResult:" + authResult);
		return authResult;
	}

	public String logout() throws Exception {
		
		logger.info("In logout");
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession(true);
		session.removeAttribute("abn8");
		session.removeAttribute("fullname");	
		if(null!=session.getAttribute("impersonatedAbn"))
			session.removeAttribute("impersonatedAbn");
		if(null!=session.getAttribute("impersonatedFullName"))
			session.removeAttribute("impersonatedFullName");
		//session.removeAttribute("impersonatedFullName");
		logger.info("In logout:Removed variables from session.");
		return SUCCESS;
	}

	private static boolean isValidUser(HttpServletRequest request,
			String requestLoginValue, String requestUserId, StringBuilder sbUserLoginRecord, String instLoc) throws Exception {
		boolean isUserValid = false;
		
		logger.info("In isValidUser  requestLoginValue: " + requestLoginValue + " , requestUserId: " + requestUserId );
		
		ServletContext ctx = request.getServletContext();

		Properties props = (Properties) ctx.getAttribute("ApplicationProperties");	
		
		String loginAutocompleteUrl = (String) props.get(ApplicationConstants.SS_JDE_USERS_WS_URL);	
		
		loginAutocompleteUrl = urlProtocolInternalOrExternal(instLoc, loginAutocompleteUrl);
		
		String httpUrl = loginAutocompleteUrl += "?user=";;

		HttpClient client = null;

		BufferedReader rd = null;

		try {
			
			if (null != requestLoginValue && !requestLoginValue.equals("")) {
				//following is needed otherwise HttpGet throws exception
				httpUrl += (requestLoginValue.replace(",", "%2C")).replace(" ", "%20");
			}
			
			if (null != requestUserId && !requestUserId.equals("")){

					httpUrl += "&userid=".concat(requestUserId);
			}
			httpUrl += "&contextAppName=Login";

			logger.info("isValidUser httpURL: "	+ httpUrl);
			
			client = new DefaultHttpClient();
			HttpGet httpGet = new HttpGet(httpUrl);
			httpGet.addHeader("accept", "application/json");
			HttpResponse httpResponse = client.execute(httpGet);
			int respCode = httpResponse.getStatusLine().getStatusCode();
			
			if (respCode != 200){
				throw new Exception("Server Error HttpClient user validation error: " + respCode);
			}
			
			rd = new BufferedReader(new InputStreamReader(httpResponse
					.getEntity().getContent()));

			StringBuffer result = new StringBuffer();
			String line = "";

			while ((line = rd.readLine()) != null) {
				result.append(line);
			}

			// System.out.println(result.toString());

			if (null != result) {
				JSONParser parser = new JSONParser();
				try {
					Object obj = parser.parse(result.toString());
					//System.out.println(obj.toString());
					
					HashMap jsonHashMap = (HashMap) obj;
					//System.out.println("json data: " + jsonHashMap.toString());
					//System.out.println("totalRecords:");
					//System.out.println(jsonHashMap.get("totalRecords"));
					
					logger.info("In isValidUser totalRecords " + jsonHashMap.get("totalRecords"));
					
					String totalRecordStr = jsonHashMap.get("totalRecords").toString();
					
					if (null != totalRecordStr && Integer.parseInt(totalRecordStr) == 1){

						JSONArray userRecJA = null;
						JSONObject userRecValue = null;
						String userRecStr = "";
						
						if (null != jsonHashMap && null != jsonHashMap.get("jdeUserLoginDDDTOList"))
							userRecJA = (JSONArray) jsonHashMap.get("jdeUserLoginDDDTOList");
						
						if (null != userRecJA && null != userRecJA.get(0))
							userRecValue = (JSONObject) userRecJA.get(0);
						
						if (null != userRecValue && null != userRecValue.get("value")) 
							userRecStr = (String) userRecValue.get("value");
						
						sbUserLoginRecord.append(userRecStr);
					
						logger.info("In isValidUser userRecStr " + userRecStr);
					}
					
					
					if (null != totalRecordStr
							&& Integer.parseInt(totalRecordStr) == 1)
						isUserValid = true;

				} catch (ParseException pe) {
					logger.error("isValidUser ParseException ERROR => ", pe);
					pe.printStackTrace();
				}
			}

		} catch (ClientProtocolException e) {
			
			logger.error("isValidUser ClientProtocolException ERROR => ", e);
			throw e;
			
		} catch (IOException e) {
			
			logger.error("isValidUser IOException ERROR => ", e);
			throw e;

		} finally {
			if (null != rd)
				rd = null;
			if (null != client)
				try {
					client.getConnectionManager().shutdown();
				} catch (Exception e) {
					// just log trace no need to print or catch anywhere else
					logger.error("isValidUser Finally Exception ERROR => ", e);
					
				}
		}
		
		logger.info("isValidUser: " + isUserValid);
		
		return isUserValid;
	}

	private static String urlProtocolInternalOrExternal(String instLoc,
			String url) {
		if (instLoc.equals("DMZ") && url.startsWith("//"))
			url = "https:" + url;
		else if (instLoc.equals("NETWORK") && url.startsWith("//"))
			url = "http:" + url;
		return url;
	}

}
