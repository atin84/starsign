<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">

	$(document).ready(function() {
		init(initPolicyApply);
	});
	function initPolicyApply() {
		//$("#dashboard > a").addClass("on");
		//$("#title").html('');
		// 그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.policyApply',
			mtype: 'POST',
			datatype: 'json',
				colNames:[
				          '<spring:message code="DVIC_SEL_NONE_LST07" />',
				          '<spring:message code="DVIC_SEL_NONE_LST06" />',
				          '<spring:message code="MNTR_PLCY_LST03" />',
				          '<spring:message code="MNTR_PLCY_LST04" />',
				          '<spring:message code="MNTR_PLCY_LST05" />',
				          ''],
				colModel:[
					{title:false, name:'GROUPNAME',index:'GROUPNAME', align:"left", width:300},
					{title:false, name:'POLICYNAME',index:'POLICYNAME', align:"left", width:300},
					{title:false, name:'DEVICECOUNT_Y',index:'DEVICECOUNT_Y', align:"center", width:110},
					{title:false, name:'DEVICECOUNT_N',index:'DEVICECOUNT_N', align:"center", width:109},
					//{title:false, name:'POLYCY_PERCENT',index:'POLYCY_PERCENT', align:"center", width:159, sortable:false},
					{title:false, name:'APPLY_PERCENT',index:'APPLY_PERCENT', align:"center", width:159},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'GROUPNAME', sortorder: "asc", rowNum:25, pager: '#pager', height: '100%', width:978, 
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'GROUPNAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'POLICYNAME', '', {'text-align':'left'});
			},
			gridComplete: function() {
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var ref = $("#grid").jqGrid('getRowData', cl);
					
					
					// 정책 적용율 구하기
					/*
					var percent = 0;
					var applyYCnt = parseInt(ref.DEVICECOUNT_Y);
					var applyNCnt = parseInt(ref.DEVICECOUNT_N);
					if(applyYCnt > 0) {
						percent = (applyYCnt / (applyYCnt + applyNCnt)) * 100;	
					}
					else {
						percent = 0;
					}
					
					$("#grid").jqGrid('setRowData', cl, {"POLYCY_PERCENT" : percent.toFixed(1) + "%"});
					*/
					
					// 퍼센트 붙이기
					$("#grid").jqGrid('setRowData', cl, {"APPLY_PERCENT" : ref.APPLY_PERCENT + "%"});
				}
				// 색상 변경
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
</script>

<!-- <h2 class="h2_title02" id="title"></h2> -->
<div class="report_table_wrap">
	<p class="data_count" id="gridTotalCnt"></p>

	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>