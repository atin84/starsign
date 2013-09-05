<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>

<script type="text/javascript">
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
	   if (data=="error"){
	      alert("파일전송중 에러 발생!!");
	      return false;
	   }
	   
	   var resultObj = eval("(" + data + ")");
	   alert("result : " + resultObj.result + "\ncode : " + resultObj.code);
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
	      alert("파일을 선택하세요.");
	      $("#ApkFile").focus();
	      return;
	   }
	   
	   if (!$("#ApkFile").val().match(/\.(apk)$/i)) {
		   alert("apk 파일만 올릴 수 있습니다");
		   $("#ApkFile").focus();
		   return;
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
	      alert("파일을 선택하세요.");
	      $("#ApkFile").focus();
	      return;
	   }
	   
	   if (!$("#ApkFile").val().match(/\.(apk)$/i)) {
		   alert("apk 파일만 올릴 수 있습니다");
		   $("#ApkFile").focus();
		   return;
	   }
	 
	   //파일전송
	   var frm;
	   frm = $('#frmFile'); 
	   frm.attr("action","${pageContext.request.contextPath}/whiteApp/update.do");
	   frm.submit(); 
	}
	
</script>

<div style="width:350px">
<form id="frmFile" name="frmFile" method="post" enctype="multipart/form-data">
<div>PkgName : <input type="text" size="30" name="PKGNAME" id="PKGNAME" /></div>
<div>VersionCode : <input type="text" size="30" name="VERSIONCODE" id="VERSIONCODE" /></div>
<div>파일을 선택하세요.</div>
<div><input type="file" size="30" name="ApkFile" id="ApkFile" /></div>
<div><input type="button" class="btn menu" value="추가" onclick="FileAdd();" />
<input type="button" class="btn menu" value="수정" onclick="FileUpdate();" /></div>
</form>
</div>

<a href="${pageContext.request.contextPath}/app/download.do?WHITEAPPID=0&PKGNAME=com.bvalosek.cpuspy">다운로드</a>
