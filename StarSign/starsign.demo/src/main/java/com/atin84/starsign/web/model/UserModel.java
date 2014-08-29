package com.atin84.starsign.web.model;

/**
 * 사용자 정보
 * @author semoria
 *
 */
public class UserModel {

	private String adminId;
	private String pw;
	private String name;
	private String email;
	private String phone;
	private String pwretryCount;
	private String startIp;
	private String endIp;
	private String description;
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStartIp() {
		return startIp;
	}
	public void setStartIp(String startIp) {
		this.startIp = startIp;
	}
	public String getEndIp() {
		return endIp;
	}
	public void setEndIp(String endIp) {
		this.endIp = endIp;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPwretryCount() {
		return pwretryCount;
	}
	public void setPwretryCount(String pwretryCount) {
		this.pwretryCount = pwretryCount;
	}
}
