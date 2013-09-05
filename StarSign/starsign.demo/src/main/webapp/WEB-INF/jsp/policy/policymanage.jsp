<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	/*
	 * 정책 관리 테이블 생성
	 */
	function createDetailPolicyInfo(policyId) {
		// 화면 채워 넣기
		makeDetailPolicyInfo(policyId, false);
	}
	/*
	 * 적용하기
	 */
	function updatePolicy() {
		if($("#WIFILISTINFOID").val() == "") {
			$("#WIFILISTINFOID").val("null");
		}
		
		var buttonAction = {
			"<spring:message code='COM_BTN_YES' />" : function() {
				var service = {};
				// 정책 파라미터 설정
				var param = getSearchParam($("#policyForm div table tr :input"));
				if(param["ROOTINGCHECKYN"] == "N") {
					param["ROOTINGALERTYN"] = "N";
				}
					
				param["ACTION"] = "update.policyInfo";
				param['POLICYID'] = $("#POLICYID").val();
				
				service["updatePolicy"] = param;
				
				doAction(service, function(result) {
					if($("#WIFILISTINFOID").val() == null) {
						$("#WIFILISTINFOID").val("");
					}
				});
				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};
		
		openDialog("updateDialog", buttonAction);
	}
</script>
<div id="policyForm">
</div>