<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		init(initBadCode);
	});
	function initBadCode() {
		$("#dashboard > a").addClass("on");
		//var viewType = '${VIEWTYPE}';
		//var viewTypeName = getViewTypeName(viewType);
		//$("#title").html('<spring:message code="MNTR_MAL_LNK_TXT01" />');
		$("#title").html("<a href='javascript:history.back()'>"+ '<spring:message code="MNTR_MNU07" />'+"</a> >" + '<spring:message code="MNTR_MAL_LNK_TXT01" />');
		// 그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.badCode',
			mtype: 'POST',
			datatype: 'json',
				colNames:['<spring:message code="MNTR_MAL_LNK_LST01" />',
				          '<spring:message code="MNTR_MAL_LNK_LST02" />',
				          '<spring:message code="MNTR_MAL_LNK_LST03" />',
				          ''],
				colModel:[
					{title:false, name:'RNUM',index:'RNUM', align:"center", sortable:false},
					{title:false, name:'MAL_NAME',index:'MAL_NAME', align:"left", width:660, sortable:false},
					{title:false, name:'MAL_COUNT',index:'MAL_COUNT', align:"center", sortable:false},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'MAL_COUNT', sortorder: "desc", rowNum:25, pager: '#pager', height: '100%',
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'MAL_NAME', '', {'text-align':'left'});
			},
			gridComplete: function() {
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
<h2 class="h2_title02" id="title"></h2>
<div class="report_table_wrap">
	<p class="data_count" id="gridTotalCnt"></p>

	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>