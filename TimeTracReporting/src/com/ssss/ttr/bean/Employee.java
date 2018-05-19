package com.ssss.ttr.bean;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Time;
import java.util.Date;

public class Employee {
	private BigDecimal empId;
	private String employeeName;
	private String type;
	private String startDate;
	private Time startTime;
	private Time endTime;
	private String startTimeHHMM;
	private String endTimeHHMM;
	private String totalHours;
	private String hoursMinutes;
	private String dayOfWeek;
	private String transOriginator;
	private String requestedDurationHours;

	public Employee() {}
	
	public Employee(String employeeName, String type, String startDate, Time startTime, Time endTime, String startTimeHHMM,  String endTimeHHMM, String totalHours, String hoursMinutes, String dayOfWeek, String transOriginator,String requestedDurationHours) {
	      this.employeeName = employeeName;
	      this.type = type;
	      this.startDate = startDate;
	      this.startTime = startTime;
	      this.endTime = endTime;
	      this.startTimeHHMM = startTimeHHMM;
	      this.endTimeHHMM = endTimeHHMM;
	      this.totalHours = totalHours;
	      this.hoursMinutes = hoursMinutes;
	      this.dayOfWeek = dayOfWeek;
	      this.transOriginator = transOriginator;
	      this.requestedDurationHours = requestedDurationHours;
	}
	
	public BigDecimal getEmpId() {
		return empId;
	}

	public void setEmpId(BigDecimal empId) {
		this.empId = empId;
	}

	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public Time getStartTime() {
		return startTime;
	}
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}
	public Time getEndTime() {
		return endTime;
	}
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}
	public String getTotalHours() {
		return totalHours;
	}
	public void setTotalHours(String totalHours) {
		this.totalHours = totalHours;
	}

	public String getHoursMinutes() {
		return hoursMinutes;
	}

	public void setHoursMinutes(String hoursMinutes) {
		this.hoursMinutes = hoursMinutes;
	}

	public String getDayOfWeek() {
		return dayOfWeek;
	}

	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getStartTimeHHMM() {
		return startTimeHHMM;
	}
	public void setStartTimeHHMM(String startTimeHHMM) {
		this.startTimeHHMM = startTimeHHMM;
	}
	public String getEndTimeHHMM() {
		return endTimeHHMM;
	}
	public void setEndTimeHHMM(String endTimeHHMM) {
		this.endTimeHHMM = endTimeHHMM;
	}
	public String getTransOriginator() {
		return transOriginator;
	}

	public void setTransOriginator(String transOriginator) {
		this.transOriginator = transOriginator;
	}
	public String getRequestedDurationHours() {
		return requestedDurationHours;
	}
	public void setRequestedDurationHours(String requestedDurationHours) {
		this.requestedDurationHours = requestedDurationHours;
	}
}
