<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<html>
	<head>
	<title><spring:message code="COM_PRODUCT_NAME" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="<c:url value="/resources/css/style_en.css" />" type="text/css" />
	<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery-1.6.1.min.js" />"></script>
	<%@ include file="/WEB-INF/jsp/include/header.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var cookieValue = ""+getCookie('clientlanguage');

			if(cookieValue.toUpperCase() == 'KO' || cookieValue.toUpperCase() == 'KR' || 
					cookieValue.toUpperCase() == 'KO_KR') {
				$("#setLocale").val('ko');
			}
			else if(cookieValue.toUpperCase() == 'EN' || cookieValue.toUpperCase() == 'US' ||
					cookieValue.toUpperCase() == 'EN_US'){
				$("#setLocale").val('en');
			}
			else {
				$("#setLocale").val('en');
			}

			multiAccessControl();
			//alert("여기서 한다");
			
			$("#USERID").focus();
		});

		function getCookie(name) {
			var Found = false;
			var start;
			var end;
			var i = 0;

			while (i <= document.cookie.length) { 
				start = i ;
				end = start + name.length ;

				if(document.cookie.substring(start, end) == name) { 
					Found = true ;
					break ;
				} 
				i++ ;
			} 

			if(Found == true) { 
				start = end + 1 ;
				end = document.cookie.indexOf(';', start) ;

				if(end < start) 
					end = document.cookie.length ;

				return document.cookie.substring(start, end) ;
			} 

			return false ;
		}
		function selectLocale(selectObj) {
			if (selectObj.value == 'ko')
				window.location = '${pageContext.request.contextPath}/login.do?locale=kr';			
			else
				window.location = '${pageContext.request.contextPath}/login.do?locale=en';
		}
		
		// Enter Key Push
		function checkEnter(keyCode) {
			if(keyCode == 13) {
				if($("#USERID").val() == "") {
					$("#USERID").focus();
					return;
				}

				if($("#USERPWD").val() == "") {
					$("#USERPWD").focus();
					return;
				}

				formSubmit();
			}
		}
		// 로그인
		function formSubmit() {
			$("#loginFrm").submit();
		}

		// 중복 계정으로 접근 시 차단 여부 확인
		function multiAccessControl() {
			var error = $.getUrlVar('error');
			if (error == 'session'){
				//openDialog(null, null, null, $.i18n.prop("MULTI_ACCESS_ERR_DES02"));
				openDialog(null, null, 500, '<spring:message code="MULTI_ACCESS_ERR_DES02" />', '<spring:message code="COM_PRODUCT_NAME" />');
			}
		}

		$.extend({
		  getUrlVars: function(){
		    var vars = [], hash;
		    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		    for(var i = 0; i < hashes.length; i++)
		    {
		      hash = hashes[i].split('=');
		      vars.push(hash[0]);
		      vars[hash[0]] = hash[1];
		    }
		    return vars;
		  },
		  getUrlVar: function(name){
		    return $.getUrlVars()[name];
		  }
		});
	</script>
	</head>
<body>   
<!-- s: Content container -->
<div id="single_container">   
	<div class="login_wrap">
		<div class="login_position">
			<div class="login_content01">
				<h1><img src="<c:url value="/resources/image/tit_login01.gif" />" /></h1>
				<div class="login_form">
					<div class="userId">
						<label for="entry_id"><spring:message code="ADMN_LOGIN_TXT03" htmlEscape="false" /></label>
						<select name="setLocale" style="width:176px" id="setLocale" class="wide" onchange="javascript:selectLocale(this)">
					    	<option value="ko"><spring:message code="ADMN_LOGIN_BTN01" /></option>
							<option value="en"><spring:message code="ADMN_LOGIN_BTN02" /></option>
							<!-- <option value="jp"><spring:message code="ADMN_LOGIN_BTN03" /></option> -->
						</select>
					</div>
					<form name="loginFrm" action="<c:url value='/j_spring_security_check'/>" method="post" id="loginFrm">
					<div class="userId">
						<label for="entry_id"><spring:message code="ADMN_LOGIN_TXT01" htmlEscape="false" /></label>
						<input id="USERID" name="j_username" type="text" onkeypress="checkEnter(event.keyCode);" value=""/>
					</div>
					<div class="userPwd">
						<label for="entry_pwd"><spring:message code="ADMN_LOGIN_TXT02" htmlEscape="false" /></label>
						<input id="USERPWD" name="j_password" type="password" onkeypress="checkEnter(event.keyCode);" value=""/>
					</div>
					<div class="loginBtn">
						<a href="javascript:formSubmit();"><spring:message code="COM_BTN_LOGIN" /></a>
					</div>
					<input id="MULTISESSIONCOMMAND" name="MULTISESSIONCOMMAND" type="hidden" value="0"/>
	 				</form>
	 				<p class="txt01">
						<!-- IP / PW 오류시 -->
						<c:if test="${param.error == true}">
				            <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}" escapeXml="false"/> 
						</c:if>
						<!-- IP 접근제한시 -->
						<c:if test="${param.error != true and error == 'ip'}">
				            <spring:message code="ADMN_LOGIN_ERR_DES03" htmlEscape="false" />
						</c:if>
						<!--<c:if test="${param.error != true and param.error == 'session'}">
				           	<spring:message code="MULTI_ACCESS_ERR_DES02" htmlEscape="false" />
						</c:if>-->
					</p>
				</div>
				<div class="copyright"><spring:message code="COM_COPYRIGHT" /></div>
			</div>
			<!-- e: Footer container -->
		</div>
	</div> 
	<!-- s: Footer container -->
</div>
<%@ include file="/WEB-INF/jsp/include/dialog.jsp" %>
</body>
</html>