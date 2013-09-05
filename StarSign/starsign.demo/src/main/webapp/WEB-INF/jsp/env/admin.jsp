<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {
		var adminid = '${currUser.adminId}';
		if (adminid == 'webadmin'){
			$("#addBtn").show();
		}
		init(initAdmin);
	});
	
	function initAdmin() {
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.admin',
			editurl : gridEditPath + 'admin.do',
			mtype: 'POST',
			datatype: 'json',
				colNames:['<spring:message code="CNFG_ADMN_LST01" />',
				          '<spring:message code="ADMN_INFO_EDIT_TXT03" />',
				          '<spring:message code="ADMN_INFO_EDIT_TXT04" />',
				          '<spring:message code="ADMN_INFO_EDIT_TXT05" />',
				          '<spring:message code="ADMN_INFO_EDIT_TXT06" />',
				          '<spring:message code="CNFG_ADMN_LST06" />',
				          '', '', '', '', '', ''],
				colModel:[
					{title:false, name:'ADMINID',index:'ADMINID', key:true, align:"left", width:110},
					{title:false, name:'NAME',index:'NAME', editable:true, editrules:{required:true}, formoptions:{elmsuffix:required}, align:"left", width:90},
					{title:false, name:'PHONE',index:'PHONE', editable:true, editrules:{required:true}, formoptions:{elmsuffix:required}, align:"left", width:100},
					{title:false, name:'EMAIL',index:'EMAIL', editable:true, align:"left", width:150},
					{title:false, name:'IPRANGE',index:'IPRANGE', editable:true, align:"left", width:160},
					{title:false, name:'DESCRIPTION',index:'DESCRIPTION', editable:true, align:"left", width:120},
					{title:false, name:'ACTION',index:'ACTION', align:"left", width:70},
					{title:false, name:'STARTIP',index:'STARTIP', hidden:true},
					{title:false, name:'ENDIP',index:'ENDIP', hidden:true},
					{title:false, name:'PW',index:'PW', hidden:true},
					{title:false, name:'PWRETRYCOUNT',index:'PWRETRYCOUNT', hidden:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'ADMINID', sortorder: "asc", rowNum:25, pager: '#pager', height:'100%', width:800,
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'ADMINID', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'NAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'EMAIL', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'IPRANGE', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'DESCRIPTION', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				var ids = $("#grid").jqGrid('getDataIDs');
				var adminid = '${currUser.adminId}';
				//alert(adminid);
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var rowData = $("#grid").getRowData(cl);
					
					var imgModify = "<img src=\"<c:url value='/resources/image/bt_modify.gif' />\" />";
					var imgDel = "<img src=\"<c:url value='/resources/image/bt_del.gif' />\" />";
					var imgUnlock = "<img src=\"<c:url value='/resources/image/bt_open.gif' />\" />";
					var ed = "";
					var de = "";
					var ul = "";
					if (adminid == 'webadmin'){
						//ed = "<a href='javascript:editUserAction(\"" + cl + "\");' class='md'>수정</a> ";
						ed = "&nbsp;&nbsp;<a href='javascript:editUserAction(\"" + cl + "\");' class='md'>" + imgModify + "</a> ";
						if (cl == 'webadmin'){
							//de = "<span class='ds'><spring:message code='COM_BTN_DELETE' /></span>";
						}
						else{
							//de = "<a href='javascript:deleteAction(\"" + cl + "\");' class='dl'><spring:message code='COM_BTN_DELETE' /></a>";
							de = "<a href='javascript:deleteAction(\"" + cl + "\");' class='dl'>" + imgDel + "</a>";
						}
						
						if (rowData.PWRETRYCOUNT > 4){
							//ul = "&nbsp;<a href='javascript:unlockAction(\"" + cl + "\");' class='md'><spring:message code='CNFG_ADMN_TXT01' /></a>";
							ul = "&nbsp;<a href='javascript:unlockAction(\"" + cl + "\");' class='md'>" + imgUnlock + "</a>";
						}
						else{
							//ul = "<span class='ds'>&nbsp;<spring:message code='CNFG_ADMN_TXT01' /></span>";
						}
					}
					else if (adminid == cl){
						//ed = "<a href='javascript:editUserAction(\"" + cl + "\");' class='md'>수정</a> ";
						ed = "&nbsp;&nbsp;<a href='javascript:editUserAction(\"" + cl + "\");' class='md'>" + imgModify + "</a> ";
						//de = "<span class='ds'><spring:message code='COM_BTN_DELETE' /></span>";
						//ul = "<span class='ds'>&nbsp;<spring:message code='CNFG_ADMN_TXT01' /></span>";
					}
					else{
						//ed = "<span class='ds'>수정</span> ";
						//de = "<span class='ds'><spring:message code='COM_BTN_DELETE' /></span>";
						//ul = "<span class='ds'>&nbsp;<spring:message code='CNFG_ADMN_TXT01' /></span>";
					}
					 
					$("#grid").jqGrid('setRowData', ids[i], {"ACTION":ed + de + ul}); 
				} 
				
				initGridUI("grid");		
			},
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			}
		});
	}

	function resetCheckAction() {
		$("#CHECKID").val("0");
	}
	
	function checkAction() {
		if($("#IN_ADMINID").val() != "") {
			var service = new Object();
			var param = new Object();
			
			param["ACTION"] = "select.adminCount";
			param["ADMINID"] = $("#IN_ADMINID").val();
			
			service["checkAdmin"] = param;
			
			doAction(service, 
					function(result) {
						var obj = result["checkAdmin"];
						
						if (eval(obj["COUNT"]) > 0) {
							openDialog("checkAlertDialog", null, null, "<spring:message code='CNFG_ADMN_ID_DES02' />");
						} else {
							openDialog("checkAlertDialog", null, null, "<spring:message code='CNFG_ADMN_ID_DES01' />");
							$("#CHECKID").val("1");
						}
					},
					function(jqXHR, textStatus, errorThrown) {
						alert("error Callback : " + jqXHR + " / " + textStatus + " / " + errorThrown); 
					}
				);
		}
		else {
			openDialog("checkAlertDialog", null, null, "<spring:message code='ADMN_LOGIN_ERR_DES04' />");
		}
	}
	
	// 추가
	function addAction() {
		var ids = $("#grid").jqGrid('getDataIDs');
		if (ids.length > 9){
			openDialog("checkAlertDialog", null, null, "<spring:message code='CNFG_ADMN_ADD_DES03' />");
		}
		else{
			var action = {
				"<spring:message code='COM_BTN_OK' />" : function() {
					// 필수 항목 체크
					if(validation("adminInsertDialog")) {
						if ($("#CHECKID").val() == "0") {
							openDialog("checkAlertDialog", null, null, "<spring:message code='CNFG_ADMN_ID_DES03' />");
							return;
						}
						
						if ($("#IN_PW").val() != $("#IN_PW_VERIFY").val()) {
							openDialog("checkAlertDialog", null, null, "<spring:message code='CNFG_ADMN_PW_DES01' />");
							$("#IN_PW").focus();
							return;
						}
							
						var service = new Object();
						var param = new Object();
						
						
						param["ACTION"] = "insert.admin";
						param["ADMINID"] = $("#IN_ADMINID").val();
						param["PW"] = MD5($("#IN_PW").val());
						param["NAME"] = $("#IN_NAME").val();
						param["PHONE"] = $("#IN_PHONE").val();
						param["EMAIL"] = $("#IN_EMAIL").val();
						param["STARTIP"] = $("#IN_STARTIP").val();
						param["ENDIP"] = $("#IN_ENDIP").val();
						param["DESCRIPTION"] = $("#IN_DESCRIPTION").val();
	
	
						service["adminInsert"] = param;
						doAction(service, function(result) {
							$("#grid").trigger("reloadGrid");
						});
						$(this).dialog("close");
					}
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					$(this).dialog("close");
				}
			};
			
			$(".ui-state-error").html('<spring:message code="DVIC_ADMN_ADD_DES01" />');
			openDialog("adminInsertDialog", action, 500, null, "<spring:message code='CNFG_ADMN_ADD_TTL01' />");
		}
	}
		
	function deleteAction(adminId) {
		var action = {
				"<spring:message code='COM_BTN_YES' />" : function() {
					
				var service = new Object();
				var param = new Object();
				
				param["ACTION"] = "delete.admin";
				param["ADMINID"] = adminId;

				service["adminDelete"] = param;
				doAction(service, function(result) {
					$("#grid").trigger("reloadGrid");
				});
				$(this).dialog("close");
				
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};
			
		openDialog("deleteAdminDialog", action, 300);
	}

	function unlockAction(adminId){
		//alert(adminId);
		var action = {
				"<spring:message code='COM_BTN_YES' />" : function() {
					
				var service = new Object();
				var param = new Object();
				
				param["ACTION"] = "update.unlockadmin";
				param["ADMINID"] = adminId;

				service["adminUpdate"] = param;
				doAction(service, function(result) {
					$("#grid").trigger("reloadGrid");
				});

				$(this).dialog("close");
				
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};
			
		openDialog("unlockAdminDialog", action, 300, null, "<spring:message code='CNFG_ADMN_TTL02' />");
	}	
</script>
<h2 class="h2_title04"><spring:message code="CNFG_ADMN_TTL01" /></h2>  
<div class="option_table_wrap">
</div>
<div class="report_table_wrap">
	<div class="hd">
		<!-- <p class="data_count" id="gridTotalCnt"></p> -->
		<div class="oBtn" id="addBtn" style="display:none;">
			<span class="buttonS"><a href="javascript:addAction();"><spring:message code='COM_BTN_ADD' /></a></span>								
		</div>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<!-- <div id="pager"></div> -->
		</div>
	</div>
</div>


<div id="deleteAdminDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code='PLCY_GRUP_DEL_DES01' /></p>
	</li>
	</ul>
</div>

<div id="unlockAdminDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code='CNFG_ADMN_DES01' /></p>
	</li>
	</ul>	
</div>

<!-- 관리자 추가 다이얼로그 -->
<div id="adminInsertDialog" title="<spring:message code="CNFG_ADMN_ADD_TTL01" />" style="display:none;height: auto;" >
	<div id="editcntgrid" class="admin_modify">
	<table id="TblGrid_grid" class="EditTable" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<!-- 에러 화면 -->
			<tr id="FormError">
				<th class="ui-state-error" style="text-align: left;" colspan="2"><spring:message code="DVIC_ADMN_ADD_DES01" /></th>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD" height="30px"><spring:message code="ADMN_INFO_EDIT_TXT01" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content reqID engNumForm"  style=" width: 132px" type="text" name="IN_ADMINID" id="IN_ADMINID" maxlength="32"  onChange="resetCheckAction()" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"></td>
				<td class="DataTD">
					&nbsp;<span class="buttonS"><a href="javascript:checkAction();"><spring:message code="CNFG_ADMN_ADD_BTN01" /></a></span>
					<input type="hidden" name="CHECKID" id="CHECKID" value="0" />
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT02" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content reqPW engNumCharForm" type="password" name="IN_PW" id="IN_PW" maxlength="32" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="CNFG_ADMN_ID_TXT01" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content reqPW engNumCharForm" type="password" name="IN_PW_VERIFY" id="IN_PW_VERIFY" maxlength="32" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT03" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content required" type="text" name="IN_NAME" id="IN_NAME" maxlength="12" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT04" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content required adminPhoneForm" type="text" name="IN_PHONE" id="IN_PHONE" maxlength="17" onKeyPress="return numbersonly(event, false)" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT05" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content required emailForm" type="text" name="IN_EMAIL" id="IN_EMAIL" maxlength="100" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT06" /></td>
				<td class="DataTD">
					<div class="ct">
					<input class="entry FormElement ui-widget-content ipAddressForm reqIP" type="text" name="IN_STARTIP" id="IN_STARTIP" maxlength="39" />
					<spring:message code="ADMN_INFO_EDIT_TXT07" />
					<input class="entry FormElement ui-widget-content ipAddressForm reqIP" type="text" name="IN_ENDIP" id="IN_ENDIP" maxlength="39" />
					<strong style="color: #de4444;">(*)</strong>
					</div>
				</td>
			</tr>
			<tr height="30px">
				<td class="CaptionTD" ></td>
				<td class="DataTD" style="padding-left: 6px">
					<spring:message code="CNFG_ADMN_ADD_DES02" htmlEscape="false" />
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="CNFG_ADMN_LST06" /></td>
				<td class="DataTD">
					<input class="entry FormElement ui-widget-content" type="text" name="IN_DESCRIPTION" id="IN_DESCRIPTION" maxlength="30" />
				</td>
			</tr>
		</tbody>
	</table>
	</div>
</div>
