<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<fmt:bundle basename="com.anlab.v3me.admin.config.i18n.resourceMessage">
<script type="text/javascript">

</script>
<script type="text/javascript">
	var v3meAgent = '${v3meAgent}';
	var v3meClient = '${v3meClient}';
	var isHide = false;
	
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
 	
	$(document).ready(function() {
		
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
				$("#searchHideButton img").attr("alt", '');
			}
			else {
				$("#searchDiv").hide("blind");
				isHide = true;
				$("#searchHideButton img").attr("src", '<c:url value="/resources/image/bul_open01.gif" />');
				$("#searchHideButton img").attr("alt", '');
			}
		});
		*/
		
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
		
		// 다국어 지원을 위한 초기화
		init(initApp);
	});
	
	
	function initApp() {

		var grid = $("#grid");
		grid.jqGrid({
			url: gridPath + 'listGrid.whiteApp',
			datatype: 'json',
				colNames:['WhiteAppId',
				          '<spring:message code="APPS_LST01" />',
				          '<spring:message code="APPS_LST02" />',
				          '<spring:message code="APPS_LST03" />',
				          '<spring:message code="APPS_LST06" />',
				          '<spring:message code="APPS_LST04" />',
				          '<spring:message code="APPS_LST05" />',
				          'INSTALLCNT', 'DEVICECOUNT',
				          '', ''],
				colModel:[
					{title:false, name:'WHITEAPPID',	index:'WHITEAPPID', 	hidden:true},
					{title:false, name:'APPNAME',		index:'APPNAME', 		hidden:false, width: 200, align:"left", },
					{title:false, name:'PKGNAME',		index:'PKGNAME', 		hidden:false, width: 200, align:"left", key:true },
					{title:false, name:'APPVERSION',	index:'APPVERSION', 	hidden:false, width: 105, align:"center", },
					{title:false, name:'VERSIONCODE',	index:'VERSIONCODE', 	hidden:true,  align:"center"},
					{title:false, name:'FILENAME',		index:'FILENAME', 		hidden:false, width: 250, align:"left"},
					{title:false, name:'STATUS',		index:'STATUS', 		hidden:false, sortable:false, width: 159, align:"left"},
					{title:false, name:'INSTALLCNT',	index:'INSTALLCNT', 	hidden:true},
					{title:false, name:'DEVICECNT',		index:'DEVICECNT', 		hidden:true},
					{title:false, name:'ACTION',		index:'ACTION', 		hidden:false, sortable:false, width: 39, align:"center"},
					{title:false, name:'TOTALCNT',		index:'TOTALCNT', 		hidden:true}
				],
			sortname: 'APPNAME', sortorder: "asc", rowNum:25, height:"100%", width:978, scrollOffset:0, 
			viewrecords:true, emptyrecords: "<spring:message code='COM_LST_DES01' />",
			loadComplete: function() {
				$("#grid").jqGrid ('setLabel', 'APPNAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'PKGNAME', '', {'text-align':'left'});
				$("#grid").jqGrid ('setLabel', 'FILENAME', '', {'text-align':'left'});
				
				
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var pbId = "pb" + cl;
					
					pbId = pbId.split(".").join("");	//pkgname에서 쩜 제거
					
					var ed = "<div class=\"" + "progressbar\"" + " id=\"" + pbId + "\"></div>";
					$("#grid").jqGrid('setRowData', ids[i], {"STATUS":ed});
					
					var ret = jQuery("#grid").jqGrid('getRowData', cl);
					var sucessRate = 0;
					
					if(ret.INSTALLCNT > 0 && ret.DEVICECNT > 0) {
						sucessRate = roundXL((ret.INSTALLCNT/ret.DEVICECNT)*100, 0);
					}
					else
						sucessRate = 0;
					
					var boxImagePath = "${pageContext.request.contextPath}/resources/image/jquery/progressbar.gif";
					var barImagePath = "${pageContext.request.contextPath}/resources/image/jquery/progressbg_blue.gif";
					
					$("#"+ pbId).progressBar(sucessRate, {steps:0, boxImage: boxImagePath, barImage: barImagePath});
					
					
					//버전 정보와 버전 코드를 합침
					var versionWithCode = ret.APPVERSION + " (" + ret.VERSIONCODE + ")";
					$("#grid").jqGrid('setRowData', cl, {"APPVERSION":versionWithCode});
				}
			},
			gridComplete: function() { 
				initGridUI("grid");
				//특정 Row 체크박스 disabled 처리
				$("#grid tr td").each(function(i, obj) {
					//alert($(obj + " td").html());
					//alert("1 :" + $(obj).html());
					if($(obj).attr('aria-describedby') == 'grid_PKGNAME') {
						if($(obj).text() == v3meAgent || $(obj).text() == v3meClient) {
							var tr = $(obj).parent();
							tr.find(".cbox").attr("disabled", true);
						}
					}
				});
				
				//수정 버튼
				var ids = $("#grid").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i];
					var imgModify = "<img src=\"<c:url value='/resources/image/bt_modify.gif' />\" />";
					//var ed = "<a href='javascript:editAction(\"" + cl + "\");' class='md'>" + 수정 + "</a> ";
					var ed = "<a href='javascript:editAction(\"" + cl + "\");' class='md'>" + imgModify + "</a> ";
					$("#grid").jqGrid('setRowData', ids[i], {"ACTION":ed});
				} 
			},
			beforeSelectRow: function(rowid, e) {
            	if( rowid == v3meAgent || rowid == v3meClient)
            		return false;
            	else
            		return true;
            },
            onSelectAll: function(aRowids,status) {
                if (status) {
                    // uncheck "protected" rows
                    var cbs = $("tr.jqgrow > td > input.cbox:disabled", grid[0]);
                    cbs.removeAttr("checked");

                    //modify the selarrrow parameter
                    grid[0].p.selarrrow = grid.find("tr.jqgrow:has(td > input.cbox:checked)")
                        .map(function() { return this.id; }) // convert to set of ids
                        .get(); // convert to instance of Array
                }
            },
			pager: '#pager',
			multiselect: true,
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				records: "records",
				repeatitems: false,
				cell: "cell",
				id: "PKGNAME"
			}
		});	
	}
	
	function clearFileInputField(tagId) {
	    document.getElementById(tagId).innerHTML = document.getElementById(tagId).innerHTML;
	}
	function addAction() {
		$("#fileAppDialog").attr("title", "관리 어플리케이션 추가");
		
		clearFileInputField("ApkFile_div");
		$("#PKGNAME").attr("value", "");
		$("#VERSIONCODE").attr("value", "");
		
		openDialog("fileAppDialog", getAddAppButtonAction(), 350, null, '<spring:message code="APPS_ADD_TTL01" />');
	}
	function editAction(id) {
		if( id != null ) {
			$("#fileAppDialog").attr("title", "관리 어플리케이션 수정");
			var rowData = jQuery("#grid").jqGrid('getRowData', id);
			
			clearFileInputField("ApkFile_div");
			$("#PKGNAME").attr("value", rowData.PKGNAME);
			$("#VERSIONCODE").attr("value", rowData.VERSIONCODE);
			
			openDialog("fileAppDialog", getEditAppButtonAction(id), 350, null, '<spring:message code="APPS_MODIFY_TTL01" />');
		}
		else 
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
	}
	function deleteAction() {
		var s = $("#grid").jqGrid('getGridParam','selarrrow');
		if(s.length > 0) {
			openDialog("deleteAppDialog", getDeleteAppButtonAction(), 350);	
		}
		else
			openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
	}
	function searchAction() {
		// 검색 조건 리셋
		resetSearchParam("grid");
		var object = getSearchParam();
		$("#grid").jqGrid('setGridParam', {postData:object}).trigger("reloadGrid");
	}
	function refreshAction() {
		$("#grid").jqGrid({
			url: gridPath + 'listGrid.whiteApp',
			page:1, rows:25
		}).trigger("reloadGrid");
	}
	function getAddAppButtonAction() {
		 var button = {
				 "<spring:message code='COM_BTN_OK' />" : function() {
					var result = FileAdd();
					if(result != false)
						$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					$(this).dialog("close");
				}
			 };

			 return button;
	}
	function getEditAppButtonAction(id) {
		 var button = {
				 "<spring:message code='COM_BTN_OK' />" : function() {
					var result = FileUpdate();
					if(result != false)
						$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_CANCEL' />" : function() {
					$(this).dialog("close");
				}
			 };

		return button;
	}
	function getDeleteAppButtonAction() {
		 var button = {
				 "<spring:message code='COM_BTN_YES' />" : function() {
					var service = {};
					var data = {};
					var whiteAppVersion = {};
					var pkgNameList = new Array();
					
					var s = $("#grid").jqGrid('getGridParam','selarrrow');
					for(var i=0 ; i < s.length ; i++) {
						var ret = jQuery("#grid").jqGrid('getRowData', s[i]);
						if(ret.PKGNAME) {
							pkgNameList.push(ret.PKGNAME);
						}
			 		}
					
					data["PKGNAMELIST"] = pkgNameList;
					data["ACTION"] = "delete.whiteApp";

					whiteAppVersion["WHITEAPPID"] = 0;
					whiteAppVersion["ACTION"] = "update.whiteAppVersion";

					service["whiteAppDelete"] = data;
					service["whiteAppVersionUpdate"] = whiteAppVersion;
					
					if(pkgNameList.length != 0) {
						doAction(service, function(result) {														
							refreshAction();
						});
					}
					else {
						openDialog(null, null, 300, $.i18n.prop("ERORR_CHKBOX_DES01"));
					}
					
					$(this).dialog("close");
				},
				"<spring:message code='COM_BTN_NO' />" : function() {
					$(this).dialog("close");
				}
			 };

		return button;
	}
	
	//ajax error check
	$(document).ajaxError(function(event, request){
	   if(request.status==500)
	      alert("데이터 저장시 오류 발생!!");
	   else if (request.status!=200)
		  alert("데이터 저장시 오류 발생!!");
	   }
	);
	
	//파일전송 후 콜백 함수
	function FileuploadCallback(data, state){
		var resultObj = eval("(" + data + ")");
		//alert("result : " + resultObj.result + "\ncode : " + resultObj.code);
		if(resultObj.result == "error" && resultObj.code == "file_error") {
			 //alert("APK 파일에 오류가 있습니다.");
			 openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES02' />");
		}
		else if(resultObj.result == "error" && resultObj.code == "apk_error") {
			 //alert("APK 파일의 Data 형식이 잘못되었습니다.");
			 openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES03' />");
		}
		else if(resultObj.result == "error" && resultObj.code == "db_error") {
			 //alert("APK 파일을 저장하는데 오류가 발생했습니다.");
			 openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES04' />");
		}
		else if(resultObj.result == "error" && resultObj.code == "alreay_exist") {
			 //alert("이미 등록된 응용프로그램입니다.");
			 openDialog(null, null, 300, "<spring:message code='APPS_ADD_ERR_DES01' />");
		}
		else if(resultObj.result == "error" && resultObj.code == "not_equal_package") {
			 //alert("등록된 응용프로그램과 다른 응용프로그램입니다.");
			 openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_ERR_DES02' />");
		}
		else if(resultObj.result == "error" && resultObj.code == "not_high_version") {
			 //alert("이미 등록된 버전보다 같거나 낮은 버전은 등록할 수 없습니다.");
			 openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_ERR_DES01' />");
		}
		else {
			refreshAction();
		}
	}
	
	$(function(){
	   //비동기 파일 전송
	   var frm=$('#frmFile'); 
	 
	   frm.ajaxForm(FileuploadCallback); 
	   frm.submit(function(){return false;}); 
	});
	
	// 파일추가 이벤트
	function FileAdd(){
		if(!$("#ApkFile").val()){
			openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES01' />");
			$("#ApkFile").focus();
			return false;
		}
	   
	   if (!$("#ApkFile").val().match(/\.(apk)$/i)) {
		   openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES01' />");
		   $("#ApkFile").focus();
		   return false;
	   }

	   //파일전송
	   var frm;
	   frm = $('#frmFile'); 

	   frm.attr("action","${pageContext.request.contextPath}/whiteApp/insert.do");
	   frm.submit(); 
	}
	
	// 파일수정 이벤트
	function FileUpdate(){
	   if(!$("#ApkFile").val()){
		   openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES01' />");
	      $("#ApkFile").focus();
	      return false;
	   }
	   
	   if (!$("#ApkFile").val().match(/\.(apk)$/i)) {
		   openDialog(null, null, 300, "<spring:message code='APPS_MODIFY_DES01' />");
		   $("#ApkFile").focus();
		   return false;
	   }
	 
	   //파일전송
	   var frm;
	   frm = $('#frmFile'); 
	   frm.attr("action","${pageContext.request.contextPath}/whiteApp/update.do");
	   frm.submit(); 
	}
