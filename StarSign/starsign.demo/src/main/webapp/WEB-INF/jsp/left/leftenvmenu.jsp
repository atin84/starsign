<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
//$("#subMenu").html('<ul id="env"><li><a href="${pageContext.request.contextPath}/pageView/sms.do?pageMenu=env">SMS Provider</a></li><li><a href="${pageContext.request.contextPath}/pageView/download.do?pageMenu=env">다운로드 URL</a></li><li><a href="${pageContext.request.contextPath}/pageView/serviceserver.do?pageMenu=env">서비스 서버 관리</a></li><li><a href="${pageContext.request.contextPath}/pageView/code.do?pageMenu=env">코드 관리</a></li><li><a href="${pageContext.request.contextPath}/pageView/sendmode.do?pageMenu=env">통지 명령 전송 모드</a></li><li><a href="${pageContext.request.contextPath}/pageView/admin.do?pageMenu=env">관리자관리</a></li></ul>');
</script>
<div class="lbnWrap">
	<!-- <h2>환경설정</h2>  --> 
	<div class="lnb"> 
		<ul>
			<!-- <li id="sms"><a href="<c:url value="/pageView/sms.do?pageMenu=env" />"><spring:message code='CNFG_SMS_MNU01' /></a></li> -->
			<li id="serviceserver"><a href="<c:url value="/pageView/serviceserver.do?pageMenu=env" />"><spring:message code='CNFG_SMS_MNU03' /></a></li>
			<li id="code"><a href="<c:url value="/pageView/code.do?pageMenu=env" />"><spring:message code='CNFG_SMS_MNU04' /></a></li>
			<li id="sendmode"><a href="<c:url value="/pageView/sendmode.do?pageMenu=env" />"><spring:message code='CNFG_SMS_MNU05' /></a></li>
			<li id="admin"><a href="<c:url value="/pageView/admin.do?pageMenu=env" />"><spring:message code='CNFG_SMS_MNU06' /></a></li>
		</ul>
	</div>
</div>
