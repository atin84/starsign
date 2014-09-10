<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<!-- <c:set var="currentLocaleLanguage" value="${pageContext.request.locale.language}" /> -->
<c:set var="currentLocaleLanguage" value="${currentLocale}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><spring:message code="COM_PRODUCT_NAME" /></title>

<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery/2.1.1/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui/1.11.1/jquery-ui.min.js" />"></script>
<!--
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery-1.6.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery-ui-1.8.11.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery-ui-i18n.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery.blockUI.js" />"></script>
 -->
 
<!-- jQuery Progressbar -->
<!--
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jquery.progressbar.min.js" />"></script>
 -->
 
<!-- Jqgrid -->
<!--
<c:choose>
<c:when test="${currentLocaleLanguage == 'ko'}">
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jqgrid/i18n/grid.locale-kr.js" />"></script>
</c:when>
<c:when test="${currentLocaleLanguage == 'jp'}">
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jqgrid/i18n/grid.locale-ja.js" />"></script>
</c:when>
<c:otherwise>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jqgrid/i18n/grid.locale-en.js" />"></script>
</c:otherwise>
</c:choose>
<script type="text/javascript" src="<c:url value="/resources/js/jquery/jqgrid/jquery.jqGrid.min.js" />"></script>
 -->
 
<!-- HighCharts -->
<!--
<script type="text/javascript" src="<c:url value="/resources/js/highcharts/highcharts.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/highcharts/themes/gray.js" />"></script>
 -->
 
<!-- common javascript -->
<!--
<script type="text/javascript" src="<c:url value="/resources/js/common/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common/mapCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common/gridCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common/validation.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.i18n.properties-min-1.0.9.js" />"></script>
 -->
 
<!-- MD5 툴킷 -->
<!--
<script type="text/javascript" src="<c:url value="/resources/js/webtoolkit.md5.js" />"></script>
 -->
 
<!-- Stylesheet -->
<!--
<link rel="stylesheet" href="<c:url value="/resources/css/ui.jqgrid.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/ui.multiselect.css" />" type="text/css" />
<c:choose>
<c:when test="${currentLocaleLanguage == 'ko'}">
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui-1.8.14.custom_kr.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/style_kr.css" />" type="text/css" />
</c:when>
<c:when test="${currentLocaleLanguage == 'jp'}">
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui-1.8.14.custom_jp.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/style_jp.css" />" type="text/css" />
</c:when>
<c:otherwise>
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui-1.8.14.custom_en.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/style_en.css" />" type="text/css" />
</c:otherwise>
</c:choose>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />" type="text/css" />
-->