</script>
<div class="search_cate_wrap">
	<p class="openBtn" id="searchHideButton">
	<a href="javascript:searchDivShow();">
	<img src="<c:url value="/resources/image/bul_close01.gif" />" alt="" />
	<spring:message code="DVIC_SEL_NONE_TXT01" />
	</a>
	</p>
	<!-- s: content -->
	<div class="con" id="searchDiv">
		<div class="search_cate">
			<ul>
				<li>
					<label for="tcate02"><spring:message code='DVIC_INFO_APP_LST01' /></label>
					<span>
						<input type="text" name="APPNAME" size="30" maxlength="30" class="ipt01" />
					</span>
				</li> 
				<li>
					<label for="tcate04"><spring:message code='DVIC_INFO_APP_LST02' /></label>
					<span><input type="text" name="PKGNAME" size="30" maxlength="30" class="ipt01" /></span>
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
<!-- 
<h2 class="h2_title02">App 관리</h2>
-->
<div class="report_table_wrap">
	<div class="hd">
		<p class="data_count" id="gridTotalCnt"></p>
		<div class="oBtn">
			<span class="buttonS"><a id="addButton" href="javascript:addAction();"><spring:message code='COM_BTN_ADD' /></a></span>								
			<span class="buttonS"><a id="deleteButton" href="javascript:deleteAction();"><spring:message code='COM_BTN_DELETE' /></a></span>
		</div>
	</div>
	<div class="con">
		<div id="jqgrid">
			<table id="grid"></table>
			<div id="pager"></div>
		</div>
	</div>
</div>

<!-- App 추가/수정 다이얼로그 -->
<div id="fileAppDialog" title="" style="display:none">
	<form id="frmFile" name="frmFile" method="post" enctype="multipart/form-data">
		<h2>&nbsp;</h2>
		<div><spring:message code='APPS_ADD_TXT01' /></div>
		<div id="ApkFile_div"><input type="file" size="30" name="ApkFile" id="ApkFile" style="background: none repeat scroll 0 0 #313131; border: 1px solid #000000;" /></div>
		<div><input type="hidden" size="30" name="PKGNAME" id="PKGNAME" /></div>
		<div><input type="hidden" size="30" name="VERSIONCODE" id="VERSIONCODE" /></div>
	</form>
</div>

<!-- App 삭제 다이얼로그 -->
<div id="deleteAppDialog" title="관리 어플리케이션 삭제" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code='PLCY_GRUP_DEL_DES01' /></p>
	</li>
	</ul>
</div>

</fmt:bundle>