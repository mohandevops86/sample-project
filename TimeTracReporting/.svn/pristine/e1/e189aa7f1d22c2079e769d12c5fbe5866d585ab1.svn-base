package com.ssss.ttr.action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.Context;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.ssss.ttr.bean.BeanPacker;
import com.ssss.ttr.bean.Employee;
import com.ssss.ttr.bean.ErrorEmailHeaderBean;
import com.ssss.ttr.bean.MergedData;
import com.ssss.ttr.bean.Technician;
import com.ssss.ttr.common.ApplicationConstants;
//import com.ssss.ttr.dao.TimeDataDao;
import com.ssss.ttr.util.CommonUtilities;
import com.ssss.ttr.util.Email;

public class TimeDataController extends ActionSupport {
	
	@Context
	ServletContext context;
	
	private static Logger logger = LogManager
			.getLogger("com.ssss.ttr.action.TimeDataController");
	
	
	private static final long serialVersionUID = 1L;
	public String totalHrsDecimals = null;
	public String totalHHMM = null;
	public String totalRDHHHMM = null;
	public String abn = null;
	public String startDate = null;
	public String endDate = null;
	public String displayName = null;
	public String impersonate = null;
	public String autotype = null;
	
	public List<MergedData> mergedList = null;

	public String getTotalHrsDecimals() {
		return totalHrsDecimals;
	}

	public void setTotalHrsDecimals(String totalHrsDecimals) {
		this.totalHrsDecimals = totalHrsDecimals;
	}

	public String getTotalHHMM() {
		return totalHHMM;
	}

	public void setTotalHHMM(String totalHHMM) {
		this.totalHHMM = totalHHMM;
	}
	
	public String getTotalRDHHHMM() {
		return totalRDHHHMM;
	}
	
	public void setTotalRDHHHMM(String totalRDHHHMM) {
		this.totalRDHHHMM = totalRDHHHMM;
	}
	
	public String getAbn() {
		return abn;
	}

