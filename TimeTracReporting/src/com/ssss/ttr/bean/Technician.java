package com.ssss.ttr.bean;

import java.math.BigDecimal;
import java.util.Date;

public class Technician {
	
	private String techId;
	private String techName;
	private String type;
	private String startDate;
	private BigDecimal startTime;
	private BigDecimal endTime;
	private String startTimeHHMM;
	private String endTimeHHMM;
	private BigDecimal totalHours;
	private String hoursMinutes;
	private String dayOfWeek;
	private String transOriginator;
	
	public Technician(){}
	public Technician(String techId, String techName, String type, String startDate, BigDecimal startTime, BigDecimal endTime,  String startTimeHHMM,  String endTimeHHMM, BigDecimal totalHours, String hoursMinutes, String dayOfWeek, String transOriginator){
		this.techId = techId;
		this.techName = techName;
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
	}
	
	public String getTechId() {
		return techId;
	}
	public void setTechId(String techId) {
		this.techId = techId;
	}
	public String getTechName() {
		return techName;
	}
	public void setTechName(String techName) {
		this.techName = techName;
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
	public BigDecimal getStartTime() {
		return startTime;
	}
	public void setStartTime(BigDecimal startTime) {
		this.startTime = startTime;
	}
	public BigDecimal getEndTime() {
		return endTime;
	}
	public void setEndTime(BigDecimal endTime) {
		this.endTime = endTime;
	}
	public BigDecimal getTotalHours() {
		return totalHours;
	}
	public void setTotalHours(BigDecimal totalHours) {
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
	

}
