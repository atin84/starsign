<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<fmt:bundle basename="com.anlab.v3me.admin.config.i18n.resourceMessage">
<script type="text/javascript">
	
	//왼쪽에서 선택한 WifiListInfoId
	var selwifiListInfoId;
	
	$(document).ready(function() {
		$("#fnBtn").hide();
	});
	
	function getWifiInfoList(wifiListInfoId, wifiListInfoName) {
		
		selwifiListInfoId = wifiListInfoId;
		if(wifiListInfoId == 0) {
			wifiListInfoId = '';
			$("#fnBtn").hide();
		}
		else 
			$("#fnBtn").show();
		
		//$("#wifiListTitle").html(wifiListInfoName + '');
		$("#wifiListTitle").html(wifiListInfoName);
		
		
		$("#jqgrid").html('<table id="grid"></table><div id="pager"></div>');

		$("#grid").jqGrid({
			url: gridPath + 'listGrid.wifiInfo' + '&WIFILISTINFOID=' + wifiListInfoId,
			editurl : gridEditPath + 'wifiInfo.do',
			datatype: 'json',
				colNames:['WIFIID',
				          '<spring:message code="DVIC_INFO_WIFI_LST01" />',
				          '<spring:message code="DVIC_INFO_WIFI_LST02" />',
				          '<spring:message code="DVIC_INFO_WIFI_LST03" />',
				          '', ''],
				colModel:[
					{title:false, name:'WIFIINFOID',	index:'WIFIINFOID', 	key:true, editable:false, hidden:true, width: 150},
					{title:false, name:'WIFIINFONAME',	index:'WIFIINFONAME', 	editable:true, width: 210},
					{title:false, name:'SSID',			index:'SSID', 			editable:true, width: 210},
					{title:false, name:'MAC',			index:'MAC', 			editable:true, width: 230},
					{title:false, name:'ACTION',		index:'ACTION', 		sortable:false, width:88, align:"center"},
					{title:false, name:'TOTALCNT',		index:'TOTALCNT', 		hidden:true},
				],
			sortname: 'WIFIINFONAME', sortorder: "asc", rowNum:25, height:"100%", width:738, scrollOffset:0, 
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'WIFIINFONAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'SSID', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'MAC', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				initGridUI("grid");
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var imgModify = "<img src=\"<c:url value='/resources/image/bt_modify.gif' />\" />";
					//var ed = "<a href='javascript:editAction(\"" + cl + "\");' class='md'>" + 수정 + "</a> ";
					var ed = "<a href='javascript:editAction(\"" + cl + "\");' class='md'>" + imgModify + "</a> ";
					$("#grid").jqGrid('setRowData', ids[i], {"ACTION":ed});
				}
			},
			pager: '#pager',
			multiselect: true,
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell",
				id: "WIFIINFOID"
			}
		});
	}
	
	
	function addAction() {
		// 선택한 WIFI 그룹과 매핑 과정이 필요함
		// T_WIFIListMapper 테이블 Insert 과정도 넣어야 함

		$("#txWifiInfoName").attr("value", "");
		$("#txSSID").attr("value", "");
		$("#txMAC").attr("value", "");
		
		$(".ui-state-error").html('<spring:message code="DVIC_ADMN_ADD_DES01" />');
		openDialog("addWifiInfoDialog", getAddWifiInfoButtonAction(), 300, null, '<spring:message code="NTWK_WIFI_ADD_TTL01" />');
	}
	function moveAction() {
		var selRowData = $("#grid").jqGrid('getGridParam','selarrrow');
		
		if(selRowData.length > 0) {
			// 일단 먼저 콤보 비우기
			$("#moveCombo").html("");
			// 콤보 채워넣기
			var service = {};
			var data = {};
			data["ACTION"] = "list.wifiListInfoCombo";
			service["moveCombo"] = data;
			addOption(service, false);
			
			$( "#moveWifiInfoDialog" ).dialog({
				closeOnEscape: false, 
				autoOpen: false,
				resizable : false,
				width : 400,
				modal: true,
				title: '<spring:message code="NTWK_WIFI_MOVE_TTL01" />',
				buttons: {
					"<spring:message code='COM_BTN_OK' />" : function() {
						var selCombo = $("#moveCombo").val();
						
						if(selCombo != '') {
							var service = {};
							var data = {};
							var wifiInfoIdList = new Array();
							
							for(var i=0 ; i < selRowData.length ; i++) {
								var ret = jQuery("#grid").jqGrid('getRowData', selRowData[i]);
								if(ret.WIFIINFOID) {
									wifiInfoIdList.push(ret.WIFIINFOID);
								}
					 		}
							// 1. 선택된 WIFI를 T_WIFILISTMAPPER에서 삭제
							// 2. 선택된 WIFI를 다른 T_WIFILISTMAPPER에 Insert
							data["ACTION"] = "moveWifiInfo.wifiListMapper";
							data["DEL_WIFILISTINFOID"] = selwifiListInfoId;
							data["ADD_WIFILISTINFOID"] = selCombo;
							data["WIFIINFOIDLIST"] = wifiInfoIdList;

							service["wifiInfoMove"] = data;
							
							if(wifiInfoIdList.length != 0) {
								doAction(service, function(result) {
									refreshGrid();
								});
							}
							else {
								openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
							}

							$(this).dialog("close");	
						}
						else {
							openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
						}
					},
					"<spring:message code='COM_BTN_CANCEL' />" : function() {
						$(this).dialog("close");
					}
				},
				close: function (event, ui) {
	                $(this).dialog('destroy');
	            } 
			});
			
			
			$( "#moveWifiInfoDialog" ).dialog("open");
		}
		else {
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
		}
	}
	function copyAction() {
		var selRowData = $("#grid").jqGrid('getGridParam','selarrrow');
		
		if(selRowData.length > 0) {
			// 일단 먼저 콤보 비우기
			$("#copyCombo").html("");
			// 콤보 채워넣기
			var comboService = {};
			var comboData = {};
			comboData["ACTION"] = "list.wifiListInfoCombo";
			comboService["copyCombo"] = comboData;
			addOption(comboService, false);
			
			$( "#copyWifiInfoDialog" ).dialog({
				closeOnEscape: false, 
				autoOpen: false,
				resizable : false,
				width : 400,
				modal: true,
				title: '<spring:message code="NTWK_WIFI_COPY_TTL01" />',
				buttons: {
					"<spring:message code='COM_BTN_OK' />" : function() {
						var selCombo = $("#copyCombo").val();
						
						if(selCombo != '') {
							var service = {};
							var data = {};
							var wifiInfoIdList = new Array();
							
							for(var i=0 ; i < selRowData.length ; i++) {
								var ret = jQuery("#grid").jqGrid('getRowData', selRowData[i]);
								if(ret.WIFIINFOID) {
									wifiInfoIdList.push(ret.WIFIINFOID);
								}
					 		}
							
							// 0. 선택된 WIFI가 T_WIFILISTMAPPER에 이미 존재 하는지 체크하여
							// 존재하지 않는 WifiInfo만 List에 넣음
							// 1. 선택된 WIFI를 T_WIFILISTMAPPER에 Insert
							data["ACTION"] = "copyWifiInfo.wifiListMapper";
							
							data["WIFILISTINFOID"] = selCombo;
							data["WIFIINFOIDLIST"] = wifiInfoIdList;
	
							service["wifiInfoCopy"] = data;
							
							if(wifiInfoIdList.length != 0) {
								doAction(service, function(result) {
									//refreshGrid();
								});
							}
							
							$(this).dialog("close");
						}
						else {
							openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
						}
					},
					"<spring:message code='COM_BTN_CANCEL' />" : function() {
						$(this).dialog("close");
					}
				},
				close: function (event, ui) {
	                $(this).dialog('destroy');
	            } 
			});
			
			$( "#copyWifiInfoDialog" ).dialog("open");
		}
		else {
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
		}
	}
	function deleteAction() {
		var s = $("#grid").jqGrid('getGridParam','selarrrow');
		if(s.length > 0) {
			openDialog("deleteWifiInfoDialog", getDeleteWifiInfoButtonAction());	
		}
		else {
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
		}
	}
	function editAction(id) {
		if( id != null ) { 
			var rowData = jQuery("#grid").jqGrid('getRowData', id);
			$("#editWifiInfoName").attr("value", rowData.WIFIINFONAME);
			$("#editSSID").attr("value", rowData.SSID);
			$("#editMAC").attr("value", rowData.MAC);
			
			$(".ui-state-error").html('<spring:message code="DVIC_ADMN_ADD_DES01" />');
			openDialog("editWifiInfoDialog", getEditWifiInfoButtonAction(id), 300, null, '<spring:message code="NTWK_WIFI_MODIFY_TTL01" />');
		}
		else 
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
	}
	
	function refreshGrid() {
		//$("#jqgrid").html('<table id="grid"></table><div id="pager"></div>');
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.wifiInfo' + '&WIFILISTINFOID=' + selwifiListInfoId,
			page:1, rows:25
		}).trigger("reloadGrid");
	}
	function getAddWifiInfoButtonAction() {
		 var button = {
				 "<spring:message code='COM_BTN_OK' />" : function() {
					if(validation("addWifiInfoDialog")) {
						var service = {};
						var data = {};
						
						data["WIFILISTINFOID"] = selwifiListInfoId;
						data["WIFIINFONAME"] = $("#txWifiInfoName").val();
						data["SSID"] = $("#txSSID").val();
						data["MAC"] = $("#txMAC").val();
						
						data["ACTION"] = "insertWifiInfo.wifiListMapper";
	
						service["wifiInfoInsert"] = data;
						
						doAction(service, function(result) {
							var objList = result["wifiInfoInsert"];
							$.each(objList, function(i, obj) {
								if(obj["result"] == "alreay_exist") {
									openDialog("checkAlertDialog", null, null, "<spring:message code='NTWK_WIFI_ADD_DES01' />");
								}
							});
							
							refreshGrid();
						});
						
						$(this).dialog("close");
					}
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					$(this).dialog("close");
				}
			 };

		return button;
	}
	function getDeleteWifiInfoButtonAction() {
		 var button = {
		"<spring:message code='COM_BTN_YES' />" : function() {
				var service = {};
				var data = {};
				var wifiInfoIdList = new Array();
				
				var s = $("#grid").jqGrid('getGridParam','selarrrow');
				for(var i=0 ; i < s.length ; i++) {
					var ret = jQuery("#grid").jqGrid('getRowData', s[i]);
					if(ret.WIFIINFOID) {
						wifiInfoIdList.push(ret.WIFIINFOID);
					}
				}
					
				// 1. T_WIFILISTMAPPER에서 삭제
				// 2. T_WIFIINFO에서 삭제
				data["ACTION"] = "deleteWifiInfo.wifiListMapper";
				data["WIFIINFOIDLIST"] = wifiInfoIdList;
				data["WIFILISTINFOID"] = selwifiListInfoId;

				service["wifiInfoDelete"] = data;
					
				if(wifiInfoIdList.length != 0) {
					doAction(service, function(result) {
						
						refreshGrid();
					});
				}
				else {
					openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
				}
				
				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		 };

		return button;
	}
	function getEditWifiInfoButtonAction(id) {
		 var button = {
				 "<spring:message code='COM_BTN_OK' />" : function() {
					if(validation("editWifiInfoDialog")) {
						var service = {};
						var data = {};
						
						// 1. T_WIFIINFO에서 수정
						// 2. 수정된 WifiInfoId가 속한 그룹을 업데이트
						data["WIFIINFOID"] = id;
						data["WIFIINFONAME"] = $("#editWifiInfoName").val();
						data["SSID"] = $("#editSSID").val();
						data["MAC"] = $("#editMAC").val();
						
						//alert($("#editWifiInfoName").val() + $("#editSSID").val() + $("#editMAC").val());
						
						data["ACTION"] = "editWifiInfo.wifiInfo";		
	
						service["wifiInfoUpdate"] = data;
						
						doAction(service, function(result) {
							var objList = result["wifiInfoUpdate"];
							$.each(objList, function(i, obj) {
								if(obj["result"] == "alreay_exist") {
									openDialog("checkAlertDialog", null, null, "<spring:message code='NTWK_WIFI_ADD_DES01' />");
								}
							});
							
							refreshGrid();
						});
						
						$(this).dialog("close");
					}
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					$(this).dialog("close");
				}
			 };

		return button;
	}
</script>

<h2 class="h2_title03" id=wifiListTitle></h2>
				
<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="gridTotalCnt"></p>
		<div class="oBtn" id="fnBtn">
			<span class="buttonS"><a href="javascript:addAction()" id="export"><spring:message code='COM_BTN_ADD' /></a></span>
			<span class="buttonS"><a href="javascript:moveAction()" id="import"><spring:message code='NTWK_GRUP_SEL_BTN01' /></a></span>
			<span class="buttonS"><a href="javascript:copyAction()" id="export"><spring:message code='NTWK_GRUP_SEL_BTN02' /></a></span>
			<span class="buttonS"><a href="javascript:deleteAction()" id="import"><spring:message code='COM_BTN_DELETE' /></a></span>									
		</div>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>

<!-- WIFI 추가 다이얼로그 -->
<div id="addWifiInfoDialog" title="Wifi 추가" style="display:none;height:auto;">
	<div id="editcntgrid" class="ui-jqdialog-content">
		<table id="addWifiTB" class="EditTable" border="0" cellpadding="0" cellspacing="0">
		  <tbody>
			<!-- 에러 화면 -->
			<tr id="FormError">
				<td class="ui-state-error" colspan="2"><spring:message code="DVIC_ADMN_ADD_DES01" /></td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_INFO_WIFI_LST01" /></td>
				<td class="DataTD">
					&nbsp;
					<input class="FormElement ui-widget-content required" type="text" id="txWifiInfoName" size="12" maxlength="12" value="" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData">
			    <td class="CaptionTD"><spring:message code="DVIC_INFO_WIFI_LST02" /></td>
			    <td class="DataTD">
			    	&nbsp;
			    	<input class="FormElement ui-widget-content required" type="text" id="txSSID" size="20" maxlength="20" value="" />
			    	<strong style="color: #de4444;">(*)</strong>
			    </td>
			</tr>
			<tr class="FormData">
			    <td class="CaptionTD"><spring:message code="DVIC_INFO_WIFI_LST03" /></td>
			    <td class="DataTD">
			    	&nbsp;
			    	<input class="FormElement ui-widget-content required macForm" type="text" id="txMAC" size="17" maxlength="17" value="" />
			    	<strong style="color: #de4444;">(*)</strong>
			    </td>
			</tr>
		  </tbody>
		</table>
	</div>
</div>

<!-- WIFI 수정 다이얼로그 -->
<div id="editWifiInfoDialog" title="Wifi 수정" style="display:none;height:auto;">
	<div id="editcntgrid" class="ui-jqdialog-content">
		<table id="editWifiTB" class="EditTable" border="0" cellpadding="0" cellspacing="0">
			<tbody>
				<!-- 에러 화면 -->
				<tr id="FormError">
					<td class="ui-state-error" colspan="2"><spring:message code="DVIC_ADMN_ADD_DES01" /></td>
				</tr>
				<tr  class="FormData">
				    <td class="CaptionTD"><spring:message code="DVIC_INFO_WIFI_LST01" /></td>
				    <td class="DataTD">
				    &nbsp;<input class="FormElement ui-widget-content" type="text" id="editWifiInfoName" size="12" maxlength="12" value="" disabled />
				    </td>
				</tr>
				<tr class="FormData">
				    <td class="CaptionTD"><spring:message code="DVIC_INFO_WIFI_LST02" /></td>
				    <td class="DataTD">
				    &nbsp;<input class="FormElement ui-widget-content required" type="text" id="editSSID" size="20" maxlength="20" value="" />
				    <strong style="color: #de4444;">(*)</strong>
				    </td>
				</tr>
				<tr class="FormData">
				    <td class="CaptionTD"><spring:message code="DVIC_INFO_WIFI_LST03" /></td>
				    <td class="DataTD">
				    &nbsp;<input class="FormElement ui-widget-content required macForm" type="text" id="editMAC" size="17" maxlength="17" value="" />
				    <strong style="color: #de4444;">(*)</strong>
				    </td>
				</tr>
		   </tbody>
		</table>
	</div>
</div>

<!-- WIFI 삭제 다이얼로그 -->
<div id="deleteWifiInfoDialog" title="Wifi 삭제" style="display:none">
	<ul>
	<li class="ico_alert"><p><spring:message code='PLCY_GRUP_DEL_DES01' /></p></li>
	</ul>
</div>

<!-- WIFI 이동 다이얼로그 -->
<div id="moveWifiInfoDialog" title="Wifi 이동" style="display:none">
	<select id="moveCombo">
	</select>
</div>

<!-- WIFI 복사 다이얼로그 -->
<div id="copyWifiInfoDialog" title="Wifi 복사" style="display:none">
	<select id="copyCombo">
	</select>
</div>

</fmt:bundle>