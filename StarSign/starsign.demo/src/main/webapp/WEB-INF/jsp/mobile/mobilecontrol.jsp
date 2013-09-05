<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var isHide = false;
	var resetStatus = null;
	var currentDeviceId = null;
	var currentDeviceControlStatus = null;
	
	function ismaxlength(obj) {
		var mlength = obj.getAttribute ? parseInt(obj.getAttribute("maxlength")) : "";
		if (obj.getAttribute && obj.value.length > mlength)
			obj.value = obj.value.substring(0, mlength);
	}
	
	$(document).ready(function() {
		init(initMobileControl);
	});
	
	function searchGrid() {
		// 검색 조건 리셋
		resetSearchParam("leftgrid");
		var object = getSearchParam($("#searchDiv div ul li :input"));
		$("#leftgrid").jqGrid('setGridParam', {postData:object}).trigger("reloadGrid", [{page:1}]);
	}
	
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
 	
	function initMobileControl() {		
		$("#detailDeviceContent").html($("#detailDeviceDialog").html());
		$("#tabs").tabs();
		
		/**
		 * 검색항목 보이기/숨기기
	 	 */
		searchDivShowHide();
		/*
		$("#searchHideButton").click(function() {
			if(isHide) {
				$("#searchDiv").show("blind");
				isHide = false;
				$("#searchHideButton img").attr("src", '<c:url value="/resources/image/bul_close01.gif" />');
				//$("#searchHideButton img").attr("alt", '닫기');
			}
			else {
				$("#searchDiv").hide("blind");
				isHide = true;
				$("#searchHideButton img").attr("src", '<c:url value="/resources/image/bul_open01.gif" />');
				//$("#searchHideButton img").attr("alt", '열기');
			}
		});
		*/
		
		resetStatus = '${LOSTMODE}';
		if(resetStatus != null) {
			$("#RESETSTATUS").val(resetStatus);
		}
		var object = getSearchParam($("#searchDiv div ul li :input"));
		
		// 그리드 생성
		$("#leftgrid").jqGrid({
			url: gridPath + 'listGrid.mobileDeviceControl',
			datatype: 'json',
			postData:object,
			mtype: 'POST',
				colNames:[
						  '<spring:message code="DVIC_SEL_NONE_LST08" />',
						  '<spring:message code="DVIC_SEL_NONE_LST08" />',
				          '<spring:message code="DVIC_SEL_NONE_LST01" />',
				          '<spring:message code="DVIC_SEL_NONE_LST02" />',
				          '<spring:message code="DVIC_SEL_NONE_LST03" />',
				          '<spring:message code="DVIC_SEL_NONE_LST04" />',
				          '<spring:message code="DVIC_SEL_NONE_LST05" />',
				          '<spring:message code="DVIC_SEL_NONE_LST06" />',
				          '<spring:message code="DVIC_SEL_NONE_LST07" />',
				          '<spring:message code="DVIC_SEL_NONE_LST09" />',
				          '<spring:message code="DVIC_SEL_NONE_LST10" />',
				          '<spring:message code="DVIC_SEL_NONE_LST11" />',
				          '', '', '', '<spring:message code="DVIC_SEARCH_BOX_TXT10" />', '', ''],
				colModel:[
					{title:false, name:'CONTROLSTATUS',index:'CONTROLSTATUS', align:'left'},
					{title:false, name:'CONTROLSTATUS_CODE',index:'CONTROLSTATUS_CODE', hidden:true},
					{title:false, name:'PHONE',index:'PHONE', width:140, align:'left'},
					{title:false, name:'EMPLOYEENAME',index:'EMPLOYEENAME', width:100, align:'left'},
					{title:false, name:'DEPARTMENT',index:'DEPARTMENT', width:120, align:'left'},
					{title:false, name:'POSITION',index:'POSITION', width:100, align:'left'},
					{title:false, name:'EMAIL',index:'EMAIL', width:150, align:'left'},
					{title:false, name:'POLICYNAME',index:'POLICYNAME', width:120, align:'left'},
					{title:false, name:'GROUPNAME',index:'GROUPNAME', width:120, align:'left'},
					{title:false, name:'AVENGINEVERSION',index:'AVENGINEVERSION', width:90, align:'left'},
					{title:false, name:'OSVERSION',index:'OSVERSION', width:90, align:'left'},
					{title:false, name:'ROOTINGYN',index:'ROOTINGYN', width:90, align:'left'},
					{title:false, name:'DEVICEID', index:'DEVICEID', key:true, hidden:true},
					{title:false, name:'GROUPID',index:'GROUPID', hidden:true},
					{title:false, name:'WIFILISTINFOID',index:'WIFILISTINFOID', hidden:true},
					{title:false, name:'RESETSTATUS',index:'RESETSTATUS', width:90, align:'left'},
					{title:false, name:'REGISTRATIONID',index:'REGISTRATIONID', hidden:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'EMPLOYEENAME', sortorder: "desc", rowNum:10, pager: '#leftpager', multiselect: true, 
			shrinkToFit: false, 
			height: "100%", width: 975, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			loadComplete: function() {
				$("#leftgrid").jqGrid ('setLabel', 'CONTROLSTATUS', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'EMPLOYEENAME', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'DEPARTMENT', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'POSITION', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'EMAIL', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'POLICYNAME', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'GROUPNAME', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'AVENGINEVERSION', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'OSVERSION', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'ROOTINGYN', '', {'text-align':'left'});
				$("#leftgrid").jqGrid ('setLabel', 'RESETSTATUS', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				// 색상 변경
				$('#leftgrid tr td').each(function(i, obj) {
					codeAlias("leftgrid", $(obj).attr('aria-describedby'), obj);
				});

				initGridUI("leftgrid");
				
				//에이전트 등록 여부에 이미지 달기
				var ids = $("#leftgrid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var ref = jQuery("#leftgrid").jqGrid('getRowData', cl);
					var img;
					if(ref.CONTROLSTATUS == $.i18n.prop('DVIC_SEARCH_BOX_CMB03'))
						img = "<img src=\"<c:url value='/resources/image/icon_ok.gif' />\" />&nbsp;";
					else if(ref.CONTROLSTATUS == $.i18n.prop('DVIC_SEARCH_BOX_CMB04'))
						img = "<img src=\"<c:url value='/resources/image/icon_ok2.gif' />\" />&nbsp;";
					else
						img = "<img src=\"<c:url value='/resources/image/icon_no.gif' />\" />&nbsp;";

					$("#leftgrid").jqGrid('setRowData', ids[i], {"CONTROLSTATUS":img+ref.CONTROLSTATUS});
				}
			},
			onSelectRow: function(id) {
				var pageMenu = '${pageMenu}';
				var ret = jQuery("#leftgrid").jqGrid('getRowData', id);
				currentDeviceId = id;
				createDeviceManageTab(id, ret.WIFILISTINFOID, ret.RESETSTATUS, ret.CONTROLSTATUS_CODE, pageMenu);
				
				currentDeviceControlStatus = ret.CONTROLSTATUS_CODE;
				$("#tabs").tabs("select", 0);
				
				//선택한 Row 색상 처리
				highlighGridRow('leftgrid', ret.DEVICEID, 'DEVICEID');
			}
		});

		// Combo 채우기
		var service = {};
		// 그룹 콤보 채우기
		var group = {};
		// 정책 콤보 채우기
		var policy = {};

		group["ACTION"] = "list.policyGroupCombo";
		policy["ACTION"] = "list.policyCombo";
		
		service["GROUPID"] = group;
		service["POLICYID"] = policy;
		
		// Ajax로 콤보 채우기
		addOption(service, true);
		
		service = new Object();
		var param = new Object();
		
		param["ACTION"] = "propertySelect.NotifyMode";

		service["defaultNotifyMode"] = param;
		doAction(service, function(result) {
			var obj = result["defaultNotifyMode"];
			$("#NOTIFYMODE").val(obj["NOTIFYMODE"]);
		});

		
		// 검색 하기
		$("#searchButton").click(function() {
			searchGrid();
		});
		
		// 검색 조건 리셋
		$("#resetButton").click(function() {
			resetSearchData($("#searchDiv div ul li :input"));
		});
		/*
		 * 메시지 보내기
		 * (NOTIFYMODE + MSGCODE 서버에 전송)
		 */
		$("#messageButton").click(function() {
			var s = $("#leftgrid").jqGrid('getGridParam','selarrrow');
			if(s.length == 0) {
				openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
				return;
			}
			
			var action = {
				"<spring:message code='COM_BTN_YES' />" : function() {
					messageAction();
					$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_NO' />" : function() {
					$(this).dialog("close");
				}
			};
			
			var action2 = {
					"<spring:message code='COM_BTN_OK' />" : function() {
						if(validation("noticeDialog")) {
							messageAction();
							$(this).dialog("close");	
						}
					},
					"<spring:message code='COM_BTN_CANCEL' />" : function() {
						$(this).dialog("close");
					}
				};

			var msg = "";
			var dialogTitle = null;
			switch($("#MSGCODE").val()) {
			case "2" : 
				msg = "<spring:message code='DVIC_CMD_DES01' htmlEscape='false' />";
				//dialogTitle = "<spring:message code='DVIC_CMD_DES01' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "3" : 
				msg = "<spring:message code='DVIC_CMD_DES02' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "4" : 
				msg = "<spring:message code='DVIC_CMD_DES03' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "5" : 
				msg = "<spring:message code='DVIC_CMD_DES04' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "6" : 
				msg = "<spring:message code='DVIC_CMD_DES05' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "1" : 
				msg = "<spring:message code='DVIC_CMD_DES06' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "9" : 
				msg = "<spring:message code='DVIC_CMD_DES07' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "10" : 
				msg = "<spring:message code='DVIC_CMD_DES09' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "11" : 
				msg = "<spring:message code='DVIC_CMD_DES08' htmlEscape='false' />";
				openDialog(null, action, 300, msg, dialogTitle);
				break;
			case "7" :
				//msg = '<spring:message code="DVIC_CMD_TXT01" /> </br> <input type="text" id="DESCRIPTION" size="30" maxlength="30" style="background: none repeat scroll 0 0 #313131; border: 1px solid #000000;" />';
				//openDialog(null, action2, 300, msg, dialogTitle);
				$(".ui-state-error").html('');
				$("#DESCRIPTION").val('');
				openDialog("noticeDialog", action2, 300, msg, dialogTitle);
				break;
			}
			
		});
		
		//단말기 상세정보의 지도 탭 클릭 할당
		$("#locationTab").click(function() {
			//alert(currentDeviceId + " : " + currentDeviceControlStatus);
			if(currentDeviceId == null && currentDeviceControlStatus == null)
				return;
			else if(currentDeviceControlStatus == $.i18n.prop("DVIC_SEARCH_BOX_CMB09")) {
				$("#wappermap").html('<p>' + $.i18n.prop("DVIC_NOT_AGENT_DES01") + '</p>');
			}
			else if(currentDeviceId != null && currentDeviceControlStatus != $.i18n.prop("DVIC_SEARCH_BOX_CMB09")) {
				var service = {};
				var data = {};
				data["ACTION"] = "select.mobileDeviceInfo";
				data["DEVICEID"] = currentDeviceId;
				service["detailDeviceInfo"] = data;
				doAction(service, function(result) {
					var deviceObject = result["detailDeviceInfo"];
					if(deviceObject["CONTROLSTATUS"] == "1") {
						$("#wappermap").html('<p>' + $.i18n.prop("DVIC_NOT_AGENT_DES01") + '</p>');
					}
					else if(deviceObject["CONTROLSTATUS"] == "2" && deviceObject["RESETSTATUS"] == "Y") {
						createMap("wappermap", currentDeviceId);
					}
					else {
						$("#wappermap").html('<p>' + $.i18n.prop("DVIC_LOC_NONE_DES01") + '</p>');
					}
				});
			}
		});
	}
	// 메시지 보내기
	function messageAction() {
		var service = new Object();
		var data = new Object();
		
		var updateDeviceData = {};
		var updateDeviceList = new Array();
		
		data["ACTION"] = "send.Command";
		data["NOTIFYMODE"] = $("#NOTIFYMODE").val();
		data["MSGCODE"] = $("#MSGCODE").val();
		data["ADMINNAME"] = '${currUser.name}';

		// 공지 메시지 일 경우
		if($("#MSGCODE").val() == 7) {
			data["DESCRIPTION"] = $("#DESCRIPTION").val();
		}
		
		var deviceIdList = new Array();
		var s = $("#leftgrid").jqGrid('getGridParam','selarrrow');
		
		for(var i=0 ; i < s.length ; i++) {
			var ret = jQuery("#leftgrid").jqGrid('getRowData', s[i]);
			
			if(ret.DEVICEID != null && ret.CONTROLSTATUS_CODE == $.i18n.prop('DVIC_SEARCH_BOX_CMB03')) {
				var obj = new Object();
				obj["DEVICEID"] = ret.DEVICEID;
				obj["PHONE"] = ret.PHONE;
				obj["REGISTRATIONID"] = ret.REGISTRATIONID;
				deviceIdList.push(obj);
				updateDeviceList.push(ret.DEVICEID);
			}
 		}
		data["DEVICEIDLIST"] = deviceIdList;
		service["sendCommand"] = data;
		
		// 분실모드 전환 일 경우
		/*
		if($("#MSGCODE").val() == 1) {
			updateDeviceData["DEVICEIDLIST"] = updateDeviceList;
			updateDeviceData["RESETSTATUS"] = "Y";
			updateDeviceData["ACTION"] = "update.mobileDevice";
			
			service["mobileUpdate"] = updateDeviceData;
		}
		*/
		
		if(deviceIdList.length != 0) {
			doAction(service, function(result) {
				var obj = result["sendCommand"];
				var obj2 = eval("(" + obj + ")");
				var obj3 = obj2.DEVICELIST;

				if (obj2.SUCCESSCOUNT == deviceIdList.length){
					var msg = "<spring:message code='DVIC_SEND_MSG_DES01' htmlEscape='false' />";
					openDialog("commandDialog", null, 500, msg);
				}
				else{
					// 전송 실패 내역을 보여주기 위한 기본 그리드 생성
				//	alert(obj2.SUCCESSCOUNT + "|" + obj2.FAILCOUNT);
					jQuery("#commandgrid").jqGrid({
    					datatype: "local",
				        colNames:['PHONE','GROUPNAME'],
				        colModel:[
				            {name:'PHONE',index:'PHONE', width:235, align:'center'},
				            {name:'GROUPNAME',index:'GROUPNAME', width:235, align:'center'}
				        ]
				    });
				    
					for (var i = 0; i < obj3.length; i++){	 
						jQuery("#commandgrid").addRowData(i + 1, obj3[i]);
					}
					var msg = "<spring:message code='DVIC_SEND_MSG_DES02' htmlEscape='false' />"
							+ "<br /><br />"
							+ "<spring:message code='DVIC_SEND_MSG_TXT01' htmlEscape='false' /> " + obj2.SUCCESSCOUNT
							+ "<br />"
							+ "<spring:message code='DVIC_SEND_MSG_TXT02' htmlEscape='false' /> " + obj2.FAILCOUNT;
					openDialog("commandDialog", null, 500, msg);
				}
				
				// 데이터 초기화 메시지  또는 분실모드 전환 일 경우
				if($("#MSGCODE").val() == 5 || $("#MSGCODE").val() == 1) {
					$("#leftgrid").trigger("reloadGrid");
				}
				
			});
		}
	}
</script>
<div class="search_cate_wrap">
	<p class="openBtn" id="searchHideButton">
		<a href="javascript:searchDivShow();">
		<img src="<c:url value="/resources/image/bul_close01.gif" />" />
		<spring:message code="DVIC_SEL_NONE_TXT01" />
		</a>
	</p>
	<!-- s: content -->
	<div class="con" id="searchDiv">
		<div class="search_cate">
			<ul>
				<li><label for="tcate01"><spring:message code="DVIC_SEL_NONE_LST07" /></label>
				<span>
					<select id="GROUPID" name="GROUPID"></select> 
				</span>
				</li>
				<li><label for="tcate02"><spring:message code="DVIC_SEL_NONE_LST06" /></label>
				<span>
					<select id="POLICYID" name="POLICYID"></select>
				</span>
				</li>
				<li><label for="tcate04" style="padding-top: 0;">
				<select name="phoneMac" class="keyword">
					<option value="PHONE"><spring:message code="DVIC_SEARCH_BOX_CMB01" /></option>
					<option value="MAC"><spring:message code="DVIC_SEARCH_BOX_CMB02" /></option>
				</select>
				</label>
				<span><input type="text" name="phoneMac" class="param ipt01" /></span>
				</li>
			</ul>
			<ul class="cate_left">
				<li><label for="tcate04"><spring:message code="DVIC_SEL_NONE_LST02" /></label>
					<span><input type="text" name="EMPLOYEENAME" class="ipt01"  /></span>
				</li>
				<li><label for="tcate05"><spring:message code="DVIC_SEL_NONE_LST03" /></label>
					<span><input type="text" name="DEPARTMENT" class="ipt01"  /></span>
				</li>
				<li><label for="tcate06"><spring:message code="DVIC_SEL_NONE_LST04" /></label>
					<span><input type="text" name="POSITION" class="ipt01"  /></span>
				</li>
				<li><label for="tcate07"><spring:message code="DVIC_SEL_NONE_LST05" /></label>
					<span><input type="text" name="EMAIL" class="ipt01"  /></span>
				</li>
				<li><label for="tcate09"><spring:message code="DVIC_SEL_NONE_LST10" /></label>
					<span><input type="text" name="OSVERSION" class="ipt01"  /></span>
				</li>
				<li><label for="tcate08"><spring:message code="DVIC_SEL_NONE_LST09" /></label>
					<span><input type="text" name="AVENGINEVERSION" class="ipt01"  /></span>
				</li>
				<li><label for="tcate10"><spring:message code="DVIC_SEL_NONE_LST08" /></label>
				<span>
					<select id="CONTROLSTATUS" name="CONTROLSTATUS" class="ipt02">
						<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
						<option value="1"><spring:message code="DVIC_SEARCH_BOX_CMB09" /></option>
						<option value="2"><spring:message code="DVIC_SEARCH_BOX_CMB03" /></option>
						<option value="3"><spring:message code="DVIC_SEARCH_BOX_CMB04" /></option>
			    	</select> 
				</span>
				</li>
				<li><label for="tcate10"><spring:message code="DVIC_SEARCH_BOX_TXT10" /></label>
				<span>
					<select id="RESETSTATUS" name="RESETSTATUS" class="ipt02">
						<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
						<option value="N"><spring:message code="DVIC_SEARCH_BOX_TXT11" /></option>
						<option value="Y"><spring:message code="DVIC_SEARCH_BOX_TXT12" /></option>
			    	</select>
				</span>
				</li>
				<li><label for="tcate10"><spring:message code="DVIC_SEL_NONE_LST11" /></label>
				<span>
					<select id="ROOTINGYN" name="ROOTINGYN" class="ipt02">
						<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
						<option value="N"><spring:message code="DVIC_SEARCH_BOX_CMB05" /></option>
						<option value="Y"><spring:message code="DVIC_SEARCH_BOX_CMB06" /></option>
			    	</select>
				</span>
				</li>
			</ul>
		</div>
		<div class="search_btn">
			<span class="buttonS" id="resetButton"><a href="#"><spring:message code="COM_BTN_RESET" /></a></span>
			<span class="buttonSg" id="searchButton"><a href="#"><spring:message code="COM_BTN_SEARCH" /></a></span>
		</div>
	</div>
	<!-- e: content -->
</div>

<!-- <h2 class="h2_title02"></h2> -->
<h2 class="h2_title05"><spring:message code="DVIC_SEL_NONE_DES02" /></h2>
<div class="mobile_list">
	<fieldset>
		<!-- <legend>단말기 목록 검색</legend>  -->
		<select id="NOTIFYMODE">
			<option value="1"><spring:message code="CNFG_MODE_RDO01" /></option>
			<option value="3"><spring:message code="CNFG_MODE_RDO03" /></option>
			<option value="2"><spring:message code="CNFG_MODE_RDO02" /></option>
			<option value="0"><spring:message code="CNFG_MODE_RDO04" /></option>
		</select>
		<select id="MSGCODE">
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
		<input id="NOFITYMSG" type="hidden" />
		<span class="buttonSw"><input id="messageButton" type="button" value="<spring:message code='DVIC_SEL_NONE_BTN01' />"/></span>
	</fieldset>
</div>

<div class="report_table_wrap">
	<p class="data_count" id="leftgridTotalCnt"></p>
	<div class="con">
		<div id="leftjqgrid">
			<table id="leftgrid" width="30%"></table>
			<div id="leftpager"></div>
		</div>
	</div>
</div>

<div id="detailDeviceContent"></div>

<!-- 통지 명령 전송 시 전송 결과 다이얼로그 -->
<div id="commandDialog" style="display:none;height: auto;" >
	<ul>
		<li><p class="dialogContent"></p></li>
	</ul>
	<div class="report_table_wrap" style="padding-top:10px">
		<div class="con">
			<div id="commandjqgrid">
				<table id="commandgrid"></table>
			</div>
		</div>
	</div>
</div>