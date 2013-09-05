<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*;" %>  
<% 
	File file = new File("/home/v3me/mDMService/logs/service.log");
	
	if (!file.exists()) {
	   out.println("Log file not exist...");
	}
	
	BufferedReader reader = new BufferedReader(new FileReader(file));
	String fileString = "";
	
	while((fileString = reader.readLine()) != null){
		out.println(new String(fileString.getBytes("ISO-8859-1"),"Euc-kr"));
		out.println("<br/>");
	}
%>