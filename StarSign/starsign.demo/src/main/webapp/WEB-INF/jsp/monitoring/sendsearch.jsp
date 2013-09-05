<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		init(initSendSearch);
	});
	function initSendSearch() {
		// 그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.sendSearch',
			mtype: 'POST',
			datatype: 'json',
				colNames:['메시지ID',
				          '통지유형',
				          '통지내용',
				          '전화번호/MAC주소',
				          '보낸시간',
				          '통지결과',
				          ''],
				colModel:[
					{title:false, name:'MSGID',index:'MSGID', align:"center"},
					{title:false, name:'NOTIFICATIONTYPE',index:'NOTIFICATIONTYPE', align:"center"},
					{title:false, name:'MSGCODE',index:'MSGCODE', align:"center"},
					{title:false, name:'PHONE',index:'PHONE', align:"center"},
					{title:false, name:'SENDTIME',index:'SENDTIME', align:"center"},
					{title:false, name:'STATUS',index:'STATUS', align:"center"},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'MSGID', sortorder: "asc", rowNum:25, pager: '#pager', height: '100%',
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
			}
		});

		// 검색 하기
		$("#searchButton").click(function() {
			// 검색 조건 리셋
			resetSearchParam("grid");
			var object = getSearchParam($("#searchDiv div :input"));
			$("#grid").jqGrid('setGridParam', {postData:object}).trigger("reloadGrid");
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
<div class="receiveResult_wrap">
	<h2 class="h2_title01">통지수신결과 검색</h2>
	<div class="top_con" id="searchDiv">
		<div class="cate01">
			<label for="type01"><spring:message code="LOGS_SUB_LST05" /> </label>
			<select name="NOTIFICATIONTYPE">
    			<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
				<option value="C"><spring:message code="CNFG_MODE_RDO01" /></option>
				<option value="S"><spring:message code="CNFG_MODE_RDO02" /></option>
				<option value="P"><spring:message code="CNFG_MODE_RDO04" /></option>
			</select>
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			<label for="type02"><spring:message code="LOGS_LST03" /></label>
			<select name="MSGCODE">
    			<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
				<option value="2"><spring:message code="LOGS_SEARCH_BOX_CMB02" /></option>
				<option value="3"><spring:message code="LOGS_SEARCH_BOX_CMB03" /></option>
				<option value="4"><spring:message code="LOGS_SEARCH_BOX_CMB04" /></option>
				<option value="5"><spring:message code="LOGS_SEARCH_BOX_CMB05" /></option>
				<option value="6"><spring:message code="LOGS_SEARCH_BOX_CMB06" /></option>
				<option value="9"><spring:message code="LOGS_SEARCH_BOX_CMB07" /></option>
				<option value="1"><spring:message code="LOGS_SEARCH_BOX_CMB08" /></option>
				<option value="11"><spring:message code="LOGS_SEARCH_BOX_CMB09" /></option>
				<option value="10"><spring:message code="LOGS_SEARCH_BOX_CMB14" /></option>
				<option value="7"><spring:message code="LOGS_SEARCH_BOX_CMB15" /></option>
			</select>
		</div>
		<div class="cate02">
			<label for="time01"><spring:message code="LOGS_LST04" /></label>
			<input type="text" id="STARTDATE" name="STARTDATE" class="ipt01" />&nbsp;
			<select id="STARTHOUR" name="STARTHOUR" ></select>&nbsp;:&nbsp;<select id="STARTMIN" name="STARTMIN"></select>
			&nbsp; &nbsp; ~ &nbsp; &nbsp; 
			<input type="text" id="ENDDATE" name="ENDDATE" class="ipt01" /> &nbsp;
			<select id="ENDHOUR" name="ENDHOUR" ></select>&nbsp;:&nbsp;<select id="ENDMIN" name="ENDMIN"></select>
		</div>
		<div class="search_btn">
			<span class="buttonSg strong" id="searchButton"><a href="#" id="searchButton"><spring:message code="COM_BTN_SEARCH" /></a></span>
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
