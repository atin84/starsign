<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>

<script type="text/javascript">
	var isHide = false;
	$(document).ready(function() {
		init(initMobileManage);
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
	
	function initMobileManage() {
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
		
		// 그리드 만들기
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.mobileDevice',
			editurl : gridEditPath + 'employee.do',
			mtype: 'POST',
			datatype: 'json',
				colNames:[
						  '<spring:message code="DVIC_ADMN_LIST_TXT06" />',
						  '<spring:message code="DVIC_ADMN_LIST_TXT06" />',
				          '<spring:message code="DVIC_ADMN_LIST_TXT01" />',
				          '<spring:message code="DVIC_SEL_NONE_LST02" />',
				          '<spring:message code="DVIC_SEL_NONE_LST01" />',
				          '<spring:message code="DVIC_SEL_NONE_LST03" />',
				          '<spring:message code="DVIC_SEL_NONE_LST04" />',
				          '<spring:message code="DVIC_SEL_NONE_LST05" />',
				          '', '', '', ''],
				colModel:[
					{title:false, name:'CONTROLSTATUS',index:'CONTROLSTATUS', align:"left", editable:false, width:140},
					{title:false, name:'CONTROLSTATUS_CODE',index:'CONTROLSTATUS_CODE', align:"left", hidden:true},
					{title:false, name:'EMPLOYEENO',index:'EMPLOYEENO', editable:true, align:"center", editoptions:{maxlength:20}, width:90},
					{title:false, name:'EMPLOYEENAME',index:'EMPLOYEENAME', editable:true, editrules:{required:true}, editoptions:{maxlength:12}, align:"left", width:120},
					{title:false, name:'PHONE',index:'PHONE', editable:true, editrules:{required:true}, editoptions:{maxlength:17}, align:"left", width:150},
					{title:false, name:'DEPARTMENT',index:'DEPARTMENT', editable:true, align:"left", editoptions:{maxlength:30}, width:120},
					{title:false, name:'POSITION',index:'POSITION', editable:true, align:"left", editoptions:{maxlength:16}, width:110},
					{title:false, name:'EMAIL',index:'EMAIL', editable:true, editrules:{required:true, email:true}, editoptions:{maxlength:100}, align:"left", width:160},
					{title:false, name:'ACTION',index:'ACTION', sortable:false, align:"center", width:63},
					{title:false, name:'DEVICEID',index:'DEVICEID', key:true, hidden:true},
					{title:false, name:'EMPLOYEEID',index:'EMPLOYEEID', hidden:true, editable:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'EMPLOYEENAME', sortorder: "asc", rowNum:25, width:978, height: '100%', 
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			pager: '#pager', multiselect: true,
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'CONTROLSTATUS', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'EMPLOYEENAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'DEPARTMENT', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'POSITION', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'EMAIL', '', {'text-align':'left'});
			},
			gridComplete: function() { 
				// 색상 변경
				$('#grid tr td').each(function(i, obj) {
					if($(obj).attr('aria-describedby') == 'grid_CONTROLSTATUS' || 
							$(obj).attr('aria-describedby') == 'grid_CONTROLSTATUS_CODE') {
						// 통제 단말기 일 경우(인증 했든 안했든 둘다)
						if($(obj).text() == '0') {
							$(obj).text("<spring:message code='DVIC_ADMN_LIST_CMB04' />");
							$(obj).css("color", "#ee0000");
						}
						else {
							$(obj).text("<spring:message code='DVIC_ADMN_LIST_CMB03' />");
						}
					}
				});
				
				
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					
					//통제 단말기 여부에 이미지 달기
					var ref = jQuery("#grid").jqGrid('getRowData', cl);
					var img;
					if(ref.CONTROLSTATUS == $.i18n.prop('DVIC_ADMN_LIST_CMB03'))
						img = "<img src=\"<c:url value='/resources/image/icon_ok.gif' />\" />&nbsp;";
					else
						img = "<img src=\"<c:url value='/resources/image/icon_no.gif' />\" />&nbsp;";

					$("#grid").jqGrid('setRowData', ids[i], {"CONTROLSTATUS":img+ref.CONTROLSTATUS});
					
					//단말기 정보 수정
					var img2 = "<img src=\"<c:url value='/resources/image/bt_modify.gif' />\" />";
					//var ed = "<a href='javascript:editAction(\"" + cl + "\");' class='md'>수정</a> "; 
					var ed = "<a href='javascript:editAction(\"" + cl + "\");' class='md'>" + img2 + "</a> ";
					$("#grid").jqGrid('setRowData', ids[i], {"ACTION":ed}); 
				} 
				
				
				initGridUI("grid");
			},
			onSelectRow: function(id) {
				//선택한 Row 색상 처리
				var ret = jQuery("#grid").jqGrid('getRowData', id);
				highlighGridRow('grid', ret.DEVICEID, 'DEVICEID');
			}
		});

		//CSV 비동기 파일 전송
		var frm=$('#frmCSVFile'); 
	 
	   	frm.ajaxForm(loadCSVCallBack); 
	   	frm.submit(function(){return false;});

	   	// 단말기 추가하기
	   	$("#addButton").click(function() {
		   	addAction();
	   	});
	   
	   	// 통제 단말기 등록
	   	$("#regMobileButton").click(function() {
	   		
	   		var s = $("#grid").jqGrid('getGridParam','selarrrow');
			// 선택한 단말기가 없을 경우
			if(s.length == 0) {
				openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
				return;
			}
			
		   	openDialog("regDeviceDialog", getDeviceUpdateButtonAction("1"), null, null, '<spring:message code="DVIC_ADMN_LIST_BTN01" />');
	   	});
	
		// 통제 단말기 해제
	   	$("#relMobileButton").click(function() {
	   		
	   		var s = $("#grid").jqGrid('getGridParam','selarrrow');
			// 선택한 단말기가 없을 경우
			if(s.length == 0) {
				openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
				return false;
			}
			
		   	openDialog("relDeviceDialog", getDeviceUpdateButtonAction("0"), null, null, '<spring:message code="DVIC_ADMN_LIST_BTN02" />');
	   	});

	   	// 삭제
	   	$("#deleteButton").click(function() {
		   	deleteAction();
	   	});

	   	// CSV 등록하기
	   	$("#csvRegButton").click(function() {
	   		csvRegAction();
	   	});
	   	
		// 검색 하기
		$("#searchButton").click(function() {
			// 검색 조건 리셋
			resetSearchParam("grid");
			var object = getSearchParam($("#searchDiv div ul li :input"));
			$("#grid").jqGrid('setGridParam', {postData:object}).trigger("reloadGrid", [{page:1}]);
		});

		// 검색 조건 리셋
		$("#resetButton").click(function() {
			resetSearchData($("#searchDiv div ul li :input"));
		});
	}
	// 추가
	function addAction() {
		var action = {
			"<spring:message code='COM_BTN_OK' />" : function() {
				// 필수 항목 체크
				if(validation("mobileInsertDialog")) {
					var service = {};
					var param = {};
					param["ACTION"] = "deviceInsert.employee";
					param["EMPLOYEENO"] = $("#IN_EMPLOYEENO").val();
					param["EMPLOYEENAME"] = $("#IN_EMPLOYEENAME").val();
					
					param["POSITION"] = $("#IN_POSITION").val();
					param["DEPARTMENT"] = $("#IN_DEPARTMENT").val();
					param["EMAIL"] = $("#IN_EMAIL").val();

					var phone = $("#IN_PHONE").val();
					if(phone.split(":").length > 1) {
						param["MAC"] = $("#IN_PHONE").val();	
					}
					else {
						param["PHONE"] = $("#IN_PHONE").val();
					}
					
					param["FORCE"] = "false";

					service["deviceInsert"] = param;
					doAction(service, function(result) {
						var objResult = result["deviceInsert"];
						
						if(objResult["status"] == "alreay_exist") {
							
							var action2 = {
									"<spring:message code='COM_BTN_YES' />" : function() {
										param["FORCE"] = "true";

										$("#mobileInsertDialog").dialog("close");
										doAction(service, function(result) {
											$("#grid").trigger("reloadGrid", [{page:1}]);
											$("#checkAlertDialog").dialog("close");
										});
									},
									"<spring:message code='COM_BTN_NO' />" : function() {
										$("#checkAlertDialog").dialog("close");
									}
								};
							
							openDialog("checkAlertDialog", action2, null, '<spring:message code="DVIC_ADMN_ADD_DES02" />');
						}
						else {
							$("#grid").trigger("reloadGrid", [{page:1}]);
							//$(this).dialog("close");
							$("#mobileInsertDialog").dialog("close");	
						}
					});
				}
			},
			"<spring:message code='COM_BTN_CANCEL' />" : function() {
				//$(this).dialog("close");
				$("#mobileInsertDialog").dialog("close");
			}
		};
		
		$(".ui-state-error").html('<spring:message code="DVIC_ADMN_ADD_DES01" />');
		openDialog("mobileInsertDialog", action, 330, null, '<spring:message code="DVIC_ADMN_ADD_TTL01" />');
	}
	// 삭제
	function deleteAction() {
		var action = {
				"<spring:message code='COM_BTN_YES' />" : function() {
					var service = {};
					var param = {};
					param["ACTION"] = "deviceDelete.employee";

					var deviceIdList = new Array();
					var employeeIdList = new Array();
					var s = $("#grid").jqGrid('getGridParam','selarrrow');
					for(var i=0 ; i < s.length ; i++) {
						var ret = jQuery("#grid").jqGrid('getRowData', s[i]);
						
						//미등록인 단말기만 삭제 함
						if(ret.CONTROLSTATUS_CODE == '<spring:message code="DVIC_SEARCH_BOX_CMB09" />') {
							deviceIdList.push(ret.DEVICEID);
							employeeIdList.push(ret.EMPLOYEEID);
						}
			 		}
					
			 		param["DEIVCEIDLIST"] = deviceIdList;
			 		param["EMPLOYEEIDLIST"] = employeeIdList;

					service["deviceDelete"] = param;
					
					if(deviceIdList.length > 0) {
						doAction(service, function(result) {
							$("#grid").trigger("reloadGrid", [{page:1}]);
						});
					}
					
					$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_NO' />" : function() {
					$(this).dialog("close");
				}
			};
		var s = $("#grid").jqGrid('getGridParam','selarrrow');
		// 선택한 단말기가 없을 경우
		if(s.length == 0) {
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
			return false;
		}
		openDialog("mobileDeleteDialog", action, 300);
	}
	// 수정
	function editAction(id) {
		if( id != null ) { 
			$("#grid").jqGrid('editGridRow',id, {
				reloadAfterSubmit:true, closeAfterEdit:true, recreateForm:true, 
				width : 350,
				edit : {editCaption:"editCaption"},
				beforeShowForm: function(form) {
					gridEditFormInit("<spring:message code='DVIC_ADMN_MODIFY_TTL01' />");
					$('#PHONE', form).attr('disabled', true);
					$('#EMAIL', form).attr('disabled', true);
					
					$('#editmodgrid').center();
				}
			});
		}
		else 
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
	}
	
	// CSV 등록할 경우 Input File 초기화
	function clearFileInputField(tagId) {
	    document.getElementById(tagId).innerHTML = document.getElementById(tagId).innerHTML;
	}
	// CSV 등록
	function csvRegAction() {
		var button = {
			"<spring:message code='COM_BTN_OK' />" : function() {
				
			 	if(!$("#CSVFILE").val()){
			 		openDialog("checkAlertDialog", null, 300, "<spring:message code='DVIC_ADMN_CSV_DES01' />");
			      $("#CSVFILE").focus();
			      return;
			   }
			   
			   if (!$("#CSVFILE").val().match(/\.(csv)$/i)) {
				   openDialog("checkAlertDialog", null, 300, "<spring:message code='DVIC_ADMN_CSV_DES01' />");
				   $("#CSVFILE").focus();
				   return;
			   }
			
			   //파일전송
			   var frm;
			   frm = $('#frmCSVFile'); 
			   frm.attr("action","${pageContext.request.contextPath}/device/loadCSV.do");
			   frm.submit();

			   $(this).dialog("close");
			},
			"<spring:message code='COM_BTN_CANCEL' />" : function() {
				$(this).dialog("close");
			}
		};
		
		clearFileInputField("CSVFile_div");
		openDialog("csvRegDialog", button, 350, null, "<spring:message code='DVIC_ADMN_CSV_TTL01' />");
	}
	
	/**
	 * 통제 단말기 버튼 액션 만들기
	 * type : 1 - 통제 단말기 등록
	 * type : 0 - 통제 단말기 해제
	 */
	function getDeviceUpdateButtonAction(type) {
		 var button = {
			 "<spring:message code='COM_BTN_YES' />" : function() {
				var service = {};
				var data = {};
				var deviceIdList = new Array();
				var controlDeviceIdList = new Array();	//등록 해제 단말기
				
				var s = $("#grid").jqGrid('getGridParam','selarrrow');
				for(var i=0 ; i < s.length ; i++) {
					var ret = jQuery("#grid").jqGrid('getRowData', s[i]);
					
					/**
					 * 통제 단말기 등록은 미등록인 단말기만 등록하고
					 * 통제 단말기 해제는 등록인 단말기만 등록 해제 한다
					 */
				//	alert(type + " : " + ret.CONTROLSTATUS_CODE);
					if(type == "1") {
						if(ret.CONTROLSTATUS_CODE == '<spring:message code="DVIC_SEARCH_BOX_CMB09" />') {
							if(ret.DEVICEID) {
								deviceIdList.push(ret.DEVICEID);
							}
						}
					}
					else {
						if(ret.CONTROLSTATUS_CODE != '<spring:message code="DVIC_SEARCH_BOX_CMB09" />') {
							if(ret.DEVICEID) {
								deviceIdList.push(ret.DEVICEID);
								
								var obj = new Object();
								obj["DEVICEID"] = ret.DEVICEID;
								controlDeviceIdList.push(obj);
							}
						}
					}
		 		}
				
				data["ACTION"] = "update.mobileDevice";
				data["DEVICEIDLIST"] = deviceIdList;
				
				data["CONTROLSTATUS"] = type;
				data["RESETSTATUS"] = "N";

				service["mobileUpdate"] = data;

				if(deviceIdList.length != 0) {
					
					if(type == "0") {
						var controlData = {};
						controlData["ACTION"] = "send.Command";
						controlData["NOTIFYMODE"] = "0";
						controlData["MSGCODE"] = "8";
						controlData["ADMINNAME"] = '${currUser.name}';
						controlData["DEVICEIDLIST"] = controlDeviceIdList;
						service["sendCommand"] = controlData;
					}
					
					doAction(service, function(result) {
						$("#grid").trigger("reloadGrid");
					});
				}
				
				$(this).dialog("close");
			},
			"<spring:message code='COM_BTN_NO' />" : function() {
				$(this).dialog("close");
			}
		 };

		 return button;
	}
	// 파일전송 후 콜백 함수
	function loadCSVCallBack(data, state){
		var resultObj = eval("(" + data + ")");
		//alert("result : " + resultObj.result + "\ncode : " + resultObj.code);
		if(resultObj.result == "error" && resultObj.code == "file_error") {
			 openDialog(null, null, 300, "<spring:message code='DVIC_ADMN_CSV_DES02' />");
		}
		else if(resultObj.result == "error" && resultObj.code == "data_error") {
			 openDialog(null, null, 300, "<spring:message code='DVIC_ADMN_CSV_DES03' />");
		}
		else {
			$("#CSVFILE").val("");
			$("#grid").trigger("reloadGrid", [{page:1}]);
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
				<li><label for="tcate01"><spring:message code="DVIC_ADMN_LIST_TXT06" /></label>
				<span>
				 <select id="CONTROLSTATUS" name="CONTROLSTATUS" class="ipt02">
					<option value=""><spring:message code="LOGS_SEARCH_BOX_CMB01" /></option>
					<option value="1"><spring:message code="DVIC_ADMN_LIST_CMB03" /></option>
					<option value="0"><spring:message code="DVIC_ADMN_LIST_CMB04" /></option>
		    	</select> 
				</span>
				</li>
			</ul>
			<ul class="cate_left">
				<li><label for="tcate05"><spring:message code="DVIC_ADMN_LIST_TXT01" /></label>
				<span>
				<input type="text" name="EMPLOYEENO" class="ipt01" />
				</span>
				</li>
				<li><label for="tcate04"><spring:message code="DVIC_SEL_NONE_LST02" /></label>
				<span>
				<input type="text" name="EMPLOYEENAME" class="ipt01"  /> 
				</span>
				</li>
				<li>
				<label for="tcate04" style="padding-top: 0;">
				<select name="phoneMac" class="keyword">
					<option value="PHONE"><spring:message code="DVIC_SEARCH_BOX_CMB01" /></option>
					<option value="MAC"><spring:message code="DVIC_SEARCH_BOX_CMB02" /></option>
				</select>
				</label> 
				<span>
				<input type="text" name="phoneMac" class="param ipt01" /> 
				</span>
				</li>
				<li><label for="tcate07"><spring:message code="DVIC_SEL_NONE_LST05" /></label>
				<span>
				<input type="text" name="EMAIL" class="ipt01"  /> 
				</span>
				</li>
				<li><label for="tcate09"><spring:message code="DVIC_SEL_NONE_LST03" /></label>
				<span>
				<input type="text" name="DEPARTMENT" class="ipt01"  />
				</span>
				</li>
				<li><label for="tcate06"><spring:message code="DVIC_SEL_NONE_LST04" /></label>
				<span>
				<input type="text" name="POSITION" class="ipt01"  />
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
<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="gridTotalCnt"></p>
		<div class="oBtn">
			<span class="buttonSg"><a id="csvRegButton" href="#"><spring:message code="DVIC_ADMN_CSV_TTL01" /></a></span>
			<span class="buttonS"><a id="addButton" href="#"><spring:message code='COM_BTN_ADD' /></a></span>
			<span class="buttonS"><a id="deleteButton" href="#"><spring:message code='COM_BTN_DELETE' /></a></span>
			&nbsp;&nbsp;&nbsp;
			<span class="buttonS"><a id="regMobileButton" href="#"><spring:message code='DVIC_ADMN_LIST_BTN01' /></a></span>
			<span class="buttonS"><a id="relMobileButton" href="#"><spring:message code='DVIC_ADMN_LIST_BTN02' /></a></span>
		</div>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>
<!-- 
<div class="entry_query_wrap" style="padding-top: 0px;">
	<div class="btn">
		<span class="buttonLg strong"><a id="csvRegButton" href="#"><spring:message code="DVIC_ADMN_CSV_TTL01" /></a></span>
	</div>
</div>
 -->
<!-- csv 등록 다이얼로그 -->
<div id="csvRegDialog" style="display: none;">
	<form id="frmCSVFile" name="frmCSVFile" method="post" enctype="multipart/form-data">
		<h2>&nbsp;</h2>
		<div><spring:message code='DVIC_ADMN_CSV_TXT01' /></div>
		<div id="CSVFile_div"><input type="file" size="30" name="CSVFILE" id="CSVFILE" style="background: none repeat scroll 0 0 #313131; border: 1px solid #000000;" /></div>
	</form>
</div>

<!-- 장비 등록 다이얼로그 -->
<div id="mobileInsertDialog" style="display:none;height: auto;" >
	<div id="editcntgrid" class="ui-jqdialog-content">
	<table id="TblGrid_grid" class="EditTable" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<!-- 에러 화면 -->
			<tr id="FormError">
				<td class="ui-state-error" colspan="2"><spring:message code="DVIC_ADMN_ADD_DES01" /></td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_ADMN_LIST_TXT01" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content engNumForm" type="text" name="IN_EMPLOYEENO" id="IN_EMPLOYEENO" maxlength="20" />
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_SEL_NONE_LST02" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content required" type="text"name="IN_EMPLOYEENAME" id="IN_EMPLOYEENAME" maxlength="12" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_SEL_NONE_LST01" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content required phoneForm" type="text" name="IN_PHONE" id="IN_PHONE" maxlength="17" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_SEL_NONE_LST04" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content" type="text" name="IN_POSITION" id="IN_POSITION" maxlength="16" />
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_SEL_NONE_LST03" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content" type="text" name="IN_DEPARTMENT" id="IN_DEPARTMENT" maxlength="30" />
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_SEL_NONE_LST05" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content required emailForm" type="text" name="IN_EMAIL" id="IN_EMAIL" maxlength="100" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
</div>