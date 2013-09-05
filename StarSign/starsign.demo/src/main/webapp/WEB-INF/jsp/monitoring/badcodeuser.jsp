<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		init(initBadCodeUser);
	});
	function initBadCodeUser() {
		$("#dashboard > a").addClass("on");
		var viewType = '${VIEWTYPE}';
		var viewTypeName = getViewTypeName(viewType);
		$("#title").html("<a href='javascript:history.back()'>" + "현황판" + "</a> > " + viewTypeName + " 단말기별 악성 코드 감염 현황");
		// 그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.badCodeUser&VIEWTYPE=' + viewType,
			mtype: 'POST',
			datatype: 'json',
				colNames:['순위',
				          '이름',
				          '전화번호/MAC 주소',
				          '감염수',
				          '치료수',
				          '미치료수',
				          '', '', '', '', ''],
				colModel:[
					{title:false, name:'RNUM',index:'RNUM', align:"center", sortable:false},
					{title:false, name:'EMPLOYEENAME',index:'EMPLOYEENAME', align:"center", sortable:false},
					{title:false, name:'PHONE',index:'PHONE', align:"center", sortable:false},
					{title:false, name:'INFECTED_COUNT',index:'INFECTED_COUNT', align:"center", sortable:false},
					{title:false, name:'CURED_COUNT',index:'CURED_COUNT', align:"center", sortable:false},
					{title:false, name:'UNCURED_COUNT',index:'UNCURED_COUNT', align:"center", sortable:false},
					{title:false, name:'DEVICEID',index:'DEVICEID', hidden:true},
					{title:false, name:'WIFILISTINFOID',index:'WIFILISTINFOID', hidden:true},
					{title:false, name:'RESETSTATUS',index:'RESETSTATUS', hidden:true},
					{title:false, name:'CONTROLSTATUS',index:'CONTROLSTATUS', hidden:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'INFECTED_COUNT', sortorder: "desc", rowNum:25, pager: '#pager', height: '100%',
			gridComplete: function() {
				// 이름 클릭하면 팝업 레이어 띄우게 하고
				// 미치료 입력
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];

					var ref = $("#grid").jqGrid('getRowData', cl);					
					var nameLink = "<a href='javascript:openDetailDevice(\"" + ref.DEVICEID + "\",  \"" + ref.WIFILISTINFOID + "\", \"" + ref.RESETSTATUS + "\", \"" + ref.CONTROLSTATUS + "\");'>" + ref.EMPLOYEENAME + "</a>";
					$("#grid").jqGrid('setRowData', cl, {"EMPLOYEENAME" : nameLink});
					$("#grid").jqGrid('setRowData', cl, {"UNCURED_COUNT" : parseInt(ref.INFECTED_COUNT) - parseInt(ref.CURED_COUNT)});
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