<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var isHide = false;
	var total = 0;
	var pathsize = 70;
	
	$(document).ready(function() {
		init(initBadCodeSearch);
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
 	function getFilePath(path) {
 		if(path.length < pathsize) {
 			return path;
 		}else {
 			var temp = path.substring(0, pathsize-1);
 			return temp + "...";
 		}
 	}
 	/* [2011/12/09] by galim12 */
 	function showSelectedSubList(subGridDivId, subGridId, rowId) {
 		var ref = $("#grid").jqGrid('getRowData', rowId);
		var key = ref.DEVICEID;
		var keyTime = ref.TIME;
		var subGridTableId = subGridId + "_" + rowId;
 		var pagerId = subGridTableId + "paper";
 		var total = ref.INFECTED_COUNT;
		if(total < 100) {
			$("#"+subGridDivId).html("<spring:message code="LOGS_TXT01" arguments='"+total+"' /><table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
	    }else {
	    	$("#"+subGridDivId).html("<p class='ui-state-error'><spring:message code="RPRT_SUB2_DES01" /></p><table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
	    } 
		
		$("#"+subGridTableId).jqGrid({ 
			url: gridPath + 'listGrid.avScanLog&DEVICEID=' + key + '&TIME=' + keyTime,
			mtype: 'POST',
			datatype: 'json',
				colNames:[
							'<spring:message code="RPRT_LST02" />',
							'<spring:message code="RPRT_SUB_LST03" />',
							'<spring:message code="RPRT_SUB_LST04" />',
							'<spring:message code="RPRT_SUB_LST05" />',
							'<spring:message code="RPRT_SUB_LST06" />',
							'<spring:message code="RPRT_SUB_LST07" />',
				          ''
				          ],
				colModel:[
						{title:false, name:"TIME", index:"TIME", hidden:true},
						{title:false, name:"SCAN_TYPE", index:"SCAN_TYPE", align:"left", width:150},
						{title:false, name:"MAL_NAME", index:"MAL_NAME", align:"left", width:200},
						{title:false, name:"MAL_LEVEL",index:"MAL_LEVEL", align:"left", width:60},
						{title:false, name:"MAL_STATUS",index:"MAL_STATUS", align:"left", width:100},
						{title:false, name:"MAL_FILE",index:"MAL_FILE", align:"left", width:440},
						{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			rowNum:25, sortname: 'TIME', sortorder: "asc",  height: '100%', width:950,
			pager: "#"+pagerId, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			subGrid: false,  height: '100%', width: 978, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#"+subGridTableId).jqGrid ('setLabel', 'SCAN_TYPE', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_NAME', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_LEVEL', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_STATUS', '', {'text-align':'left'});
				$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_FILE', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				// 색상 변경
				$("#"+subGridTableId + " tr td").each(function(i, obj) {
					codeAlias(subGridTableId, $(obj).attr('aria-describedby'), obj);
				});
				initGridUI(subGridTableId);
				
				var ids = $("#"+subGridTableId).jqGrid('getDataIDs');
				for(var i=0; i<ids.length; i++) {
					var cl = ids[i];
					var ref = jQuery("#"+subGridTableId).jqGrid('getRowData', cl);
					var original = ref.MAL_FILE;
					var edit = getFilePath(ref.MAL_FILE);
					$("#"+subGridTableId).jqGrid('setRowData', cl, {"MAL_FILE":edit});
					$("#"+subGridTableId).setCell(cl, 'MAL_FILE', '', '', {title:original});
				}
				
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
 	
	function initBadCodeSearch() {
		$("#tabs").tabs();
		
		/**
		 * 검색항목 보이기/숨기기
	 	 */
		searchDivShowHide();
		
		
		//그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.badcodeSearch',
			mtype: 'POST',
			datatype: 'json',
				colNames:[
				          '<spring:message code="DVIC_SEL_NONE_LST01" />',
				          '<spring:message code="DVIC_SEL_NONE_LST02" />',
				          '<spring:message code="RPRT_LST02" />',
				          '<spring:message code="RPRT_LST03" />',
				          '<spring:message code="RPRT_LST04" />',
				          '<spring:message code="RPRT_LST05" />',
				          '', '', '', '', '', ''],
				colModel:[
					{title:false, name:'PHONE',index:'PHONE', align:"left", width:200},
					{title:false, name:'EMPLOYEENAME',index:'EMPLOYEENAME', align:"left", width:178},
					{title:false, name:'TIME',index:'TIME', align:"left", width:170},
					{title:false, name:'EVENT_TYPE',index:'EVENT_TYPE', align:"left", width:230},
					{title:false, name:'SCANNED_COUNT',index:'SCANNED_COUNT', align:"center", width:90},
					{title:false, name:'INFECTED_COUNT',index:'INFECTED_COUNT', align:"center", width:90},
					{title:false, name:'DEVICEID',index:'DEVICEID', hidden:true},
					{title:false, name:'WIFILISTINFOID',index:'WIFILISTINFOID', hidden:true},
					{title:false, name:'RESETSTATUS',index:'RESETSTATUS', hidden:true},
					{title:false, name:'CONTROLSTATUS',index:'CONTROLSTATUS', hidden:true},
					{title:false, name:'RNUM', index:'RNUM', key:true, hidden:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'TIME', sortorder: "desc", rowNum:25, pager: '#pager', 
			height: '100%', width: 978, subGrid: false, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'EMPLOYEENAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'TIME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'EVENT_TYPE', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				// 코드 적용
				$('#grid tr td').each(function(i, obj) {
					codeAlias("grid", $(obj).attr('aria-describedby'), obj);
				});

				
				// 전화번호/MAC 주소 클릭하면 팝업 레이어 띄우게 하기
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var ref = jQuery("#grid").jqGrid('getRowData', cl);
					var edit;
					edit = "<a href='javascript:detailDeviceInfo(\"" + "grid" +"\", \"" + ref.RNUM + "\");' class='md'>" + ref.PHONE + "</a> ";
					$("#grid").jqGrid('setRowData', cl, {"PHONE":edit});
					
					//감염수가 없는 결과는 서브 그리드를 만들지 않음
				    if(ref.INFECTED_COUNT == 0) {
				    	$("tr[id=" + cl + "]>td[aria-describedby$=_subgrid]").removeAttr("class");
					  	$("tr[id=" + cl + "]>td[aria-describedby$=_subgrid]").html("&nbsp;");
				    }
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
			},
			onSelectRow: function(id) {
				showSelectedSubList("badcodeSubDialog", "subGridTable" ,id);
				openDialog("badcodeSubDialog", null, 1000, null, "<spring:message code='RPRT_SUB_TTL01' />");
			}
			/*
			 * 서브 그리드 생성
			 [2011/12/09] by galim12
			 */
			 /*
			subGridRowExpanded: function(subGridId, rowId) { 
				var ref = $("#grid").jqGrid('getRowData', rowId);
				var key = ref.DEVICEID;
				var keyTime = ref.TIME;
				// subGrid ID 정의
				var subGridDivId = "jq" + subGridId;
				var subGridTableId = subGridId + "grid"; 
				var pagerId = subGridTableId + "pager";
				// 서브 그리드 HTML 생성
				//$("#"+subGridId).html("<p id='"+ subGridTableId +"TotalCnt'></p><table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
				$("#"+subGridId).html("<table id='"+subGridTableId+"' class='scroll'></table><div id='"+pagerId+"' class='scroll'></div>");
				// 서브 그리드 생성 옵션 설정 
				$("#"+subGridTableId).jqGrid({ 
					url: gridPath + 'listGrid.avScanLog&DEVICEID=' + key + '&TIME=' + keyTime,
					mtype: 'POST',
					datatype: 'json',
					colNames: ['<spring:message code="RPRT_LST02" />',
					           '<spring:message code="RPRT_SUB_LST03" />',
					           '<spring:message code="RPRT_SUB_LST04" />',
					           '<spring:message code="RPRT_SUB_LST05" />',
					           '<spring:message code="RPRT_SUB_LST06" />',
					           '<spring:message code="RPRT_SUB_LST07" />',
					           ''], 
					colModel: [ 
						{title:false, name:"TIME", index:"TIME", hidden:true},
						{title:false, name:"SCAN_TYPE", index:"SCAN_TYPE", align:"left", width:150},
						{title:false, name:"MAL_NAME", index:"MAL_NAME", align:"left", width:200},
						{title:false, name:"MAL_LEVEL",index:"MAL_LEVEL", align:"left", width:60},
						{title:false, name:"MAL_STATUS",index:"MAL_STATUS", align:"left", width:100},
						{title:false, name:"MAL_FILE",index:"MAL_FILE", align:"left", width:440},
						{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
					], 
					rowNum:25, sortname: 'TIME', sortorder: "desc",  height: '100%', width:950, 
					pager: "#"+pagerId, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
					// 일단 없는걸로 생각하고 시작하자 pager: "#" + pagerId 
					loadComplete: function() {
						$("#"+subGridTableId).jqGrid ('setLabel', 'SCAN_TYPE', '', {'text-align':'left'});
						$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_NAME', '', {'text-align':'left'});
						$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_LEVEL', '', {'text-align':'left'});
						$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_STATUS', '', {'text-align':'left'});
						$("#"+subGridTableId).jqGrid ('setLabel', 'MAL_FILE', '', {'text-align':'left'});
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
		*/
			
		});
		
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
		
		//단말기 상세정보의 지도 탭 클릭 할당
		$("#locationTab").click(function() {
			var service = {};
			var data = {};
			data["ACTION"] = "select.mobileDeviceInfo";
			data["DEVICEID"] = currentDeviceId;
			service["detailDeviceInfo"] = data;
			doAction(service, function(result) {
				var deviceObject = result["detailDeviceInfo"];
				if(deviceObject["CONTROLSTATUS"] != "2") {
					$("#wappermap").html('<p>' + $.i18n.prop("DVIC_NOT_AGENT_DES01") + '</p>');
				}
				else if(deviceObject["CONTROLSTATUS"] == "2" && deviceObject["RESETSTATUS"] == "Y") {
					createMap("wappermap", currentDeviceId);
				}
				else {
					$("#wappermap").html('<p>' + $.i18n.prop("DVIC_LOC_NONE_DES01") + '</p>');
				}
			});
		});
	}
	/*
	 * 장비 상세보기
	 */
	function detailDeviceInfo(divId, key) {
		var ref = jQuery("#" + divId).jqGrid('getRowData', key);
		// 값 설정
		currentDeviceId = ref.DEVICEID;
		//alert(ref.DEVICEID);
		createDeviceManageTab(ref.DEVICEID, ref.WIFILISTINFOID, ref.RESETSTATUS, ref.CONTROLSTATUS, null);
		// 다이얼로그 오픈
		$("#tabs").tabs("select", 0);
		openDialog("detailDeviceDialog", null, 600);
	}
</script>

<div class="search_cate_wrap">
	<!-- <h2 class="h2_title01"></h2> -->
	<p class="openBtn" id="searchHideButton">
		<a href="javascript:searchDivShow();">
		<img src="<c:url value="/resources/image/bul_close01.gif" />" alt="" />
		<spring:message code="DVIC_SEL_NONE_TXT01" />
		</a>
	</p>
	<div class="con" id="searchDiv">
		<div class="search_cate2">
			<ul>
				<li><label for="tcate01"><spring:message code="RPRT_LST03" /></label>
				 <span>
				 <select name="EVENT_TYPE">
	    			<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
	    			<!-- 
					<option value="1"></option>
					<option value="2"></option>
					<option value="3"></option>
					<option value="4"></option>
					<option value="5"></option>
					-->
					<option value="8"><spring:message code="RPRT_SEARCH_BOX_CMB08" /></option>
					<option value="9"><spring:message code="RPRT_SEARCH_BOX_CMB09" /></option>
					</select>
				 </span>
				</li>
				<!-- 
				<li><label for="tcate01"></label>
				<span>
					<select name="RESULT_CODE">
	    			<option value=""></option>
					<option value="0"></option>
					<option value="1"></option>
				</select>
				</span>
				</li>
				-->
				<li>
				<label for="tcate04"><spring:message code="RPRT_LST02" /></label>
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
[2011/12/09] by galim12
서브 목록 
 -->
 <div id="test"></div>
<div id="badcodeSubDialog" title="악성코드 서브 목록" style="display:none">

</div>