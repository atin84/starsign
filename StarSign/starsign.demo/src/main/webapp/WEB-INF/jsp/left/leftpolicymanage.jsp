<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/ui.jqgrid2.css" />" type="text/css" />

<script type="text/javascript">
<!--
	$(document).ready(function() {
		// 다국어 지원을 위한 초기화
		init(initPolicyManage);
	});
	/**
	 * 정책관리 초기화
	 */
	function initPolicyManage() {
		$("#leftgrid").jqGrid({
			url: gridPath + 'listGrid.policyList',
			editurl : gridEditPath + 'policyInfo.do', 
			datatype: 'json',
				colNames:['<spring:message code="PLCY_ADD_TXT01" />',
				          '', '', '', ''],
				colModel:[
					{
						title:false, 
						name:'POLICYNAME',
						index:'POLICYNAME',
						editable: true,
						editrules:{required:true},
						//formoptions:{elmsuffix:required},
						editoptions:{size:12, maxlength: 12},
						align:'left',
						width:120
					},
					{title:false, name:'ACTION',index:'ACTION', sortable:false, width:90, align:'center'},
					{title:false, name:'POLICYID',index:'POLICYID', key: true, hidden: true},
					{title:false, name:'CNT',index:'CNT', hidden: true},
					{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden: true}
				],
			sortname: 'POLICYID', sortorder: "asc", height:'100%', width:210, rowNum:100000000,
			gridComplete: function() { 
				// 그리드 색상 입히기
				initGridUI("leftgrid", true);
				
				// 정책 컬럼 숨기기
				$('.ui-jqgrid-hdiv').hide();
				
				var ids = $("#leftgrid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i]; 
					if(cl != 0) {
						var imgDel = "<img src=\"<c:url value='/resources/image/bt_del.gif' />\" />";
						var imgModify = "<img src=\"<c:url value='/resources/image/bt_modify.gif' />\" />";
						//var be = "<a href='javascript:editLeftAction(\"" + cl + "\");' class='md'>수정</a> "; 
						//var se = "<a href='javascript:deleteLeftAction(\"" + cl + "\");' class='dl'><spring:message code='COM_BTN_DELETE' /></a>";  
						var be = "<a href='javascript:editLeftAction(\"" + cl + "\");' class='md'>" + imgModify + "</a> ";
						var se = "<a href='javascript:deleteLeftAction(\"" + cl + "\");' class='dl'>" + imgDel + "</a>";
						$("#leftgrid").jqGrid('setRowData', ids[i], {"ACTION":be+se}); 
					}
				} 
				// 기본정책 선택하기
				$("#leftgrid").jqGrid('setSelection', '0');
			},
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell"
			},
			onSelectRow : function(id) {
				var ref = jQuery("#leftgrid").jqGrid('getRowData', id);
				
				//선택한 Row 색상 처리
				highlighGridRow('leftgrid', ref.POLICYID, 'POLICYID');
				
				createDetailPolicyInfo(ref.POLICYID);
			}
		});
	}
	/**
	 * 정책 추가하기
	 */
	function addLeftAction() {
		$("#leftgrid").jqGrid('editGridRow',"new", {
			reloadAfterSubmit:true, closeAfterAdd:true, recreateForm:true,
			beforeShowForm: function(form) {
				// 추가하기 타이틀 설정
				gridEditFormInit("<spring:message code='PLCY_ADD_TTL01' />");
			},
			afterComplete: function(response, postdata, formid) {
				if (postdata.oper === "add") {
					selectAddRow();
		        }
			},
			beforeSubmit : function(postdata, formid) {
				//중복 검사
				var ids = $("#leftgrid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					
					var ret = jQuery("#leftgrid").jqGrid('getRowData', cl);
					
					if(postdata["POLICYNAME"] == ret.POLICYNAME) {
						return [false, "<spring:message code='PLCY_ADD_DES01' />"];
					}
				}
				
				return [true, ""];
			}
		});
	}
	
	function selectAddRow() {
		var ids = $("#leftgrid").jqGrid('getDataIDs');
		var maxRowID = 0;
		for(var i=0;i < ids.length;i++){ 
			var cl = ids[i];
			if(parseInt(maxRowID) < parseInt(cl)) {
				maxRowID = cl;
			}
		}
		
		jQuery("#leftgrid").jqGrid('setSelection', maxRowID);
	}
	/**
	 * 정책 수정하기
	 */
	function editLeftAction(id) {
		if( id != null ) {
			$("#leftgrid").jqGrid('editGridRow',id, {
				reloadAfterSubmit:true, closeAfterEdit:true, recreateForm:true,
				beforeShowForm: function(form) {
					// 수정하기 타이틀 설정
					gridEditFormInit("<spring:message code='PLCY_MODIFY_TTL01' />"); 
				},
				beforeSubmit : function(postdata, formid) {
					//중복 검사
					var ids = $("#leftgrid").jqGrid('getDataIDs');
					for(var i=0;i < ids.length;i++){ 
						var cl = ids[i];
						
						if(cl != id) {
							var ret = jQuery("#leftgrid").jqGrid('getRowData', cl);
							
							if(postdata["POLICYNAME"] == ret.POLICYNAME) {
								return [false, "<spring:message code='PLCY_ADD_DES01' />"];
							}
						}
					}
					
					return [true, ""];
				}
			});
		}
		else 
			openDialog("checkAlertDialog", null, null, "GROUP");
	}
	/**
	 * 정책 삭제하기
	 */
	function deleteLeftAction(id) {
		if( id != null ) {
			var ref = jQuery("#leftgrid").jqGrid('getRowData', id);
			if(ref.CNT > 0) {
				openDialog("errorPolicyDeleteDialog", null, 300);
			}
			else {
				$("#leftgrid").jqGrid('delGridRow',id,{reloadAfterSubmit:true,
					beforeShowForm: function(form) {
						// 삭제하기 타이틀 설정
					}
				});
			}
		}
		else 
			openDialog("checkAlertDialog", null, null, "GROUP");
	}
//-->
</script>
<div class="list_group">
	<h2><spring:message code="PLCY_TTL01" /></h2>
	<div class="tp">
		<span class="count" id="leftgridTotalCnt"></span>
		<span class="buttonS btn">
			<a href="javascript:addLeftAction();">
			<spring:message code='COM_BTN_ADD' />
			</a>
		</span>
	</div>
	<div class="pgroup_list">
		<div class="scroll">
		<div id="leftjqgrid">
			<table id="leftgrid"></table>
		</div>
		</div>
	</div>
</div>