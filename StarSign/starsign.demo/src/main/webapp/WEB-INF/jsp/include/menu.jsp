<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">	
	var pageMenu = '${pageMenu}';
	var page = '${page}';
	var isHelpShow = false;
	var isDocument = false;
	
	var currentLocale = '${currentLocale}';
	
	$(document).ready(function() {
		if(currentLocale == 'ko') {
			$("#localeDisplayLanguage").html('<spring:message code="PRD_INFO_TXT03" />&nbsp;<spring:message code="ADMN_LOGIN_BTN01" />');	
		}
		else {
			$("#localeDisplayLanguage").html('<spring:message code="PRD_INFO_TXT03" />&nbsp;<spring:message code="ADMN_LOGIN_BTN02" />');
		}
		
		
			var pageMenu = '${pageMenu}';
			switch(pageMenu) {
				case 'dashboard' :
				case 'policy' :
				case 'mobile' :
				case 'monitoring' :
				case 'env' :
					onChangeMenu(pageMenu);
					break;
				default : 
					break;
			}
			
			$("#draggable").draggable({ disabled: true });
			$(document.body).click(function(event) {
				if(event.target.id != "help" && isHelpShow) {
					isHelpShow = false;
					$("#draggable").hide();	
				}
			});
			$("#help").click(function() {
				if(isHelpShow) {
					isHelpShow = false;
					$("#draggable").hide();	
				}
				else {
					isHelpShow = true;
					$("#draggable").show();	
				}
			});
		}
	);

	$(window).load(function(){
		if ('${currUser.pw}' == MD5('webadmin')){
			chkWebadminPassword();	
		}
	});
	
	function onChangeMenu(id) {
		switch(id) {
			case 'dashboard' :
			{
				//$("#subMenu").html('<li id="dashboard">ㆍ<a href="${pageContext.request.contextPath}/pageView/dashboard.do?pageMenu=dashboard"><spring:message code="MNTR_MNU07" /></a> </li><li id="sendsuccess" class="on">ㆍ<a href="${pageContext.request.contextPath}/pageView/sendsuccess.do?pageMenu=monitoring"><spring:message code="MNTR_MNU08" /></a> </li> <li id="badcodesearch">ㆍ<a href="${pageContext.request.contextPath}/pageView/badcodesearch.do?pageMenu=monitoring"><spring:message code="MNTR_MNU10" /></a> </li><li id="policyapply" class="on">ㆍ<a href="${pageContext.request.contextPath}/pageView/policyapply.do?pageMenu=monitoring"><spring:message code="MNTR_MNU13" /></a></li><li id="updateTime" class="updateTime"><span id="refreshTime"></span><span class="buttonSg strong"><a href="#" id="refreshButton"><spring:message code="MNTR_BTN01" /></a></span></li>');
				$("#subMenu").html('<li id="dashboard">ㆍ<a href="${pageContext.request.contextPath}/pageView/dashboard.do?pageMenu=dashboard"><spring:message code="MNTR_MNU07" /></a> </li><li id="sendsuccess" class="on">ㆍ<a href="${pageContext.request.contextPath}/pageView/sendsuccess.do?pageMenu=monitoring"><spring:message code="MNTR_MNU08" /></a> </li> <li id="badcodesearch">ㆍ<a href="${pageContext.request.contextPath}/pageView/badcodesearch.do?pageMenu=monitoring"><spring:message code="MNTR_MNU10" /></a> </li><li id="policyapply" class="on">ㆍ<a href="${pageContext.request.contextPath}/pageView/policyapply.do?pageMenu=monitoring"><spring:message code="MNTR_MNU13" /></a></li>');
				$("#updateTime").show();
				break;
			}
			case 'monitoring' :
			{
				$("#subMenu").html('<li id="dashboard">ㆍ<a href="${pageContext.request.contextPath}/pageView/dashboard.do?pageMenu=dashboard"><spring:message code="MNTR_MNU07" /></a> </li><li id="sendsuccess" class="on">ㆍ<a href="${pageContext.request.contextPath}/pageView/sendsuccess.do?pageMenu=monitoring"><spring:message code="MNTR_MNU08" /></a> </li><li id="badcodesearch">ㆍ<a href="${pageContext.request.contextPath}/pageView/badcodesearch.do?pageMenu=monitoring"><spring:message code="MNTR_MNU10" /></a> </li><li id="policyapply" class="on">ㆍ<a href="${pageContext.request.contextPath}/pageView/policyapply.do?pageMenu=monitoring"><spring:message code="MNTR_MNU13" /></a></li>');
				$("#updateTime").hide();
				break;
			}
			case 'policy' :
			{
				$("#subMenu").html('<li id="policygroup">ㆍ<a href="${pageContext.request.contextPath}/pageView/policygroup.do?pageMenu=policy"><spring:message code="PLCY_GRUP_MNU01" /></a> </li><li id="policymanage">ㆍ<a href="${pageContext.request.contextPath}/pageView/policymanage.do?pageMenu=policy"><spring:message code="PLCY_GRUP_MNU02" /></a> </li><li id="network">ㆍ<a href="${pageContext.request.contextPath}/pageView/network.do?pageMenu=policy"><spring:message code="PLCY_GRUP_MNU03" /></a></li> <li id="app">ㆍ<a href="${pageContext.request.contextPath}/pageView/app.do?pageMenu=policy"><spring:message code="PLCY_GRUP_MNU04" /></a></li>');
				$("#updateTime").hide();
				break;
			}
			case 'mobile' :
			{
				$("#subMenu").html('<li id="mobilecontrol">ㆍ<a href="${pageContext.request.contextPath}/pageView/mobilecontrol.do?pageMenu=mobile"><spring:message code="DVIC_SEL_NONE_MNU01" /></a></li> <li id="mobilemanage">ㆍ<a href="${pageContext.request.contextPath}/pageView/mobilemanage.do?pageMenu=mobile"><spring:message code="DVIC_SEL_NONE_MNU02" /></a></li>');
				$("#updateTime").hide();
				break;
			}
			case 'env' :
			{
				//$("#envMenu").attr("src", "<c:url value='/resources/image/btn_property01.gif' />");
				$("#updateTime").hide();
				break;
			}
		}
		$(".gnb_wrap .on").removeClass("on");
		$("#env").removeClass("gnb_property_btn");
		$("#env").removeClass("gnb_property");
		
		if(id == "env") {
			$("#env").addClass("gnb_property");
		}
		else {
			$("#env").addClass("gnb_property_btn");
		}
		
		if(id != "env") {
			if (id != "dashboard"){
				$("#" + id).addClass("on");
				//$("#envMenu").attr("src", "<c:url value='/resources/image/btn_property01.gif' />");
			}
			else {
				$("#monitoring").addClass("on");
				//$("#envMenu").attr("src", "<c:url value='/resources/image/btn_property01.gif' />");
			}
		}
		$("#" + page + " > a").addClass("on");
	}
	// 로그 아웃
	function openLogout() {
		var action = {
			"<spring:message code='COM_BTN_YES' />" : function() {
				window.location = "<c:url value='/j_spring_security_logout'/>";
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};
		openDialog(null, action, 300, "<spring:message code='ADMN_LOGOUT_DES01' />");
	}
	// Webadmin 비밀번호 변경여부 체크
	function chkWebadminPassword() {
		var action = {
			"<spring:message code='COM_BTN_OK' />" : function() {
				openEditUserInfo();
				$(this).dialog("close");
			}
		};
		openDialog(null, action, 300, '${currUser.adminId}' + "<spring:message code='ADMN_LOGIN_ERR_DES05' />");
	}

	// 로그인한 사용자 이름 변경 내용 적용
	function changeUserName(name){
		//$("#userName").text(name + '<spring:message code="MNTR_MNU01" />');
		$("#userName").text(name);
	}

	// 세션 리프레시 플래그 설정
	function setSessionRefreshFlag(id){
		var pageMenu = '${pageMenu}';

		switch(pageMenu) {
			case 'dashboard' :
			case 'monitoring' :
			{
				$("#monitoring a").attr("href", $("#monitoring a").attr("href") + '&refresh=' + id);
				$("#policy a").attr("href", $("#policy a").attr("href") + '&refresh=' + id);
				$("#mobile a").attr("href", $("#mobile a").attr("href") + '&refresh=' + id);
				//$("#env").attr("href", $("#env").attr("href") + '&refresh=' + id);
				$("#envMenu a").attr("href", $("#envMenu a").attr("href") + '&refresh=' + id);
				$("#dashboard a").attr("href", $("#dashboard a").attr("href") + '&refresh=' + id);
				$("#sendsuccess a").attr("href", $("#sendsuccess a").attr("href") + '&refresh=' + id);
				$("#badcodesearch a").attr("href", $("#badcodesearch a").attr("href") + '&refresh=' + id);
				$("#policyapply a").attr("href", $("#policyapply a").attr("href") + '&refresh=' + id);
				break;
			}
			case 'policy' :
			{
				$("#monitoring a").attr("href", $("#monitoring a").attr("href") + '&refresh=' + id);
				$("#policy a").attr("href", $("#policy a").attr("href") + '&refresh=' + id);
				$("#mobile a").attr("href", $("#mobile a").attr("href") + '&refresh=' + id);
				//$("#env").attr("href", $("#env").attr("href") + '&refresh=' + id);
				$("#envMenu a").attr("href", $("#envMenu a").attr("href") + '&refresh=' + id);
				$("#policygroup a").attr("href", $("#policygroup a").attr("href") + '&refresh=' + id);
				$("#policymanage a").attr("href", $("#policymanage a").attr("href") + '&refresh=' + id);
				$("#network a").attr("href", $("#network a").attr("href") + '&refresh=' + id);
				$("#app a").attr("href", $("#app a").attr("href") + '&refresh=' + id);
				break;
			}
			case 'mobile' :
			{
				$("#monitoring a").attr("href", $("#monitoring a").attr("href") + '&refresh=' + id);
				$("#policy a").attr("href", $("#policy a").attr("href") + '&refresh=' + id);
				$("#mobile a").attr("href", $("#mobile a").attr("href") + '&refresh=' + id);
				//$("#env").attr("href", $("#env").attr("href") + '&refresh=' + id);
				$("#envMenu a").attr("href", $("#envMenu a").attr("href") + '&refresh=' + id);
				$("#mobilecontrol a").attr("href", $("#mobilecontrol a").attr("href") + '&refresh=' + id);
				$("#mobilemanage a").attr("href", $("#mobilemanage a").attr("href") + '&refresh=' + id);
				break;
			}
			case 'env' :
			{				
				$("#monitoring a").attr("href", $("#monitoring a").attr("href") + '&refresh=' + id);
				$("#policy a").attr("href", $("#policy a").attr("href") + '&refresh=' + id);
				$("#mobile a").attr("href", $("#mobile a").attr("href") + '&refresh=' + id);
				//$("#env").attr("href", $("#env").attr("href") + '&refresh=' + id);
				$("#envMenu a").attr("href", $("#envMenu a").attr("href") + '&refresh=' + id);
				$("#sms a").attr("href", $("#sms a").attr("href") + '&refresh=' + id);
				$("#serviceserver a").attr("href", $("#serviceserver a").attr("href") + '&refresh=' + id);
				$("#code a").attr("href", $("#code a").attr("href") + '&refresh=' + id);
				$("#sendmode a").attr("href", $("#sendmode a").attr("href") + '&refresh=' + id);
				$("#admin a").attr("href", $("#admin a").attr("href") + '&refresh=' + id);
				break;
			}
		}
	}
	
	// 사용자 정보 수정하기
	function openEditUserInfo() {
		var service = {};
		var param = {};
		param["ACTION"] = "select.userInfo";
		param["USERID"] = '${currUser.adminId}';

		service["userInfo"] = param;
		doAction(service, 
			function(result) {
				var obj = result["userInfo"];
				var object = {};
				object["ADMINID"] = obj.ADMINID;
				object["PW"] = obj.PW;
				object["NAME"] = obj.NAME;
				object["PHONE"] = obj.PHONE;
				object["EMAIL"] = obj.EMAIL;
				object["STARTIP"] = obj.STARTIP;
				object["ENDIP"] = obj.ENDIP;
				object["DESCRIPTION"] = obj.DESCRIPTION;
				
				editUserAction('${currUser.adminId}', object);
			}
		);
	}
	// 도움말
	function openHelp() {
		// http://www.ahnlab.com/redir/018/webhelp.rdir?locale=ko_kr
		//var clientLocaleLanguage =  '<c:out value="${pageContext.request.locale.language}" />';
		var helpUrl = "http://www.ahnlab.com/redir/018/webhelp.rdir?locale=";
		if(currentLocale == "ko")
			helpUrl = helpUrl + "ko_kr";
		else if(currentLocale == "ja")
			helpUrl = helpUrl + "ko_kr";
		else
			helpUrl = helpUrl + "ko_kr";
		
		window.open(helpUrl,'wechangeyourlife','fullscreen,scrollbars'); 
	}
	// 제품정보
	function openProductInfo() {
		openDialog("productInfoDialog", null, 400);
	}
</script>


<h1><img src="<c:url value="/resources/image/img_logo01.gif" />" width="191" height="13" alt="" /></h1>
<ul class="utilMenu">
	<li>
		<img src="<c:url value="/resources/image/gnb_bullet1.gif" />" alt="" class="img" />
		<a href="javascript:openEditUserInfo();" id="userName" class="underline">${currUser.name}</a><spring:message code="MNTR_MNU01" />
	</li>
	<li class="out">
		<span><a href="javascript:openLogout();"><spring:message code="MNTR_MNU02" /></a></span>
	</li>
	<li class="end">
		<a href="#" id="help"><spring:message code="MNTR_MNU03" /></a>
		<img src="<c:url value="/resources/image/gnb_bullet2.gif" />" alt=""  class="img" style="vertical-align:middle;" />
	<div id="draggable" class="ui-widget-content" style="display: none; width: 95px; height:53px; position: absolute; z-index: 9999; padding-top: 0px;">
		<ul>
			<li><a href="javascript:openHelp();"><spring:message code="HELP_LNK01" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li><a href="javascript:openProductInfo();"><spring:message code="HELP_LNK02" /></a></li>
		</ul> 
	</div>
	</li>
</ul>

<ul class="gnb_property_btn" id="env">
	<!-- <li><span id="envMenu"><a href="<c:url value="/pageView/sms.do?pageMenu=env" />"><spring:message code="MNTR_MNU11" /></a></span></li> -->
	<li><span id="envMenu"><a href="${pageContext.request.contextPath}/pageView/serviceserver.do?pageMenu=env"><spring:message code="MNTR_MNU11" /></a></span></li>
</ul>

<ul class="gnb_wrap">
	<li id="monitoring"><a href="${pageContext.request.contextPath}/pageView/dashboard.do?pageMenu=dashboard"><span><spring:message code="MNTR_MNU04" /></span></a></li>
	<li id="mobile"><a href="${pageContext.request.contextPath}/pageView/mobilecontrol.do?pageMenu=mobile"><span><spring:message code="MNTR_MNU05" /></span></a></li>
	<li id="policy"><a href="${pageContext.request.contextPath}/pageView/policygroup.do?pageMenu=policy"><span><spring:message code="MNTR_MNU06" /></span></a></li>
</ul>

<ul id="updateTime" class="updateTime">
	<li>
	<span id="refreshTime"></span>
	<span class="buttonSg">
		<a href="#" id="refreshButton"><spring:message code='MNTR_BTN01' /></a>
	</span>
	</li>
</ul>
<!-- 
<div id="updateTime" class="updateTime" style="display:none;">
	<span id="refreshTime"></span>
	<span class="buttonSg strong">
		<a href="#" id="refreshButton"><spring:message code='MNTR_BTN01' /></a>
	</span>
</div>
-->

<ul id="subMenu" class="subGnb" >
</ul>

<div id="productInfoDialog" style="display: none;">
	<!-- content -->
	<div class="version_msg">
		<p class="txt01"><img src="<c:url value="/resources/image/tit_v3_01.gif" />" width="228" height="18" alt="" /></p>
		<ul >
			<li><spring:message code="PRD_INFO_TXT01" />&nbsp;${productVersion}</li>
			<li><spring:message code="PRD_INFO_TXT02" />&nbsp;${serverVersion}</li>
			<li id="localeDisplayLanguage"></li>
			<li><spring:message code="PRD_INFO_TXT05" />&nbsp;${licenseKey}</li>
		</ul>
		<p class="txt02"><spring:message code="COM_COPYRIGHT" /></p>
	</div>		
</div>

<div id="loadingDiv" style=" width: 100% ; margin-left: auto ; margin-right: auto ;display: none;position: absolute; text-align: center;vertical-align: middle; z-index: 9999">
	<img alt="loading" src="<c:url value="/resources/image/ajax-loader.gif" />" />
</div>
