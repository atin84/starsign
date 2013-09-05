<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>

<link rel="stylesheet" href="<c:url value="/resources/css/ui.jqgrid2.css" />" type="text/css" />

<fmt:bundle basename="com.anlab.v3me.admin.config.i18n.resourceMessage">
<script type="text/javascript">
	$(document).ready(function() {
		// 다국어 지원을 위한 초기화
		init(initNetwork);
	});

	function initNetwork() {
		$("#leftgrid").jqGrid({
			url: gridPath + 'listGrid.wifiListInfoAll',
			editurl : gridEditPath + 'wifiListInfo.do',
			datatype: 'json',
				colNames:['WIFILISTINFOID', 
				          '<spring:message code="NTWK_GRUP_ADD_TXT01" />',
				          'WIFICNT', '', ''],
				colModel:[
					{title:false, name:'WIFILISTINFOID',		index:'WIFILISTINFOID', 	key:true, sortable:true, hidden:true},
					{
						title:false, 
						name:'WIFILISTINFONAME',
						index:'WIFILISTINFONAME', 	
						sortable:false,
						editable:true,
						editrules:{required:true},
						//formoptions:{elmsuffix:required},
						editoptions: {size:12, maxlength: 12},
						align:'left',
						width:120
					},
					{title:false, name:'WIFICNT',			index:'WIFICNT', sortable:false, editable:false, hidden:true},
					{title:false, name:'ACTION',			index:'ACTION',	 sortable:false, width:90, align:'center'},
					{title:false, name:'TOTALCNT',			index:'TOTALCNT', hidden:true}
				],
			sortname: 'WIFILISTINFOID', viewrecords: false, sortorder: "asc", height:'100%', width:210, rowNum:100000000,
			loadComplete: function() {
			},
			gridComplete: function() {
				//그리드 초기화
				initGridUI("leftgrid", true);
				
				// WIFI White 그룹 목록 컬럼 숨기기
				$('.ui-jqgrid-hdiv').hide();
				
				//WIFI 허용 그룹 목록 중에서 '전체' 첫번째 목록에 다국어 적용
				$('#leftgrid tr td').each(function(i, obj) {
					if(i == 6 && $(obj).attr('aria-describedby') == 'leftgrid_WIFILISTINFONAME'){
						$(obj).text($.i18n.prop("NTWK_GRUP_TXT01"));
					}
				});
				
				var ids = $("#leftgrid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					//전체 그룹은 ACTION 버튼을 보여주지 않는다
					if(cl == 0) {
						selectRow(cl);
					}
					else {
						var imgDel = "<img src=\"<c:url value='/resources/image/bt_del.gif' />\" />";
						var imgModify = "<img src=\"<c:url value='/resources/image/bt_modify.gif' />\" />";
						//var be = "<a href='javascript:editLeftAction(\"" + cl + "\");' class='md'>수정</a> "; 
						//var se = "<a href='javascript:deleteLeftAction(\"" + cl + "\");' class='dl'><spring:message code='COM_BTN_DELETE' /></a>";  
						var be = "<a href='javascript:editLeftAction(\"" + cl + "\");' class='md'>" + imgModify + "</a> "; 
						var se = "<a href='javascript:deleteLeftAction(\"" + cl + "\");' class='dl'>" + imgDel + "</a>";  
						$("#leftgrid").jqGrid('setRowData', ids[i], {"ACTION":be+se});
					}
				}
			},
			onSelectRow: function(id){
				//선택한 WIFI 그룹에 속한 WIFI 목록으로 오른쪽 리스트를 갱신
				var ret = jQuery("#leftgrid").jqGrid('getRowData', id);
	
				getWifiInfoList(ret.WIFILISTINFOID, ret.WIFILISTINFONAME);
				
				highlighGridRow('leftgrid', ret.WIFILISTINFOID, 'WIFILISTINFOID');
			  },
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell",
				id: "WIFILISTINFOID"
			}
		});
	}
	
	function selectRow(id) {
		jQuery("#leftgrid").jqGrid('setSelection', id);
	}
	function addLeftAction() {
		$("#leftgrid").jqGrid('editGridRow',"new", {
			reloadAfterSubmit:true, closeAfterAdd:true, recreateForm:true,
			beforeShowForm: function(form) {
				gridEditFormInit($.i18n.prop("NTWK_GRUP_ADD_TTL01"));
			},
			beforeSubmit : function(postdata, formid) {
				//중복 검사
				var ids = $("#leftgrid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					
					var ret = jQuery("#leftgrid").jqGrid('getRowData', cl);
					
					if(postdata["WIFILISTINFONAME"] == ret.WIFILISTINFONAME) {
						return [false, "<spring:message code='NTWK_GRUP_ADD_DES01' />"];
					}
				}
				
				return [true, ""];
			}
		});
	}
	function editLeftAction(id) {
		if( id != null ) {
			$("#leftgrid").jqGrid('editGridRow',id, {
				reloadAfterSubmit:true, closeAfterEdit:true, recreateForm:true,
				beforeShowForm: function(form) {
					gridEditFormInit($.i18n.prop("NTWK_GRUP_MODIFY_TTL01"));
				},
				beforeSubmit : function(postdata, formid) {
					//중복 검사
					var ids = $("#leftgrid").jqGrid('getDataIDs');
					for(var i=0;i < ids.length;i++){ 
						var cl = ids[i];
						
						if(cl != id) {
							var ret = jQuery("#leftgrid").jqGrid('getRowData', cl);
							
							if(postdata["WIFILISTINFONAME"] == ret.WIFILISTINFONAME) {
								return [false, "<spring:message code='NTWK_GRUP_ADD_DES01' />"];
							}
						}
					}
					
					return [true, ""];
				} 
			});
		}
		else
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
	}
	function deleteLeftAction(id) {
		if( id != null ) {
			//WIFI 그룹 내에 속한 WIFI 리스트가 존재하는지 체크
			var rowData = jQuery("#leftgrid").jqGrid('getRowData', id);
			var wifiCnt = 0;
			if( rowData['WIFICNT'] )
				wifiCnt = parseInt(rowData['WIFICNT']);
			
			if( wifiCnt > 0 )
				openDialog("noticeWifiDialog", null, 300);
			else
				openDialog("deleteWifiDialog", getDeleteAppButtonAction(id), 350);
				//$("#leftgrid").jqGrid('delGridRow',id,{reloadAfterSubmit:false});
		}
		else 
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
	}
	
	function getDeleteAppButtonAction(id) {
		 var button = {
				 "<spring:message code='COM_BTN_YES' />" : function() {
					var service = {};
					var data = {};
					var policyData = {};
					
					data["WIFILISTINFOID"] = id;
					data["ACTION"] = "delete.wifiListInfo";
					
					policyData["WIFILISTINFOID"] = id;
					policyData["ACTION"] = "update.policyInfoWifiListInfo";
			
					service["policyUpdate"] = policyData;
					service["wifiListInfoDelete"] = data;
					
					doAction(service, function(result) {														
						refreshAction();
					});
					
					$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_NO' />" : function() {
					$(this).dialog("close");
				}
			 };

			 return button;
	}
	
	function refreshAction() {
		$("#leftgrid").jqGrid({
			url: gridPath + 'listGrid.wifiListInfoAll',
			page:1, rows:25
		}).trigger("reloadGrid");
	}
</script>
<div class="list_group">
	<h2><spring:message code="NTWK_GRUP_TTL01" /></h2>
	<div class="tp">
	<span class="count" id="leftgridTotalCnt"></span>
	<span class="buttonS btn"><a href="javascript:addLeftAction();"><spring:message code='COM_BTN_ADD' /></a></span>
	</div>
	<div class="pgroup_list">
		<div class="scroll">
		<div class="item_list">
		<div id="leftjqgrid">
			<table id="leftgrid"></table>
		</div>
		</div>
		</div>
	</div>
</div>

<div id="noticeWifiDialog" title="알림" style="width: 300; display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="NTWK_GRUP_DEL_DES01" /></p>
	</li>
	</ul>
</div>
<div id="deleteWifiDialog" title="알림" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code='PLCY_GRUP_DEL_DES01' /></p>
	</li>
	</ul>
</div>

</fmt:bundle>