<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		init(initSMS);
	});
	function initSMS() {
		var service = new Object();
		var data = new Object();
		
		data["ACTION"] = "propertySelect.SMSProvider";
		
		service["selectObject"] = data;

		doAction(service, 
			function(result) {
				var obj = result["selectObject"];
				
				$("#DBTYPE").val(obj["DBTYPE"]);
				$("#JDBCURL").val(obj["JDBCURL"]);
				$("#JDBCID").val(obj["JDBCID"]);
				$("#JDBCPASSWORD").val(obj["JDBCPASSWORD"]);
				$("#SQL").val(obj["SQL"]);
				
			},
			function(jqXHR, textStatus, errorThrown) {
				alert("error Callback : " + jqXHR + " / " + textStatus + " / " + errorThrown); 
			}
		);
	}
	
	function updateAction() {
		openDialog("updateSMSDialog", getUpdateButtonAction());
	}
	function getUpdateButtonAction() {
		 var button = {
				 "<spring:message code='COM_BTN_YES' />" : function() {
					var service = {};
					var data = {};
					
					data["ACTION"]   	 = "propertyUpdate.property";
					data["DBTYPE"] 	 	 = $("#DBTYPE").val();
					data["JDBCURL"] 	 = $("#JDBCURL").val();
					data["JDBCID"] 		 = $("#JDBCID").val();
					data["JDBCPASSWORD"] = $("#JDBCPASSWORD").val();
					data["SQL"] 		 = $("#SQL").val();
					
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
<h2 class="h2_title04"><spring:message code="CNFG_SMS_TTL01" /></h2>  
 <div class="option_table_wrap">
	<table cellpadding="0" cellspacing="0" border="0">
		<col width="125" />
		<col width="*" />
		<tr>
			<th><span><spring:message code="CNFG_SMS_TXT05" /></span></th>
			<td>
				<div class="ct">
					<select id="DBTYPE" name="DBTYPE">
						<option value="oracle">ORACLE</option>
						<option value="db2">IBM DB2</option>
						<option value="sqlserver">MICROSOFT SQL SERVER</option>
						<option value="informix">IBM Informix</option>
						<option value="mysql">MySQL</option>
						<option value="sybase">Sybase</option>
						<option value="postgres">PostgreSQL</option>
						<option value="tibero">Tmax Tibero</option>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<th><span><spring:message code="CNFG_SMS_TXT01" /></span></th>
			<td>
				<div class="ct">
					<input type="text" id="JDBCURL" name="JDBCURL" size="50" maxlength="100" class="entry" style="width: px;" />
				</div>
			</td>
		</tr>
		<tr>
			<th><span><spring:message code="CNFG_SMS_TXT02" /></span></th>
			<td>
				<div class="ct">
					<input type="text" id="JDBCID" name="JDBCID" class="entry" size="30" maxlength="30" style="width: px;" />
				</div>
			</td>
		</tr>
		<tr>
			<th><span><spring:message code="CNFG_SMS_TXT03" /></span></th>
			<td>
				<div class="ct">
					<input type="password" id="JDBCPASSWORD" name="JDBCPASSWORD" class="entry" size="30" maxlength="30" style="width: px;" />
					<p class="txt01"><spring:message code="CNFG_SMS_DES01" /></p>
				</div>
			</td>
		</tr>
	</table>
</div>

</form>

<h2 class="h2_title04"><spring:message code="CNFG_SMS_TTL02" /></h2>  

<div class="entry_query_wrap">
	<div class="entry_txt">
		<textarea rows="5" cols="100" id="SQL" name="SQL" style="resize: none;"></textarea>
	</div>
	<div class="btn">
		<span class="buttonLg"><a href="javascript:updateAction();"><spring:message code="COM_BTN_APPLY" /></a></span>
	</div>
</div>
<div id="updateSMSDialog" title="" style="display:none">
	<p><spring:message code="PLCY_GRUP_APPLY_DES01" /></p>
</div>