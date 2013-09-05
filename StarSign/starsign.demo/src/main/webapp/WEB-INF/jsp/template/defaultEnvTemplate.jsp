<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<tiles:insertAttribute name="header" />
</head>
<body class="sub">   
	<div class="header_container">
		<tiles:insertAttribute name="menu" />
	</div>
	<div id="body_container">
		<div class="content_2Col02">
			<div class="left_content">
				<tiles:insertAttribute name="left" />
			</div>
			<div class="center_content">
				<tiles:insertAttribute name="body" />
			</div>
		</div>
	</div>
	<br />
	<div class="footer_container"></div>
	<tiles:insertAttribute name="dialog" />
</body>
</html>