<!-- 구글맵 API 정의 -->
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var gridPath = "${pageContext.request.contextPath}/grid/gridList.do?ACTION=";
	var gridEditPath = "${pageContext.request.contextPath}/gridEdit/";
	
	//var language = '<c:out value="${pageContext.request.locale.language}" />';
	var language = '${currentLocaleLanguage}';
	
	var required = '<strong style="color: #de4444;">(*)</strong>';
	var onChange = false;

	$(document).ready(function() {
		
		// 로딩바 보이게 하기
		$(document)
		.ajaxStart(function() {
			var pageMenu = '${pageMenu}';
			if(pageMenu == "dashboard") {
				$.blockUI({
					message: '<img src="${pageContext.request.contextPath}/resources/image/ajax-loader.gif" />',
					fadeIn: 700, 
					fadeOut: 700,
					timeout: 3000,
					showOverlay: false,
					css: { 
		            	border: 'none', 
		            	padding: '15px', 
		            	backgroundColor: '#000', 
		            	'-webkit-border-radius': '10px', 
		            	'-moz-border-radius': '10px', 
		            	opacity: .5, 
		            	color: '#fff' 
		        	}
			    }); 
			}
			else {
				$.blockUI({
					message: '<img src="${pageContext.request.contextPath}/resources/image/ajax-loader.gif" />',
					fadeIn: 700, 
					fadeOut: 700,
					timeout: 3000,
					//showOverlay: false,
					css: { 
		            	border: 'none', 
		            	padding: '15px', 
		            	backgroundColor: '#000', 
		            	'-webkit-border-radius': '10px', 
		            	'-moz-border-radius': '10px', 
		            	opacity: .5, 
		            	color: '#fff' 
		        	}
			    }); 
			}
			
        })
        .ajaxStop(function() {
        	$.unblockUI();
		});
		
		//alert(language);

		if(language == 'ko')
			$.datepicker.setDefaults( $.datepicker.regional[language] );
		else if(language == 'jp')
			$.datepicker.setDefaults( $.datepicker.regional['ja'] );
		else
			$.datepicker.setDefaults( $.datepicker.regional[''] );
	});
	
	/**
	 * 사용자 정보 수정하기
	 * @param adminId
	 * @return
	 */
	function editUserAction(adminId, object) {
		var action = {
			"<spring:message code='COM_BTN_OK' />" : function() {
				// 필수 항목 체크
				if(validation("adminEditDialog")) {
					
					var service = new Object();
					var param = new Object();
					
					param["ACTION"] = "update.admin";
					param["ADMINID"] = $("#ED_ADMINID").val();
					param["NAME"] = $("#ED_NAME").val();
					param["PHONE"] = $("#ED_PHONE").val();
					param["EMAIL"] = $("#ED_EMAIL").val();
					param["STARTIP"] = $("#ED_STARTIP").val();
					param["ENDIP"] = $("#ED_ENDIP").val();
					param["DESCRIPTION"] = $("#ED_DESCRIPTION").val();

					service["adminUpdate"] = param;

					var userName = $("#ED_NAME").val();
					
					doAction(service, function(result) {
						if (adminId == '${currUser.adminId}'){
							changeUserName(userName);
							setSessionRefreshFlag(adminId);
						}
						$("#grid").trigger("reloadGrid");
					});

					$(this).dialog("close");
				}
			},
			"<spring:message code='COM_BTN_CANCEL' />" : function() {
				$(this).dialog("close");
			}
		};
		if(object) {
			for(var name in object) {
				$("#ED_" + name).val(object[name].replace(/\s/g,''));
			}
		}
		else {
			var ret = jQuery("#grid").jqGrid('getRowData', adminId);
			$("#ED_ADMINID").val(ret.ADMINID);
			$("#ED_PW").val(ret.PW);
			$("#ED_NAME").val(ret.NAME);
			$("#ED_PHONE").val(ret.PHONE);
			$("#ED_EMAIL").val(ret.EMAIL);
			$("#ED_STARTIP").val(ret.STARTIP);
			$("#ED_ENDIP").val(ret.ENDIP);
			$("#ED_DESCRIPTION").val(ret.DESCRIPTION);
		}
		
		$(".ui-state-error").html('<spring:message code="DVIC_ADMN_ADD_DES01" />');
		openDialog("adminEditDialog", action, 500, null, '<spring:message code="ADMN_INFO_EDIT_TTL01" />');
	}
	/**
	 * 사용자 정보 패스워드 수정하기
	 * @return
	 */
	function changePwAction() {
		var action = {
			"<spring:message code='COM_BTN_OK' />" : function() {
				// 필수 항목 체크
				if(validation("changePwDialog")) {
					
					if ($("#ED_PW").val() != MD5($("#CH_CUR_PW").val())) {
						openDialog("checkAlertDialog", null, null, '<spring:message code="CNFG_ADMN_PW_DES02" />');
						$("#CH_CUR_PW").focus();
						return;
					}
					
					if ($("#CH_PW").val() != $("#CH_PW_VERIFY").val()) {
						openDialog("checkAlertDialog", null, null, '<spring:message code="CNFG_ADMN_PW_DES01" />');
						$("#CH_PW").focus();
						return;
					}
					
					if ($("#CH_PW").val() != $("#CH_PW_VERIFY").val()) {
						openDialog("checkAlertDialog", null, null, '<spring:message code="CNFG_ADMN_PW_DES01" />');
						$("#CH_PW").focus();
						return;
					}
					
					var service = new Object();
					var param = new Object();
					
					param["ACTION"] = "update.admin";
					param["ADMINID"] = $("#ED_ADMINID").val();
					param["PW"] = MD5($("#CH_PW").val());

					service["adminUpdate"] = param;
					doAction(service, function(result) {
						$("#ED_PW").val(param["PW"]);
					});
					$(this).dialog("close");
				}
			},
			"<spring:message code='COM_BTN_CANCEL' />" : function() {
				$(this).dialog("close");
			}
		};
		
		$(".ui-state-error").html('<spring:message code="DVIC_ADMN_ADD_DES01" />');
		openDialog("changePwDialog", action, 330, null, "<spring:message code='ADMN_INFO_EDIT_PW_TTL01'/>");
	}
	
	/**
	 * 공통화된 다이얼로그 창 띄우기
	 * @param id 다이얼로그로 띄울 div id
	 * @param buttonAction 다이얼로그에서 적용할 버튼 액션 모음
	 * @param width 다이얼로그 가로 길이
	 * @param alertType 다이얼로그에 입력될 body
	 * @param title 다이얼로그 title
	 * @return
	 */
	function openDialog(id, buttonAction, width, alertType, title) {
		if(id == null) {
			id = "checkAlertDialog";
		}
		if(buttonAction == null) {
			buttonAction = { "<spring:message code='COM_BTN_OK' />" : function() {			
				$(this).dialog("close");
			}};
		}
		if(width == null) {
			width = 300;
		}
		
		switch(alertType) {
			case "GROUP" :
				//$( "#" + id +" .dialogContent").html("정책 그룹을 선택해주세요.");
				$( "#" + id +" .dialogContent").html($.i18n.prop("ERORR_CHKBOX_DES01"));
				break;
			case "WIFI" :
				//$( "#" + id +" .dialogContent").html("Wi-Fi를 선택해주세요.");
				$( "#" + id +" .dialogContent").html($.i18n.prop("ERORR_CHKBOX_DES01"));
				break;
			case "DEVICE" :
				//$( "#" + id +" .dialogContent").html("단말기를 선택해주세요.");
				$( "#" + id +" .dialogContent").html($.i18n.prop("ERORR_CHKBOX_DES01"));
				break;
			// 하는일 없음
			default :
			if(alertType != null) {
				$( "#" + id +" .dialogContent").html(alertType);
			}
			break;
		}
		
		if(title == null) {
			//title = "<img src='" + contextPath + "/resources/image/tit_ahnlab_on.gif' />";
			title = "<p class='dialogTitle'>" + $.i18n.prop("COM_PRODUCT_NAME") + "</p>";
		}
		else {
			//title += " - " + "<img src='" + contextPath + "/resources/image/tit_ahnlab_on.gif' />";
			//title = "<p class='dialogTitle'>" + title + " - " + $.i18n.prop("COM_PRODUCT_SHORT_NAME") + "</p>";
			title = "<p class='dialogTitle'>" + title + "</p>";
		}
		// 장비 등록 다이얼로그 띄우기
		$( "#" + id ).dialog({
			closeOnEscape: false, 
			autoOpen: false,
			resizable : false,
			width : width,
			modal : true,
			title : title,
			buttons : buttonAction,
			close: function (event, ui) {
				// 입력값 초기화
				$("#" + id + " .FormElement").val("");
				// 다이얼로그 없애기
	            $(this).dialog('destroy');
	        } 
		});

		$( "#" + id ).dialog("open");
	}
	
</script>