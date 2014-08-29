package com.atin84.starsign.common.properties;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PropertyManager {
	private static Logger logger = LoggerFactory.getLogger(PropertyManager.class);
	private PropertyInjectionConfigurer propertyInjectionConfigurer;
	/**
	 * Constructor
	 */
	public PropertyManager() {
		logger.debug("Create PropertyManager");
	}	
	
	public String getProperyValue(String key) {
		Properties properties = this.propertyInjectionConfigurer.getProperties();
		
		if(properties == null) return null;
		
		return properties.getProperty(key);
	}
		
	/**
	 * @param propertyInjectionConfigurer the propertyInjectionConfigurer to set
	 */
	public void setPropertyInjectionConfigurer(
			PropertyInjectionConfigurer propertyInjectionConfigurer) {
		this.propertyInjectionConfigurer = propertyInjectionConfigurer;
	}
	
	/**
	 * 파일 업로드 경로
	 */
	@Property(name="UPLOAD_BASE")
	private String uploadBase;
	
	/**
	 * 재품 버전
	 */
	@Property(name="PRODUCT_VERSION")
	private String productVersion;

	/**
	 * 서버 버전
	 */
	@Property(name="SERVER_VERSION")
	private String serverVersion;
	
	/**
	 * 패스워드 제한 횟수
	 */
	@Property(name="PASSWORD_LIMIT_COUNT")
	private Integer passwordLimitCount;
	
	@Property(name="V3ME_AGENT")
	private String v3meAgent;
	
	@Property(name="V3ME_CLIENT")
	private String v3meClient;
	
	/**
	 * Default Admin Account
	 */
	@Property(name="DEFAULT_ADMIN_ID")
	private String defaultAdminID;

	@Property(name="DEFAULT_ADMIN_PW")
	private String defaultAdminPW;
	
	/**
	 * 데쉬보드 화면 리플레쉬 시간(sec)
	 */
	@Property(name="DEFAULT_REFRESH_TIME")
	private Integer refreshTime;
	
	
	public String getDefaultAdminID() {
		return defaultAdminID;
	}

	public void setDefaultAdminID(String defaultAdminID) {
		this.defaultAdminID = defaultAdminID;
	}

	public String getDefaultAdminPW() {
		return defaultAdminPW;
	}

	public void setDefaultAdminPW(String defaultAdminPW) {
		this.defaultAdminPW = defaultAdminPW;
	}	

	public String getV3meAgent() {
		return v3meAgent;
	}
	
	public void setV3meAgent(String v3meAgent) {
		this.v3meAgent = v3meAgent;
	}

	public String getV3meClient() {
		return v3meClient;
	}

	public void setV3meClient(String v3meClient) {
		this.v3meClient = v3meClient;
	}

	public String getUploadBase() {
		return uploadBase;
	}

	public void setUploadBase(String uploadBase) {
		this.uploadBase = uploadBase;
	}

	public String getProductVersion() {
		return productVersion;
	}

	public void setProductVersion(String productVersion) {
		this.productVersion = productVersion;
	}

	public String getServerVersion() {
		return serverVersion;
	}

	public void setServerVersion(String serverVersion) {
		this.serverVersion = serverVersion;
	}

	public Integer getPasswordLimitCount() {
		return passwordLimitCount;
	}

	public void setPasswordLimitCount(Integer passwordLimitCount) {
		this.passwordLimitCount = passwordLimitCount;
	}

	public Integer getRefreshTime() {
		return refreshTime;
	}

	public void setRefreshTime(Integer refreshTime) {
		this.refreshTime = refreshTime;
	}
}
