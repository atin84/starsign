<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		init(initSendMode);
	});
	function initSendMode() {
		var service = new Object();
		var data = new Object();

		data["ACTION"] = "propertySelect.NotifyMode";

		service["selectObject"] = data;

		doAction(service, function(result) {
			var obj = result["selectObject"];

			$("input[name='NOTIFYMODE'][VALUE='" + obj["NOTIFYMODE"] + "']").attr("checked", "checked");

		}, function(jqXHR, textStatus, errorThrown) {
			alert("error Callback : " + jqXHR + " / " + textStatus
					+ " / " + errorThrown);
		});

	}

	function updateAction() {
		openDialog("updateNotifyModeDialog", getUpdateButtonAction(), 300);
	}

	function getUpdateButtonAction() {
		var button = {
			"<spring:message code='COM_BTN_YES' />" : function() {
				var service = {};
				var data = {};

				data["ACTION"] = "propertyUpdate.property";
				data["NOTIFYMODE"] = $("input[name='NOTIFYMODE']:checked").val();

				service["updateObject"] = data;

				doAction(service, function(result) {
					//refreshGrid();
				});

				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};

		return button;
	}
</script>

<form id="formData" method="post" accept-charset="utf-8">

<h2 class="h2_title04"><spring:message code="CNFG_SMS_MNU05" /></h2>

<br />
<p class="txt01"><spring:message code="CNFG_MODE_DES01" /></p>
 <div class="option_table_wrap01">
	<table cellpadding="0" cellspacing="0" border="0" >
		<tr>
			<th>&nbsp;</th>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th><input type="radio" id="NOTIFYMODE" name="NOTIFYMODE" value="1"/></th>
			<td><span>&nbsp;&nbsp;<spring:message code="CNFG_MODE_RDO01" /></span></td>
		</tr>
		<tr><th>&nbsp;</th><td>&nbsp;</td></tr>
		<tr>
			<th>
			<div class="ct">
				<input type="radio" id="NOTIFYMODE" name="NOTIFYMODE" value="2"/> 
			</div>
			</th>
			<td><span>&nbsp;&nbsp;<spring:message code="CNFG_MODE_RDO02" /></span></td>
		</tr>
		<tr><th>&nbsp;</th><td>&nbsp;</td></tr>
		<tr>
			<th>
			<div class="ct">
				<input type="radio" id="NOTIFYMODE" name="NOTIFYMODE" value="3"/> 
			</div>
			</th>
			<td><span>&nbsp;&nbsp;<spring:message code="CNFG_MODE_RDO03" /></span></td>
		</tr>
		<tr><th>&nbsp;</th><td>&nbsp;</td></tr>
		<tr>
			<th>
			<div class="ct">
				<input type="radio" id="NOTIFYMODE" name="NOTIFYMODE" value="0"/> 
			</div>
			</th>
			<td><span>&nbsp;&nbsp;<spring:message code="CNFG_MODE_RDO04" /></span></td>
		</tr>
	</table>
</div>	
</form>

<div class="entry_query_wrap">
	<div class="btn">
		<span class="buttonLg"><a href="javascript:updateAction();"><spring:message code="COM_BTN_APPLY" /></a></span>
	</div>
</div>

<div id="updateNotifyModeDialog" title="" style="display:none">
	<p><spring:message code="PLCY_GRUP_APPLY_DES01" /></p>
</div>