	public void setAbn(String abn) {
		this.abn = abn;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getImpersonate() {
		return impersonate;
	}

	public void setImpersonate(String impersonate) {
		this.impersonate = impersonate;
	}

	public String getAutotype() {
		return autotype;
	}

	public void setAutotype(String autotype) {
		this.autotype = autotype;
	}

	public List<MergedData> getMergedList() {

		return mergedList;
	}

	public void setMergedList(List<MergedData> mergedList) {
		this.mergedList = mergedList;
	}

	public String getReport() {
		logger.info("-------------------------*********START OF REPORT CYCLE*****************------------------------");
		logger.info("Entered TimeDataController: In getReport()");
		HttpServletRequest request = ServletActionContext.getRequest();
		ServletContext ctx = request.getServletContext();
		
		Properties props = (Properties) ctx.getAttribute("ApplicationProperties");
		CommonUtilities myUtil = new CommonUtilities();
		ErrorEmailHeaderBean bean = myUtil.getEmailInfoFromProperties(props);
		
		List<Employee> employeeData = new ArrayList<Employee>();
		List<Technician> techData = new ArrayList<Technician>();
		try {
			/****** WITHOUT LOGIN FUNCTIONALITY *****/
			 /*logger.info("ABN:" + request.getParameter("abn"));
			this.setAbn(request.getParameter("abn"));*/
			/****** WITHOUT LOGIN FUNCTIONALITY *****/
			
			/****** WITH LOGIN FUNCTIONALITY *****/
			HttpSession session = request.getSession();
			logger.info("ABN from request:"+this.getAbn());
			this.setAbn(this.getAbn());
			//logger.info("ABN:"+session.getAttribute("abn8"));
			//this.setAbn((String)session.getAttribute("abn8"));
			 /***** WITH LOGIN FUNCTIONALITY *****/
			logger.info("DisplayName:"+session.getAttribute("fullName"));
			this.setDisplayName((String)session.getAttribute("fullName"));
			logger.info("Start Date:" + request.getParameter("from"));
			logger.info("End Date:" + request.getParameter("to"));
			String impersonate = request.getParameter("impersonate");
			this.setAutotype(autotype);
			this.setImpersonate(impersonate);
			String autotype = request.getParameter("autotype");
			if(null != impersonate && impersonate.equals("0") && null !=autotype) {// then Impersonate Id is present, abn=impersonated id
				logger.info("Autotyped impersonated value:"+autotype+". Now set abn=autotype's abn value");
				// Parse the userLoginString and obtain ABN of impersonated id
				StringBuilder sbImpersonatedLoginRecord = new StringBuilder("");
			    sbImpersonatedLoginRecord.append(autotype);
				StringTokenizer stoken = null; 
				stoken = new StringTokenizer(sbImpersonatedLoginRecord.toString(), "|");
				
				String impersonatedAbn = null;
				String impersonatedFullName = null;
				String impersonatedUserId = null;
				if (stoken.hasMoreElements())
					impersonatedFullName = (String) stoken.nextElement();
				
				if (stoken.hasMoreElements())
					impersonatedAbn = (String) stoken.nextElement();
				
				if (stoken.hasMoreElements())
					impersonatedUserId = (String) stoken.nextElement();

				if (impersonatedFullName.equals(""))
					impersonatedFullName = impersonatedUserId;
				session.setAttribute("impersonatedAbn", impersonatedAbn);
				session.setAttribute("impersonatedFullName", impersonatedFullName);
				logger.info("impersonatedAbn:"+impersonatedAbn);
				logger.info("impersonatedFullName:"+impersonatedFullName);
				sbImpersonatedLoginRecord = null;
				this.setAbn(impersonatedAbn);
				this.setDisplayName((String)session.getAttribute("impersonatedFullName"));
				
			}
			else if(null != impersonate && impersonate.equals("1")){ // then none is selected. Abn=login value
				// do nothing. ABN=login value.
				this.setAbn((String)session.getAttribute("abn8"));
				
				logger.info("impersonated value is None. Now set abn=logged in user value");
				this.setDisplayName((String)session.getAttribute("fullName"));
				
			}
			else if(null != impersonate && impersonate.equals("2")){ // then Company's report is selected. Abn=Company
				
				this.setAbn("Company");
				
				logger.info("impersonated value is Company's report. Now set abn=Company");
				this.setDisplayName("Stewart & Stevenson");
				
			}
			
			
			
			this.setStartDate(request.getParameter("from"));
			this.setEndDate(request.getParameter("to"));
			
			
			
			//------------------- new webservice-----------------------
			BeanPacker beanPacker =  new BeanPacker();
	
			if(null!=abn && null!=startDate && null!=endDate){
				String tracdbUrl = (String) props.get(ApplicationConstants.SS_TRACDB_URL);
				String httpUrl = tracdbUrl + "?abn=" +this.getAbn()+"&startDate="+startDate+"&endDate="+endDate;
				String result = makeRestfulConnection(props, httpUrl);
				Gson gson = new Gson();
		        beanPacker = gson.fromJson(result, BeanPacker.class);
		        logger.info("result :"+result);
				mergedList = beanPacker.getMergedDsiTracDataList();
			}
	        request.setAttribute("mergedList", mergedList);
	        
	        totalHrsDecimals = beanPacker.getTotalHrsDecimals();
	        logger.info("totalHrsDecimals(100min format) from DAO in controller:" + totalHrsDecimals);
	        request.setAttribute("totalHrsDecimals", totalHrsDecimals);
			this.setTotalHrsDecimals(totalHrsDecimals);
			totalHHMM = beanPacker.getTotalHHMM();
			logger.info("totalHrsMins from DAO in controller:" + totalHHMM);
			request.setAttribute("totalHHMM", totalHHMM);
			this.setTotalHHMM(totalHHMM);
			totalRDHHHMM = beanPacker.getTotalRDHHHMM();
			logger.info("totalRDH from DAO in controller:" + totalRDHHHMM);
			request.setAttribute("totalRDHHHMM", totalRDHHHMM);
			this.setTotalRDHHHMM(totalRDHHHMM);
			
			//------------------- new webservice-----------------------
			
			/*TimeDataDao timeDataDaoTrac = new TimeDataDao(request);
			employeeData = timeDataDaoTrac.getTracReport(this.getAbn(),
					startDate, endDate);
			request.setAttribute("employeeData", employeeData);
			logger.info("Obtained the Trac report. Set in to request attribute. Now obtain TimeTrac report.");

			techData = timeDataDaoTrac.getTimeTracReport(this.getAbn(),
					startDate, endDate);
			request.setAttribute("techData", techData);
			logger.info("Obtained the Time Trac report. Now obtain the merged list. Lets sort it out based on start date.");*/
			
			/*****MERGE AND SORT BOTH THE LISTS OF OBJECTS BASED ON START DATE******/
			/*mergedList = timeDataDaoTrac.getEmpTechMergedList();  
			
			Collections.sort(mergedList, new
			  Comparator<MergedData>() {
			  	  @Override 
				  public int compare(final MergedData object1, final MergedData object2) { 
					  return  object1.getStartDate().compareTo(object2.getStartDate());
					} 
			  });
			for(MergedData temp: mergedList){
				temp.setStartDate(temp.getStartDate() +" - " + temp.getDayOfWeek());
			}
			request.setAttribute("mergedList", mergedList);
			*/
			
				/*****MERGE AND SORT BOTH THE LISTS OF OBJECTS BASED ON START DATE******/
			/*totalHrsDecimals = timeDataDaoTrac.getTotalHrs().toString();
			Double d = Double.parseDouble(totalHrsDecimals);
			totalHrsDecimals = String.format("%.2f", d);
			logger.info("totalHrs from DAO in controller:" + totalHrsDecimals);
			request.setAttribute("totalHrsDecimals", totalHrsDecimals);
			this.setTotalHrsDecimals(totalHrsDecimals);
			totalHHMM = timeDataDaoTrac.getTotalHrsMins();
			logger.info("totalHrsMins from DAO in controller:" + totalHHMM);
			request.setAttribute("totalHHMM", totalHHMM);
			this.setTotalHHMM(totalHHMM);*/
			
			//------------------------------------------------------------/
	       
			// retain the input values on form
			request.setAttribute("displayName", this.getDisplayName());
			//request.setAttribute("abn", this.getAbn());
			request.setAttribute("from", this.getStartDate());
			request.setAttribute("to", this.getEndDate());
			request.setAttribute("autotype", this.getAutotype());
			request.setAttribute("impersonate", this.getImpersonate());
			logger.info("impersonate:" + this.getImpersonate());
			logger.info("Display name:" + this.getDisplayName());
			logger.info("ABN:" + this.getAbn());
			logger.info("Start Date:" + this.getStartDate());
			logger.info("End Date:" + this.getEndDate());
			logger.info("Autotype:" + this.getAutotype());
			logger.info("-------------------------*********END OF CYCLE*****************------------------------");

		} catch (Exception e) {
			Email.send(bean.getErrorToEmail(), bean.getErrorFromEmail(), bean.getErrorSubject(),
					bean.getErrorSmtpHost(),e.getMessage());
			logger.error("In getReport() ERROR => ", e);
		}

		return SUCCESS;

	}
	

	public String makeRestfulConnection(Properties props, String httpUrl) {
		CommonUtilities myUtil = new CommonUtilities();
		ErrorEmailHeaderBean bean = myUtil.getEmailInfoFromProperties(props);
		BufferedReader rd = null;
		HttpClient client = null;
		String response = null;
		

		try {
			httpUrl = "http:" + httpUrl;
			logger.info("In makeRestfulConnection getting ApplicationProperties httpUrl------"
					+ httpUrl);
			client = new DefaultHttpClient();
			HttpGet httpGet = new HttpGet(httpUrl);
			httpGet.addHeader("accept", "application/json");
			HttpResponse httpResponse = client.execute(httpGet);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			rd = new BufferedReader(new InputStreamReader(httpResponse
					.getEntity().getContent()));
			StringBuffer result = new StringBuffer();
			String line = "";

			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			if (null != result) {
				response = result.toString();
			}
			if(statusCode!=200){	
				Email.send(bean.getErrorToEmail(), bean.getErrorFromEmail(), bean.getErrorSubject(),
						bean.getErrorSmtpHost(),response);
				logger.info("error in makeRestfulConnection processing status code: "+ statusCode);
			}

		} catch (Exception e) {
			Email.send(bean.getErrorToEmail(), bean.getErrorFromEmail(), bean.getErrorSubject(),
					bean.getErrorSmtpHost(),e.getMessage());
			logger.error("error in makeRestfulConnection processing ", e);
		} finally {
			if (null != rd)
				rd = null;
			if (null != client)
				try {
					client.getConnectionManager().shutdown();
				} catch (Exception e) {
					Email.send(bean.getErrorToEmail(), bean.getErrorFromEmail(), bean.getErrorSubject(),
						bean.getErrorSmtpHost(),e.getMessage());
					logger.error(
							"makeRestfulConnection Finally Exception ERROR => ",
							e);
				}
		}
		return response;
		
	}
	public ServletContext getServletContext()
	 {
		 ServletContext servletContext =  (ServletContext) context; 
		 return servletContext;
	 }
	
}
