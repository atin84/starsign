<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var currentGroupId = null;
	var currentPolicyId = null;
	var currentDeviceId = null;
	$(document).ready(function() {
		$("#tabs").tabs();

		// 검색 하기
		$("#searchButton").click(function() {
			// 검색 조건 리셋
			resetSearchParam("importgrid");
			var object = getSearchParam($("#searchDiv div ul li :input"), "IMPORT_");
			//object['NOTGROUPID'] = currentGroupId;
			$("#importgrid").jqGrid('setGridParam', {
				url: gridPath + 'listGrid.mobileDeviceControl&NOTGROUPID=' + currentGroupId,
				postData:object
			}).trigger("reloadGrid", [{page:1}]);
		});

		// 검색 조건 리셋
		$("#resetButton").click(function() {
			resetSearchData($("#searchDiv div ul li :input"));
		});

		// 현재 정책 그룹에 속해 있지 않은 단말기 가져오기
		$("#import").click(function() {
			onClickImportEvent();
		});

		// 단말기 내보내기 클릭 액션
		$("#export").click(function() {
			onClickExportEvent();
		});

		// 정책 상세보기
		$("#detailPolicy").click(function() {
			if($("#policyCombo").val() != "") {
				makeDetailPolicyInfo($("#policyCombo").val(), true);
				openDialog("policyContentHiddenDiv", null, 700, null, $("#policyCombo option:selected").text());	
			}
			else {
				openDialog("checkAlertDialog", null, null, "GROUP");
			}
		});
		// 그룹에 정책 할당하기
		$("#updatePolicy").click(function() {
			var action = {
				"<spring:message code='COM_BTN_YES' />"	 : function() {
					var policy = {};
					var policyParam = {};
					var policyUpdateTime = {};
					policyParam["ACTION"] = "update.policyGroup";
					policyParam["GROUPID"] = currentGroupId;
					policyParam["POLICYID"] = $("#policyCombo").val();
					
					policyUpdateTime["ACTION"] = "update.policyInfo";
					policyUpdateTime["POLICYID"] = $("#policyCombo").val();
					
					policy["policyUpdate"] = policyParam;
					policy["policyUpdateTime"] = policyUpdateTime;
					doAction(policy, function(result) {
						$("#leftjqgrid").html('<table id="leftgrid"></table>');
						initPolicyGroup();
						// 다이얼로그 창 닫기
						$("#checkAlertDialog").dialog("close");
					});	
				},
				"<spring:message code='COM_BTN_NO' />" : function() {
					$(this).dialog("close");
				}
			};
			
			var selCombo = $("#policyCombo").val();
			
			if(selCombo != '') {
				openDialog("checkAlertDialog", action, 300, '<spring:message code="PLCY_GRUP_APPLY_DES01" />');
			}
			else
				openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
		});
		
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
		
	});
	/**
	 * 정책 그룹 목록을 선택 했을때 우측 레이아웃에서 해야 하는 일들
	 */
	function createDetailPolicyGroupInfo(groupId, policyId, groupName) {
		currentGroupId = groupId;
		currentPolicyId = policyId;
		
		// 모든 정책 목록 가져오기
		var service = {};
		var param = {};
		param["ACTION"] = 'list.policyCombo';
		service["policyCombo"] = param;
		// 정책 가져오기
		addOption(service, false, function() {
			$("#policyCombo").val(currentPolicyId);
			//$("#policyNameTitle").html(groupName + '');
			$("#policyNameTitle").html(groupName);
		});
		
		// 선택한 정책 그룹에 속한 장비 목록 가져오기
		$("#jqgrid").html('<table id="grid"></table><div id="pager"></div>');
		mobileDeviceListForGrid("grid", "pager", groupId, false, 740, 488);
	}
	/**
	 * 단말기 가져오기 클릭시 이벤트 처리
	 */
	function onClickImportEvent() {
		// Combo 채우기
		var service = {};
		// 그룹 콤보 채우기
		var group = {};
		// 정책 콤보 채우기
		var policy = {};

		group["ACTION"] = "list.policyGroupCombo";
		policy["ACTION"] = "list.policyCombo";
		// 현재 선택된 정책 그룹 ID는 제회
		group["NOTGROUPID"] = currentGroupId;
		
		service["IMPORT_GROUPID"] = group;
		service["IMPORT_POLICYID"] = policy;
		// Ajax로 콤보 채우기
		addOption(service, true, function() {
			$("#importjqgrid").html('<table id="importgrid"></table><div id="importpager"></div>');
			mobileDeviceListForGrid("importgrid", "importpager", '&NOTGROUPID=' + currentGroupId, true, 980);
			
			// 장비 등록 다이얼로그 띄우기
			var action = {
				"<spring:message code='COM_BTN_OK' />" : function() {
					if($("#importgrid").jqGrid('getGridParam','selarrrow') == 0) {
						openDialog("checkAlertDialog", null, null, "DEVICE");
						return false;	
					}
					var service = {};
					var data = {};
					var deviceIdList = new Array();
					
					var s = $("#importgrid").jqGrid('getGridParam','selarrrow');
					for(var i=0 ; i < s.length ; i++) {
						var ret = jQuery("#importgrid").jqGrid('getRowData', s[i]);
						if(ret.DEVICEID) {
							deviceIdList.push(ret.DEVICEID);
						}
			 		}
					data["ACTION"] = "update.mobileDevice";
					data["DEVICEIDLIST"] = deviceIdList;
					
					data["GROUPID"] = currentGroupId;
	
					service["mobileUpdate"] = data;
	
					if(deviceIdList.length != 0) {
						doAction(service, function(result) {
							$("#grid").trigger("reloadGrid");
						});
					}
					$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					resetSearchData($("#searchDiv div ul li :input"));
					$(this).dialog("close");
				}
			};
			openDialog("importDialog", action, 1000, null, "<spring:message code='PLCY_GRUP_IMPORT_TTL01' />");
		});
	}
	/**
	 * 단말기 내보내기 클릭시 이벤트 처리
	 */
	function onClickExportEvent() {
		// 선택된 장비가 없으면 경고 메시지 출력
		if($("#grid").jqGrid('getGridParam','selarrrow').length == 0) {
			openDialog("checkAlertDialog", null, null, "DEVICE");
			return false;
		}
		// 콤보 채워넣기
		var service = {};
		var data = {};
		data["ACTION"] = "list.policyGroupCombo";
		// 현재 선택된 정책 그룹 ID는 제회
		data["NOTGROUPID"] = currentGroupId;
		service["exportCombo"] = data;
		addOption(service, false, function() {
			// 콤보 채우고 난 이후에 명령 수행
			var action = {
				"<spring:message code='COM_BTN_OK' />" : function() {
					if($("#exportCombo").val() == "") {
						openDialog("checkAlertDialog", null, null, "GROUP");
					}
					else {
						var service = {};
						var data = {};
						var deviceIdList = new Array();

						var s = $("#grid").jqGrid('getGridParam','selarrrow'); 

						for(var i=0 ; i < s.length ; i++) {
							var ret = jQuery("#grid").jqGrid('getRowData', s[i]);
							if(ret.DEVICEID) {
								deviceIdList.push(ret.DEVICEID);
							}
				 		}
						data["ACTION"] = "update.mobileDevice";
						data["DEVICEIDLIST"] = deviceIdList;
						
						data["GROUPID"] = $("#exportCombo").val();
		
						service["mobileUpdate"] = data;
		
						if(deviceIdList.length != 0) {
							doAction(service, function(result) {
								$("#grid").trigger("reloadGrid");
							});
						}
						$(this).dialog("close");
					}
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					$(this).dialog("close");
				}
			};

			openDialog("exportDialog", action, 300, null, "<spring:message code='PLCY_GRUP_EXPORT_TTL01' />");
		});
	}
	/*
	 * 모바일 장비 목록 가져오기
	 */
	function mobileDeviceListForGrid(divId, pagerId, query, isShrinkToFit, width, height) {
		if(!height) {
			height = "100%";
		}
		$("#" + divId).jqGrid({
			url: gridPath + 'listGrid.mobileDeviceControl&GROUPID=' + query,
			datatype: 'json',
				colNames:['<spring:message code="DVIC_SEL_NONE_LST01" />',
				          '<spring:message code="DVIC_SEL_NONE_LST02" />',
				          '<spring:message code="DVIC_SEL_NONE_LST03" />',
				          '<spring:message code="DVIC_SEL_NONE_LST04" />',
				          '<spring:message code="DVIC_SEL_NONE_LST05" />',
				          '<spring:message code="DVIC_SEL_NONE_LST06" />',
				          '<spring:message code="DVIC_SEL_NONE_LST07" />',
				          //'',
				          '', '', '', '', '', '', '', ''],
				colModel:[
					{title:false, name:'PHONE',index:'PHONE', editable: true, width:150, align:'left'},
					{title:false, name:'EMPLOYEENAME',index:'EMPLOYEENAME', width:120, align:'left'},
					{title:false, name:'DEPARTMENT',index:'DEPARTMENT', width:110, align:'left'},
					{title:false, name:'POSITION',index:'POSITION', width:110, align:'left'},
					{title:false, name:'EMAIL',index:'EMAIL', width:150, align:'left'},
					{title:false, name:'POLICYNAME',index:'POLICYNAME', width:120, align:'left'},
					{title:false, name:'GROUPNAME',index:'GROUPNAME', width:120, align:'left'},
					//{title:false, name:'ACTION',index:'ACTION', width:80, sortable:false, align:'center'},
					{title:false, name:'DEVICEID',index:'DEVICEID', key:true, hidden:true},
					{title:false, name:'GROUPID',index:'GROUPID', hidden:true},
					{title:false, name:'POLICYID',index:'POLICYID', hidden:true},
					{title:false, name:'WHITEAPPID',index:'WHITEAPPID', hidden:true},
					{title:false, name:'WIFILISTINFOID',index:'WIFILISTINFOID', hidden:true},
					{title:false, name:'RESETSTATUS',index:'RESETSTATUS', hidden:true},
					{title:false, name:'CONTROLSTATUS',index:'CONTROLSTATUS', hidden:true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
				],
			sortname: 'EMPLOYEENAME', sortorder: "desc", rowNum:25, height:"100%", shrinkToFit :isShrinkToFit, width: width,
			pager: '#' + pagerId, multiselect: true, viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			multiselect: true,
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			loadComplete: function() {
				$("#" + divId).jqGrid ('setLabel', 'PHONE', '', {'text-align':'left'});
				$("#" + divId).jqGrid ('setLabel', 'EMPLOYEENAME', '', {'text-align':'left'});
				$("#" + divId).jqGrid ('setLabel', 'DEPARTMENT', '', {'text-align':'left'});
				$("#" + divId).jqGrid ('setLabel', 'POSITION', '', {'text-align':'left'});
				$("#" + divId).jqGrid ('setLabel', 'EMAIL', '', {'text-align':'left'});
				$("#" + divId).jqGrid ('setLabel', 'POLICYNAME', '', {'text-align':'left'});
				$("#" + divId).jqGrid ('setLabel', 'GROUPNAME', '', {'text-align':'left'});
			},
			gridComplete: function() {
				// 코드 적용
				$('#grid tr td').each(function(i, obj) {
					codeAlias("grid", $(obj).attr('aria-describedby'), obj);
				});
				
				var ids = $("#" + divId).jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var ref = jQuery("#" + divId).jqGrid('getRowData', cl);
					var edit;
					edit = "<a href='javascript:detailDeviceInfo(\"" + divId +"\", \"" + ref.DEVICEID + "\");' class='md'>" + ref.PHONE + "</a> ";
					$("#" + divId).jqGrid('setRowData', ids[i], {"PHONE":edit});
				}
				initGridUI(divId);
			}
		}).trigger("reloadGrid");
	}
	/*
	 * 장비 상세보기
	 */
	function detailDeviceInfo(divId, deviceId) {
		var ref = jQuery("#" + divId).jqGrid('getRowData', deviceId);
		// 값 설정
		currentDeviceId = ref.DEVICEID;
		createDeviceManageTab(ref.DEVICEID, ref.WIFILISTINFOID, ref.RESETSTATUS, ref.CONTROLSTATUS, null);
		// 다이얼로그 오픈
		$("#tabs").tabs("select", 0);
		openDialog("detailDeviceDialog", null, 600);
	}
