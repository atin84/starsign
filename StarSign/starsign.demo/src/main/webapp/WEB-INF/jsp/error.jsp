<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" type="text/css" />
<title><spring:message code="COM_PRODUCT_NAME" /></title>

<script type="text/javascript">
	/**
	 * 페이지 이동
	 */
	function moveMainPage() {
		window.location = '${pageContext.request.contextPath}/pageView/dashboard.do?pageMenu=dashboard';
	}
</script>

</head> 

<body>   
<!-- s: Content container -->
<div id="single_container">   
	<div class="error_wrap"> 
		<div class="error_position"> 
			<div class="error_content01">
				<h1><img src="<c:url value="/resources/image/sTit01.gif" />" width="64" height="23" alt="Error" /></h1>
				<div class="error_msg">
					<ul>
					<li class="img_error"><spring:message code="ERORR_DES01" /></li>
					</ul>
				</div>
				<p class="txt02"><spring:message code="ERORR_DES02" /></p>
				<div class="btn_align">
					<span class="buttonLg strong"><a href="javascript:moveMainPage();"><spring:message code="ERORR_BTN01" /></a></span>
				</div>
			</div>
			<div class="copyright"><spring:message code="COM_COPYRIGHT" /></div> 
			<!-- e: Footer container -->
		</div> 
	</div> 
	<!-- s: Footer container -->
</div>
<!-- e: Content container -->
</body>
</html>