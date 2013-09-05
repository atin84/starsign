<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var service = {};
	$(document).ready(function() {
		init(initCode);
	});
	function initCode() {
		// 그리드 생성
		$("#modelgrid").jqGrid({
			url: gridPath + 'listGrid.modelGrid',
			datatype: 'json',
			mtype: 'POST',
				colNames:['<spring:message code="CNFG_ALIAS_LST01" />', '<spring:message code="CNFG_ALIAS_LST02" />', '', ''],
				colModel:[
					{title:false, name:'MODELID',index:'MODELID', key: true, sortable:false, width:395},
					{
						title:false, 
						name:'MODELNAME',
						index:'MODELNAME',
						sortable: false,
						editable: true,
						editoptions:{maxlength:12},
						width:395
					},
					{title:false, name:'MANUFACTURERID',index:'MANUFACTURERID', hidden: true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden: true}
				],
			sortname: 'MODELID', sortorder: "asc", height: "100%", scrollOffset:0, viewrecords:true,
			emptyrecords: "<spring:message code='COM_LST_DES01' />",
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			loadComplete: function() {
				//$('.ui-jqgrid-hdiv').hide();
				//ui-jqgrid-bdiv overflow-x : hidden !important;
				//$(".ui-jqgrid-bdiv").css("overflow-x", "hidden");
				//$(".ui-jqgrid-bdiv").hide();
				//alert($(".ui-jqgrid-bdiv").html());
			},
			gridComplete: function() { 
				var ids = $("#modelgrid").jqGrid('getDataIDs');
				// 모든 row 에디트 모드로 전환
				for(var i=0 ; i<ids.length ; i++) {
					$('#modelgrid').jqGrid('editRow', ids[i]);
				}
				
				var ref = jQuery("#modelgrid").jqGrid('getRowData', ids[0]);
				
				initGridUI("modelgrid");
				
				$("tbody > tr.jqgrow > td > input", this).addClass("ipt01");
				// onchange 이벤트 걸기
				$("tbody > tr.jqgrow > td > input", this).change(function(e) {
					var id = $(this).attr('id').split('_')[0];
					var param = {};
					param["ACTION"] = "update.model";
					param["MODELID"] = id;
					param["MODELNAME"] = $(this).val();
					service["modelUpdate" + id] = param;
                });
			}
		});

		// 그리드 생성
		$("#manufacturergrid").jqGrid({
			url: gridPath + 'listGrid.manufacturerGrid',
			datatype: 'json',
			mtype: 'POST',
				colNames:['<spring:message code="CNFG_ALIAS_LST03" />', '<spring:message code="CNFG_ALIAS_LST02" />', ''],
				colModel:[
					{title:false, name:'MANUFACTURERID',index:'MANUFACTURERID', key: true, sortable:false, width:395},
					{
						title:false, 
						name:'MANUFACTURERNAME',
						index:'MANUFACTURERNAME',
						sortable: false,
						editable: true,
						editoptions:{maxlength:12},
						width:395
					},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden: true}
				],
			sortname: 'MANUFACTURERID', sortorder: "asc", height: "100%", scrollOffset:0, 
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			loadComplete: function() {
				//$('.ui-jqgrid-hdiv').hide();
				//ui-jqgrid-bdiv overflow-x : hidden !important;
				$(".ui-jqgrid-bdiv").css("overflow-x", "hidden !important");
				//alert($(".ui-jqgrid-bdiv").html());
			},
			gridComplete: function() { 
				var ids = $("#manufacturergrid").jqGrid('getDataIDs');
				for(var i=0 ; i<ids.length ; i++) {
					$('#manufacturergrid').jqGrid('editRow', ids[i]);
				}
				var ref = jQuery("#manufacturergrid").jqGrid('getRowData', ids[0]);
				
				initGridUI("manufacturergrid");

				$("tbody > tr.jqgrow > td > input", this).addClass("ipt01");
				// onchange 이벤트 걸기
				$("tbody > tr.jqgrow > td > input", this).change(function(e) {
					var id = $(this).attr('id').split('_')[0];
					var param = {};
					param["ACTION"] = "update.manufacturer";
					param["MANUFACTURERID"] = id;
					param["MANUFACTURERNAME"] = $(this).val();
					service["manufacturerUpdate" + id] = param;
                });
			}
		});
	}
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
</script>
<h2 class="h2_title04"><spring:message code='CNFG_ALIAS_TTL01' /></h2>  
<br />
<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="modelgridTotalCnt"></p>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="modelgrid"></table>
		</div>
	</div>
</div>

<div class="option_table_wrap">
</div>
<h2 class="h2_title04"><spring:message code='CNFG_ALIAS_TTL02' /></h2>  

<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="manufacturergridTotalCnt"></p>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="manufacturergrid"></table>
		</div>
	</div>
</div>

<div class="entry_query_wrap">
	<div class="btn">
		<span class="buttonLg"><a href="javascript:updateAction();"><spring:message code="COM_BTN_APPLY" /></a></span>
	</div>
</div>