</script>

<h2 class="h2_title03" id="policyNameTitle"></h2>
<h3 class="h3_title01"><spring:message code="PLCY_GRUP_BASE_TTL01" /></h3>
<!-- 검색설정 -->
<div class="detail_view01">
	
	<fieldset class="search_ct"> 
		<legend >상세검색</legend>
		<select id="policyCombo">
			<!-- <option value="">선택한 정책 그룹이 없습니다.</option> -->
		</select>
		<a href="#" id="detailPolicy"><spring:message code="COM_LNK_DETAIL" /></a>
	</fieldset>
	<div class="btn">
		<span class="buttonS"><a href="#" id="updatePolicy"><spring:message code="COM_BTN_APPLY" /></a></span>
	</div>
</div>


				
<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="gridTotalCnt"></p>
		<div class="oBtn">
			<span class="buttonS"><a href="#" id="export"><spring:message code='PLCY_GRUP_BASE_BTN02' /></a></span>
			<span class="buttonS"><a href="#" id="import"><spring:message code='PLCY_GRUP_BASE_BTN03' /></a></span>								
		</div>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>

<!-- Popup Layer -->
<!-- import Dialog -->
<div id="importDialog" title="단말기 가져오기" style="display:none">
	<div class="search_cate_wrap">
		<p class="openBtn" id="searchHideButton"><spring:message code="DVIC_SEL_NONE_TXT01" /></p>
		<!-- s: content -->
		<div class="con" id="searchDiv">
			<div class="search_cate">
				<ul>
					<li><label for="tcate01"><spring:message code="DVIC_SEL_NONE_LST07" /></label>
					<span>
						<select id="IMPORT_GROUPID" name="IMPORT_GROUPID"></select> 
					</span>
					</li>
					<li><label for="tcate02"><spring:message code="DVIC_SEL_NONE_LST06" /></label>
					<span>
						<select id="IMPORT_POLICYID" name="IMPORT_POLICYID"></select>
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
						<span><input type="text" name="IMPORT_EMPLOYEENAME" class="ipt01"  /></span>
					</li>
					<li><label for="tcate05"><spring:message code="DVIC_SEL_NONE_LST03" /></label>
						<span><input type="text" name="IMPORT_DEPARTMENT" class="ipt01"  /></span>
					</li>
					<li><label for="tcate06"><spring:message code="DVIC_SEL_NONE_LST04" /></label>
						<span><input type="text" name="IMPORT_POSITION" class="ipt01"  /></span>
					</li>
					<li><label for="tcate07"><spring:message code="DVIC_SEL_NONE_LST05" /></label>
						<span><input type="text" name="IMPORT_EMAIL" class="ipt01"  /></span>
					</li>
				</ul>
			</div>
			<div class="search_btn">
				<span class="buttonS" id="resetButton"><a href="#"><spring:message code="COM_BTN_RESET" /></a></span>
				<span class="buttonSg" id="searchButton"><a href="#"><spring:message code="COM_BTN_SEARCH" /></a></span>
			</div>
		</div>
	</div>
	<h2 class="h2_title03"><spring:message code="PLCY_GRUP_IMPORT_DES01" /></h2>
	<div class="report_table_wrap">
		<p class="data_count" id="importgridTotalCnt"></p>
		<div class="con">
			<div id="importjqgrid">
				<table id="grid"></table>
				<div id="pager"></div>
			</div>
		</div>
	</div>
</div>

<!-- export Dialog -->
<div id="exportDialog" style="display:none">
	<spring:message code='PLCY_GRUP_ADD_TXT01' /><select id="exportCombo"></select>
</div>