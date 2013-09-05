<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<fmt:bundle basename="com.anlab.v3me.admin.config.i18n.resourceMessage">
<script type="text/javascript">
	$(document).ready(function() {
		var service = {};
		var data = {};
		
		data["ACTION"] = "propertySelect.AppDownloadURL";
		
		service["selectObject"] = data;

		doAction(service, 
			function(result) {
				var obj = result["selectObject"];
				
				$("#APPDOWNLOADURL").val(obj["APPDOWNLOADURL"]);
			},
			function(jqXHR, textStatus, errorThrown) {
				alert("error Callback : " + jqXHR + " / " + textStatus + " / " + errorThrown); 
			}
		);
		
	});
	
	function urlCheckAction() {
		alert("경로 확인");
	}
	function updateAction() {
		openDialog("updateDownloadURLDialog", getUpdateButtonAction());
	}
	function getUpdateButtonAction() {
		 var button = {
			"<spring:message code='COM_BTN_OK' />" : function() {
				var service = {};
				var data = {};
				
				data["ACTION"]   	   = "propertyUpdate.property";
				data["APPDOWNLOADURL"] = $("#APPDOWNLOADURL").val();
				
				service["updateObject"] = data;
				
				doAction(service, function(result) {
					//refreshGrid();
				});
				
				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_CANCEL' />" : function() {
				$(this).dialog("close");
			}
		};

		return button;
	}
	
</script>

<table>
	<tr>
		<td colspan="2">
			다운로드 디렉토리 경로 : <input type="text" id="APPDOWNLOADURL" name="APPDOWNLOADURL" size="100"/>
			<input id="urlCheckAction" type="button" value="경로 확인" onclick="urlCheckAction()" />
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input id="updateAction" type="button" value="적용" onclick="updateAction()" />
		</td>
	</tr>
</table>

<div id="updateDownloadURLDialog" title="" style="display:none">
	<p>변경사항을 적용하시겠습니까?</p>
</div>

</fmt:bundle>