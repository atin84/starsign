<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var isHide = false;
	var currentMsgId = null;
	
	$(document).ready(function() {
		init(initSendSucess);
	});
	
	
	/**
	 * 검색항목 보이기/숨기기
 	 */
 	function searchDivShow() {
 		isHide = true;
 		searchDivShowHide();
	}
 	function searchDivHide() {
 		isHide = false;
 		searchDivShowHide();
	}
 	function searchDivShowHide() {
 		if(isHide) {
			$("#searchDiv").show("blind");
			//isHide = false;
			$("#searchHideButton a").attr("href", 'javascript:searchDivHide();');
			$("#searchHideButton img").attr("src", '<c:url value="/resources/image/bul_close01.gif" />');
			//$("#searchHideButton img").attr("alt", '닫기');
		}
		else {
			$("#searchDiv").hide("blind");
			//isHide = true;
			$("#searchHideButton a").attr("href", 'javascript:searchDivShow();');
			$("#searchHideButton img").attr("src", '<c:url value="/resources/image/bul_open01.gif" />');
			//$("#searchHideButton img").attr("alt", '열기');
		}
	}
 	/* [2011/12/08] by galim12 */
 	function showSelectedSubList(subGridDivId, subGridId, rowId) {
 		var subGridTableId = subGridId + "_" + rowId;
 		var pagerId = subGridTableId + "paper";
 		var ref = $("#grid").jqGrid('getRowData', rowId);
 		var total = ref.TOTALCOUNT;
 		$("#"+subGridDivId).html("<spring:message code="LOGS_TXT01" arguments='"+total+"' /><table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
		$("#"+subGridTableId).jqGrid({ 
			url: gridPath + 'listGrid.sendSearch&MSGID=' + rowId,
			mtype: 'POST',
			datatype: 'json',
				colNames:[
				          '<spring:message code="LOGS_SUB_LST02" />',
				           '<spring:message code="LOGS_SUB_LST03" />',
				           '<spring:message code="LOGS_SUB_LST05" />',
				           '<spring:message code="LOGS_SUB_LST04" />',
				          ''
				          ],
				colModel:[
						{title:false, name:"PHONE", index:"PHONE", align:"left", width: 260},
						{title:false, name:"RECEIVETIME", index:"RECEIVETIME", align:"left", sortable:false, width: 260},
						{title:false, name:"NOTIFICATIONTYPE", index:"NOTIFICATIONTYPE", align:"left", sortable:false, width: 210},
						{title:false, name:"STATUS",index:"STATUS", align:"left", sortable:false, width: 220},
						{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			rowNum:25, sortname: 'RECEIVETIME', sortorder: "asc",  height: '100%', width:950, 
			pager: "#"+pagerId, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			subGrid: false,  height: '100%', width: 978, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#"+subGridTableId).jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'RECEIVETIME', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'NOTIFICATIONTYPE', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'STATUS', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				// 색상 변경
				$("#"+subGridTableId + " tr td").each(function(i, obj) {
					codeAlias(subGridTableId, $(obj).attr('aria-describedby'), obj);
				});

				initGridUI(subGridTableId);
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
	/**
	 * 통지 수신 결과 화면 만들기
	 */
	function initSendSucess() {
		/**
		 * 검색항목 보이기/숨기기
	 	 */
		searchDivShowHide();
		
		// 그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.sendSuccess',
			mtype: 'POST',
			datatype: 'json',
				colNames:['',
				          '<spring:message code="LOGS_LST04" />',
				          '<spring:message code="LOGS_LST03" />',
				          '<spring:message code="LOGS_LST09" />',
				          '<spring:message code="LOGS_LST05" />',
				          '<spring:message code="LOGS_LST06" />',
				          '<spring:message code="LOGS_LST07" />',
				          '<spring:message code="LOGS_LST08" />',
				          ''
				          ],
				colModel:[
					{title:false, name:'MSGID',index:'MSGID', align:"center", hidden:true, key:true},
					{title:false, name:'SENDTIME',index:'SENDTIME', align:"left", width:150},
					{title:false, name:'MSGCODE',index:'MSGCODE', align:"left", width:145},
					{title:false, name:'ADMINNAME',index:'ADMINNAME', align:"left", width:148},
					{title:false, name:'TOTALCOUNT',index:'TOTALCOUNT', align:"center", width:170},
					{title:false, name:'SUCCESSCOUNT',index:'SUCCESSCOUNT', align:"center", width:90},
					{title:false, name:'FAILCOUNT',index:'FAILCOUNT', align:"center", width:90},
					{title:false, name:'STATUS',index:'STATUS', align:"left", sortable:false, width:160},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'SENDTIME', sortorder: "desc", rowNum:25, pager: '#pager',
			subGrid: false,  height: '100%', width: 978, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				var boxImagePath = "${pageContext.request.contextPath}/resources/image/jquery/progressbar.gif";
				var barImagePath = "${pageContext.request.contextPath}/resources/image/jquery/progressbg_blue.gif";
				
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var pbId = "pb" + cl;
					var ed = "<div class=\"" + "progressbar\"" + " id=\"" + pbId + "\"></div>";
					$("#grid").jqGrid('setRowData', ids[i], {"STATUS":ed});
					
					var ret = jQuery("#grid").jqGrid('getRowData', cl);
					var sucessRate = 0;
					if(ret.SUCCESSCOUNT> 0 && ret.TOTALCOUNT > 0) {
						sucessRate = roundXL((ret.SUCCESSCOUNT/ret.TOTALCOUNT)*100, 0);
					}
					else 
						sucessRate = 0;
					
					$("#"+ pbId).progressBar(sucessRate, {steps:0, boxImage: boxImagePath, barImage: barImagePath});
				}
				
				$("#grid").jqGrid ('setLabel', 'SENDTIME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'MSGCODE', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'ADMINNAME', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				// 색상 변경
				$('#grid tr td').each(function(i, obj) {
					codeAlias("grid", $(obj).attr('aria-describedby'), obj);
				});

				initGridUI("grid");
			},
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			onSelectRow: function(id) {
				showSelectedSubList("sendedSubDialog", "subGridTable" ,id);
				openDialog("sendedSubDialog", null, 1000, null, "<spring:message code='LOGS_SUB_TTL01' />");
			}
		});
			 /*
			 서브 그리드 생성
			 [2011/12/08] by galim12
			 서브 목록은 새창으로 보여주기로 변경
			 */
			 /*
			subGridRowExpanded: function(subGridId, rowId) { 
				// subGrid ID 정의
				var subGridDivId = "jq" + subGridId;
				var subGridTableId = subGridId + "grid"; 
				var pagerId = subGridTableId + "pager";
				// 서브 그리드 HTML 생성
				//$("#"+subGridId).html("<p id='"+ subGridTableId +"TotalCnt'></p><table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
				$("#"+subGridId).html("<table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
				// 서브 그리드 생성 옵션 설정 
				$("#"+subGridTableId).jqGrid({ 
					url: gridPath + 'listGrid.sendSearch&MSGID=' + rowId,
					mtype: 'POST',
					datatype: 'json',
					colNames: ['<spring:message code="LOGS_SUB_LST02" />',
					           '<spring:message code="LOGS_SUB_LST03" />',
					           '<spring:message code="LOGS_SUB_LST05" />',
					           '<spring:message code="LOGS_SUB_LST04" />',
					           ''
					           ], 
					colModel: [ 
						{title:false, name:"PHONE", index:"PHONE", align:"left", width: 260},
						{title:false, name:"RECEIVETIME", index:"RECEIVETIME", align:"left", sortable:false, width: 260},
						{title:false, name:"NOTIFICATIONTYPE", index:"NOTIFICATIONTYPE", align:"left", sortable:false, width: 210},
						{title:false, name:"STATUS",index:"STATUS", align:"left", sortable:false, width: 220},
						{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
					], 
					rowNum:25, sortname: 'RECEIVETIME', sortorder: "asc",  height: '100%', width:950, 
					pager: "#"+pagerId, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
					// 일단 없는걸로 생각하고 시작하자 pager: "#" + pagerId 
					loadComplete: function() {
							$("#"+subGridTableId).jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
							$("#"+subGridTableId).jqGrid ('setLabel', 'RECEIVETIME', '', {'text-align':'left'});
							$("#"+subGridTableId).jqGrid ('setLabel', 'NOTIFICATIONTYPE', '', {'text-align':'left'});
							$("#"+subGridTableId).jqGrid ('setLabel', 'STATUS', '', {'text-align':'left'});
					},
					gridComplete: function() { 
						// 색상 변경
						$('#grid tr td').each(function(i, obj) {
							codeAlias(subGridTableId, $(obj).attr('aria-describedby'), obj);
						});
						initGridUI(subGridTableId);
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
		});
		*/
		// 검색 조건 리셋
		$("#resetButton").click(function() {
			resetSearchData($("#searchDiv div ul li :input"));
		});
		// 검색 하기
		$("#searchButton").click(function() {
			//검색조건 validation
			var startDate = $("#STARTDATE").val();
			var endDate = $("#ENDDATE").val();
			
			var startHour = $("#STARTHOUR").val();
			var startMin = $("#STARTMIN").val();
			var endHour = $("#ENDHOUR").val();
			var endMin = $("#ENDMIN").val();
			
			var startDateTrim = stringTrim(startDate);
			var endDateTrim = stringTrim(endDate);
			
			if((startDateTrim != "" && endDateTrim == "") || (startDateTrim == "" && endDateTrim != "")) {
				openDialog(null, null, 300, '<spring:message code="ERROR_SEARCH_DES01" />');
				return;
			}
			
			
			if(startDateTrim != "" && endDateTrim != "") {
				if((startDate == endDate) && parseInt(startHour+startMin) >= parseInt(endHour+endMin)) {
					openDialog(null, null, 300, '<spring:message code="ERROR_SEARCH_DES02" />');
					return;
				}
			}
			
			// 검색 조건 리셋
			resetSearchParam("grid");
			var object = getSearchParam($("#searchDiv div :input"));
			$("#grid").jqGrid('setGridParam', {postData:object}).trigger("reloadGrid", [{page:1}]);
		});		

		/*
		 * 날짜를 생성해서 STARTDATE 에서 ENDDATE 넘어서 날짜를 선택하지 못하게 하고
		 * 반대도 마찬가지로 설정
		 */
		var dates = $( "#STARTDATE, #ENDDATE" ).datepicker({
			showOn: "button",
			// 버튼 이미지
			buttonImage: '<c:url value="/resources/image/btn_calendar01.gif" />',
			buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				// STARTDATE 일 경우 minDate ENDDATE maxDate
				var option = this.id == "STARTDATE" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
		
		// 시간 콤보 채우기
		makeTimeCombo(null, "START");
		makeTimeCombo(null, "END");
	}
</script>

<div class="search_cate_wrap">
	<!-- <h2 class="h2_title01">통지수신결과 검색</h2> -->
	<p class="openBtn" id="searchHideButton">
		<a href="javascript:searchDivShow();">
		<img src="<c:url value="/resources/image/bul_close01.gif" />" alt="" />
		<spring:message code="DVIC_SEL_NONE_TXT01" />
		</a>
	</p>
	<div class="con" id="searchDiv">
		<div class="search_cate2">
			<ul>
				<li><label for="tcate01"><spring:message code="LOGS_LST09" /></label>
				 <span><input type="text" id="ADMINNAME" name="ADMINNAME" class="ipt01" /></span>
				</li>
				<li><label for="tcate01"><spring:message code="LOGS_LST03" /></label>
				<span>
					<select name="MSGCODE" style="width:200px" id="tcate02" class="wide">
	    			<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
					<option value="2"><spring:message code="LOGS_SEARCH_BOX_CMB02" /></option>
					<option value="3"><spring:message code="LOGS_SEARCH_BOX_CMB03" /></option>
					<option value="4"><spring:message code="LOGS_SEARCH_BOX_CMB04" /></option>
					<option value="5"><spring:message code="LOGS_SEARCH_BOX_CMB05" /></option>
					<option value="6"><spring:message code="LOGS_SEARCH_BOX_CMB06" /></option>
					<option value="1"><spring:message code="LOGS_SEARCH_BOX_CMB08" /></option>
					<option value="9"><spring:message code="LOGS_SEARCH_BOX_CMB07" /></option>
					<option value="10"><spring:message code="LOGS_SEARCH_BOX_CMB14" /></option>
					<option value="11"><spring:message code="LOGS_SEARCH_BOX_CMB09" /></option>
					<option value="7"><spring:message code="LOGS_SEARCH_BOX_CMB15" /></option>
					</select>
				</span>
				</li>
				<li>
				<label for="tcate04"><spring:message code="LOGS_LST04" /></label>
					<input type="text" id="STARTDATE" name="STARTDATE" class="ipt01" disabled />
					<select id="STARTHOUR" name="STARTHOUR"></select>&nbsp;:&nbsp;<select id="STARTMIN" name="STARTMIN"></select>
					&nbsp;&nbsp; <spring:message code="ADMN_INFO_EDIT_TXT07" /> &nbsp;&nbsp;
					<input type="text" id="ENDDATE" name="ENDDATE" class="ipt01" disabled /> 
					<select id="ENDHOUR" name="ENDHOUR" ></select>&nbsp;:&nbsp;<select id="ENDMIN" name="ENDMIN"></select>
				</li>
			</ul>
		</div>
		<div class="search_btn">
			<span class="buttonS" id="resetButton"><a href="#"><spring:message code="COM_BTN_RESET" /></a></span>&nbsp;&nbsp;
			<span class="buttonSg" id="searchButton"><a href="#" id="searchButton"><spring:message code="COM_BTN_SEARCH" /></a></span>
		</div>
	</div>
</div>

<!-- 
<h2 class="h2_title02">통지수신결과</h2>
 -->
<div class="report_table_wrap">
	<p class="data_count" id="gridTotalCnt"></p>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>

<!-- 
[2011/12/08] by galim12
서브 목록 
 -->
<div id="sendedSubDialog" title="통지 수신 결과 서브 목록" style="display:none">
<p class="data_count" id="gridTotalCnt"></p>
</div>