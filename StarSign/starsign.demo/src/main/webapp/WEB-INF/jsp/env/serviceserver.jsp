<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var service = {};
	$(document).ready(function() {
		init(initServiceServer);
	});
	function initServiceServer() {
		// 그리드 생성
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.serviceServerGrid',
			datatype: 'json',
			mtype: 'POST',
				colNames:['<spring:message code="CNFG_SVR_LST01" />', '<spring:message code="CNFG_SVR_LST02" />', '<spring:message code="CNFG_SVR_LST03" />', '', '', ''],
				colModel:[
					{title:false, name:'IP',index:'IP', width:300, align:"center"},
					{title:false, name:'PORT',index:'PORT', width:190, align:"center"},
					{title:false, name:'STATUS_RADIO',index:'STATUS_RADIO', sortable:false, width:285, align:"center"},
					{title:false, name:'STATUS', hidden:true},
					{title:false, name:'SERVICESERVERID',index:'SERVICESERVERID', key:true, hidden:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'IP', sortorder: "asc", rowNum:25, pager: '#pager', multiselect: true, height:'100%', width:800,
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			gridComplete: function() { 
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){
					var cl = ids[i];
					var ret = jQuery("#grid").jqGrid('getRowData', cl);
					if(ret.STATUS == "Y") {
						b = "<input type='radio' name='STATUS" + cl + "' class='radioParam' value='N' onclick='statusChange(\"" + cl + "\", \"N\");' /><spring:message code='CNFG_SVR_RDO01' />&nbsp;"; 
						e = "<input type='radio' name='STATUS" + cl + "' class='radioParam' value='Y' checked='checked' onclick='statusChange(\"" + cl + "\", \"Y\");' /><spring:message code='CNFG_SVR_RDO02' />";
					}
					else {
						b = "<input type='radio' name='STATUS" + cl + "' class='radioParam' value='N' checked='checked' onclick='statusChange(\"" + cl + "\", \"N\");' /><spring:message code='CNFG_SVR_RDO01' />&nbsp;"; 
						e = "<input type='radio' name='STATUS" + cl + "' class='radioParam' value='Y' onclick='statusChange(\"" + cl + "\", \"Y\");' /><spring:message code='CNFG_SVR_RDO02' />";
					}
					$("#grid").jqGrid('setRowData', cl, {"STATUS_RADIO":b+e});
				}
				initGridUI("grid");
			}
		});
	}
	// 변경사항 쌓아놓기
	function statusChange(id, value) {
		var param = {};
		param["ACTION"] = "update.serviceServer";
		param["SERVICESERVERID"] = id;
		param["STATUS"] = value;
		service["statusChange" + id] = param; 
	}
	// 상태 업데이트
	function updateAction() {
		var action = {
			"<spring:message code='COM_BTN_YES' />" : function() {
				doAction(service, function(result) {
					// 초기화
					service = {};
				});
				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};
		openDialog("updateDialog", action, 300);
	}
	// 삭제
	function deleteAction() {
		var s = $("#grid").jqGrid('getGridParam','selarrrow');

		if(s.length == 0) {
			openDialog("checkAlertDialog", null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));			
			return;
		}
		
		var action = {
			"<spring:message code='COM_BTN_YES' />" : function() {
				var service = {};
				var param = {};
				//param["ACTION"] = "delete.serviceServer";
				param["ACTION"] = "deleteServiceServer.serviceServer";
		
				var idList = new Array();
				
				for(var i=0 ; i < s.length ; i++) {
					var ret = jQuery("#grid").jqGrid('getRowData', s[i]);
					idList.push(ret.SERVICESERVERID);
		 		}
								
		 		param["SERVICESERVERIDLIST"] = idList;
		 		
				service["serviceServer"] = param;
				doAction(service, function(result) {
					// 초기화
					service = {};
					$("#grid").trigger("reloadGrid");
				});
				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		};
		
		openDialog("deleteServiceDialog", action, 300);
	}
</script>
<h2 class="h2_title04"><spring:message code="CNFG_SVR_TTL01" /></h2>  
<div class="option_table_wrap">
</div>
<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="gridTotalCnt"></p>
		<div class="oBtn">
			<span class="buttonS"><a href="javascript:deleteAction();"><spring:message code='COM_BTN_DELETE' /></a></span>								
		</div>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>

<div class="entry_query_wrap">
	<div class="btn">
		<span class="buttonLg"><a href="javascript:updateAction();"><spring:message code="COM_BTN_APPLY" /></a></span>
	</div>
</div>


<div id="deleteServiceDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code='PLCY_GRUP_DEL_DES01' /></p>
	</li>
	</ul>
</div>