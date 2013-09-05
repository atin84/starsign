<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<!-- 에러 메시지 -->
<div id="errorDialog" style="display:none">
	<p style="text-align:center;">
		<spring:message code="ERORR_DES01" />
	</p>
</div>
<!-- 정책 삭제 -->
<div id="errorPolicyDeleteDialog" title="에러 메시지" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="PLCY_DEL_DES01" /></p>
	</li>
	</ul>
</div>

<!-- 정책 그룹 삭제 -->
<div id="errorGroupDeleteDialog" title="에러 메시지" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="PLCY_GRUP_DEL_DES02" /></p>
	</li>
	</ul>
</div>

<!-- 통제단말기 등록 dialog -->
<div id="regDeviceDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="DVIC_REGISTER_DES01" /></p>
	</li>
	</ul>
</div>

<!-- 통제단말기 해재 dialog -->
<div id="relDeviceDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="DVIC_UNREGISTER_DES01" /></p>
	</li>
	</ul>
</div>

<!-- 장비 삭제 -->
<div id="mobileDeleteDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="DVIC_ADMN_DEL_DES01" /></p>
	</li>
	</ul>
</div>

<!-- wifi 그리드 다이얼로그 -->
<div id="policywifiDialog" style="display: none;">
	<div id="policywifijqgrid">
		<!-- <h2 class="h2_title03" id="policywifiTxt"></h2> --> 
		<table id="policywifigrid"></table>
		<div id="policywifipager"></div>
	</div>
</div>

<!-- 적용 버튼 다이얼로그 -->
<div id="updateDialog" style="display: none;">
	<p><spring:message code="PLCY_GRUP_APPLY_DES01" /></p>
</div>

<!-- 장비 삭제 -->
<div id="deleteDialog" style="display:none">
	<ul>
	<li class="ico_alert">
	<p><spring:message code="PLCY_GRUP_DEL_DES01" /></p>
	</li>
	</ul>
</div>

<!-- check dialog -->
<div id="checkAlertDialog" style="display:none">
	<ul>
	<li class="ico_alert"><p class="dialogContent"></p></li>
	</ul>
</div>

<!-- 정책 Form -->
<div style="display: none;" id="policyContentHiddenDiv">
<div class="center_content" id="policyContentDiv">
	<input type="hidden" id="POLICYID" name="POLICYID"/>
	<h2 class="h2_title03" id="policyTitle"></h2> 
	<h3 class="h3_title01 "><spring:message code="PLCY_DETAIL_TXT01" /></h3>
	<div class="data_table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" id="inputForm">
			<tr>
				<th>
					<input type="checkbox" name="NOTICEYN" id="NOTICEYN">
					<spring:message code="PLCY_DETAIL_CTL01" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th><spring:message code="PLCY_DETAIL_CTL02" /></th>
				<td>
					<select id="SYNCPERIOD" name="SYNCPERIOD"></select><spring:message code='COM_TXT02' />
				</td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="ROOTINGCHECKYN" id="ROOTINGCHECKYN">
					<spring:message code="PLCY_DETAIL_CTL19" />
				</th>
				<td>
					<div class="rtl" id="rootingDiv1"></div>
				</td>
			</tr>
			<tr>
				<th id="rootingAlertDiv">
					<!-- <div class="rtl02" id="rootingAlertDiv">  -->
						<!-- 
						<spring:message code="PLCY_DETAIL_TXT14" />
						<input type="checkbox" name="ROOTINGALERTYN" id="ROOTINGALERTYN"/>
						 -->
					<!-- </div> -->
				</th>
				<td>
					<div class="rtl" id="rootingDiv2"></div>
				</td>
			</tr>
		</table>
	</div>
	<h3 class="h3_title01 "><spring:message code="PLCY_DETAIL_TXT02" /></h3>
	<div class="data_table_wrap">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th><spring:message code="PLCY_DETAIL_CTL03" /></th>
				<td>
					<select id="LOSTMODE" name="LOSTMODE"></select>
				</td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="LOCKYN" id="LOCKYN"/>
					<spring:message code="PLCY_DETAIL_CTL04" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="RESETYN" id="RESETYN"/>
					<spring:message code="PLCY_DETAIL_CTL05" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="REMOVEYN" id="REMOVEYN"/>
					<spring:message code="PLCY_DETAIL_CTL06" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="ALERTYN" id="ALERTYN"/>
					<spring:message code="PLCY_DETAIL_CTL07" />
				</th>
				<td></td>
			</tr>
		</table>
	</div>
	<h3 class="h3_title01 "><spring:message code="PLCY_DETAIL_TXT03" /></h3>
	<div class="data_table_wrap">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th>
					<input type="checkbox" name="WIFIYN" id="WIFIYN"/>
					<spring:message code="PLCY_DETAIL_CTL08" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th><spring:message code="PLCY_DETAIL_CTL09" /></th>
				<td>
					<select id="WIFILISTINFOID" name="WIFILISTINFOID"></select>
					&nbsp;
					<a href="javascript:showDetailWiFiList()" class="open_view" ><spring:message code='COM_LNK_DETAIL' /></a>
				</td>
			</tr>
		</table>
	</div>
	<h3 class="h3_title01 "><spring:message code="PLCY_DETAIL_TXT04" /></h3>
	<div class="data_table_wrap">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th>
					<input type="checkbox" name="APPREPORTYN" id="APPREPORTYN"/>
					<spring:message code="PLCY_DETAIL_CTL10" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th><spring:message code="PLCY_DETAIL_CTL11" /></th>
				<td>
					<div class="rtl">   
					<select id="APPREPORTPERIOD" name="APPREPORTPERIOD"></select><spring:message code='COM_TXT04' />
					</div>
				</td>
			</tr>
		</table>
	</div>
	<h3 class="h3_title01 "><spring:message code="PLCY_DETAIL_TXT05" /></h3>
	<div class="data_table_wrap">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th>
					<input type="checkbox" name="AVREALTIMEYN" id="AVREALTIMEYN"/>
					<spring:message code="PLCY_DETAIL_CTL12" />
				</th>
				<td>
					<div class="rtl" id="realLevelDiv"></div>
				</td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="AVREALTIMEBEHAVIORALYN" id="AVREALTIMEBEHAVIORALYN"/>
					<spring:message code="PLCY_DETAIL_CTL13" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="AVREALTIMEPHPYN" id="AVREALTIMEPHPYN"/>
					<spring:message code="PLCY_DETAIL_CTL14" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="AVREALTIMEPUPYN" id="AVREALTIMEPUPYN"/>
					<spring:message code="PLCY_DETAIL_CTL15" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="AVMANUALPHPYN" id="AVMANUALPHPYN"/>
					<spring:message code="PLCY_DETAIL_CTL18" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="AVMANUALPUPYN" id="AVMANUALPUPYN"/>
					<spring:message code="PLCY_DETAIL_CTL20" />
				</th>
				<td></td>
			</tr>
			<tr>
				<th>
					<input type="checkbox" name="AVRESERVEDYN" id="AVRESERVEDYN"/>
					<spring:message code="PLCY_DETAIL_CTL16" />
				</th>
				<td>
					<div class="rtl" id="periodDiv1"></div>
				</td>
			</tr>
		</table>
	</div>
	<h3 class="h3_title01 "><spring:message code="PLCY_DETAIL_TXT06" /></h3>
	<div class="data_table_wrap">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th>
					<input type="checkbox" name="AVUPDATERESERVEDYN" id="AVUPDATERESERVEDYN"/>
					<spring:message code="PLCY_DETAIL_CTL17" />
				</th>
				<td>
					<div class="rtl" id="periodDiv2"></div>
				</td>
			</tr>
		</table>
	</div>
</div>
</div>

<!-- 장비 상세보기 -->
<div id="detailDeviceDialog" style="display: none;">
<div id="tabs">
	<ul>
		<li><a href="#tabs-1"><spring:message code="DVIC_SEL_NONE_TAB01" /></a></li>
		<li><a href="#tabs-2"><spring:message code="DVIC_SEL_NONE_TAB02" /></a></li>
		<li><a href="#tabs-3"><spring:message code="DVIC_SEL_NONE_TAB03" /></a></li>
		<li><a href="#tabs-4" id="locationTab"><spring:message code="DVIC_SEL_NONE_TAB04" /></a></li>
	</ul>
	<div class="tabsContents" id="tabs-1" style="height:420px;">
		<p class="tabTitle" ><spring:message code="DVIC_SEL_NONE_DES01" /></p>
		<!-- <h2 class="h2_title03" style="display: none;">상세정보</h2> -->
		<div class="con" id="detailDeviceInfo">
			<table width="100%" cellpadding="10" cellspacing="30" border="0" >
				<tr><th width="100%" align="left" colspan="4"><strong id="D_DEVICEINFOTITLE"></strong></th></tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right" width="22%"><strong id="D_IMEI"></strong></th>
					<td width="28%"><span id="D_IMEI_V"></span></td>
					<th align="right" width="16%"><strong id="D_USIM"></strong></th>
					<td width="34%"><span id="D_USIM_V"></span></td>
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_MANUFACTURER"></strong></th>
					<td><span id="D_MANUFACTURER_V"></span></td>
					<th align="right"><strong id="D_OSVERSION"></strong></th>
					<td><span id="D_OSVERSION_V"></span></td>
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_MODEL"></strong></th>
					<td><span id="D_MODEL_V"></span></td>
					<th align="right"><strong id="D_PHONE"></strong></th>
					<td><span id="D_PHONE_V"></span></td>
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_MAC"></strong></th>
					<td><span id="D_MAC_V"></span></td>
					<th align="right">&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
				
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				
				<tr><th width="100%" align="left" colspan="4"><strong id="D_DEVICEDETAILINFOTITLE"></strong></th></tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right" width="22%"><strong id="D_STATUS"></strong></th>
					<td width="28%"><span id="D_STATUS_V"></span></td>
					<th align="right" width="16%"><strong id="D_POLICYNAME"></strong></th>
					<td width="34%"><span id="D_POLICYNAME_V"></span></td>	
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_EMPLOYEENAME"></strong></th>
					<td><span id="D_EMPLOYEENAME_V"></span></td>
					<th align="right"><strong id="D_GROUPNAME"></strong></th>
					<td><span id="D_GROUPNAME_V"></span></td>	
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_DEPARTMENT"></strong></th>
					<td><span id="D_DEPARTMENT_V"></span></td>
					<th align="right"><strong id="D_AVENGINEVERSION"></strong></th>
					<td><span id="D_AVENGINEVERSION_V"></span></td>
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_POSITION"></strong></th>
					<td><span id="D_POSITION_V"></span></td>
					<th align="right"><strong id="D_ROOTINGYN"></th>
					<td><span id="D_ROOTINGYN_V"></span></td>
				</tr>
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>
				<tr>
					<th align="right"><strong id="D_EMAIL"></strong></th>
					<td><span id="D_EMAIL_V"></span></td>
					<th align="right"><strong id="D_RESETSTATUS"></th>
					<td><span id="D_RESETSTATUS_V"></span></td>
				</tr>
				<!-- <tr>
					<th align="right"><strong id="D_USIM"></strong></th><td><span id="D_USIM_V"></span></td>
				</tr> 
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>-->
				<!-- <tr>
					<th align="right"><strong id="D_OSVERSION"></strong></th><td><span id="D_OSVERSION_V"></span></td>
				</tr> 
				<tr><th><span>&nbsp;</span></th><td><span>&nbsp;</span></td></tr>-->
				<!-- <tr>
					<th align="right"><strong id="D_PHONE"></strong></th><td><span id="D_PHONE_V"></span></td>
				</tr> -->
			</table>
		</div>
	</div>
	<div class="tabsContents" id="tabs-2" style="height:420px;">
		<p class="tabTitle"><spring:message code="DVIC_SEL_NONE_DES01" /></p>
		<!-- <h2 class="h2_title03" style="display: none;">WIFI 허용 목록</h2> -->
		<!-- <p id="wifigridTotalCnt"></p> -->
		<div id="wifijqgrid">
		<table id="wifigrid"></table>
		<div id="wifipager"></div>
		</div>
	</div>
	<div class="tabsContents" id="tabs-3" style="height:420px;">
		<p class="tabTitle"><spring:message code="DVIC_SEL_NONE_DES01" /></p>
		<!-- <h2 class="h2_title03" style="display: none;">응용프로그램 목록</h2> -->
		<!-- <p id="appgridTotalCnt"></p> -->
		<div id="appjqgrid">
		<table id="appgrid"></table>
		<div id="apppager"></div>
		</div>
	</div>
	<div class="tabsContents" id="tabs-4" style="height:420px;">
		<div id="wappermap">
			<p class="tabTitle"><spring:message code="DVIC_SEL_NONE_DES01" /></p>
		</div>
	</div>
</div>
</div>

<!-- 메인에 있는 사용자 수정에서도 사용함 -->
<!-- 관리자 수정 다이얼로그 -->
<div id="adminEditDialog" title="관리자 수정" style="display:none;height: auto;" >
	<div id="editcntgrid" class="admin_modify">
	<table id="TblGrid_grid" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<!-- 에러 화면 -->
			<tr id="FormError">
				<td class="ui-state-error" colspan="2"><spring:message code="DVIC_ADMN_ADD_DES01" /></td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT01" /></td>
				<td class="DataTD" style="padding-left: 5px">
					<input class="entry FormElement ui-widget-content reqID" type="text" style=" width: 132px" name="ED_ADMINID" id="ED_ADMINID" disabled/>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT02" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td class="DataTD" style="padding-left: 5px">
					<span class="buttonS"><a id="addButton" href="javascript:changePwAction();"><spring:message code="ADMN_INFO_EDIT_BTN01" /></a></span>	
					<input type="hidden" name="ED_PW" id="ED_PW" />
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT03" /></td>
				<td class="DataTD" style="padding-left: 5px">
					<input class="entry FormElement ui-widget-content required" type="text" name="ED_NAME" id="ED_NAME" maxlength="12" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT04" /></td>
				<td class="DataTD" style="padding-left: 5px">
					<input class="entry FormElement ui-widget-content required adminPhoneForm" type="text" name="ED_PHONE" id="ED_PHONE" maxlength="17" onKeyPress="return numbersonly(event, false)" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT05" /></td>
				<td class="DataTD" style="padding-left: 5px">
					<input class="entry FormElement ui-widget-content required emailForm" type="text" name="ED_EMAIL" id="ED_EMAIL" maxlength="100" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<c:choose>
				<c:when test="${currUser.adminId == 'webadmin'}">
					<tr class="FormData" height="30px">
						<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT06" /></td>
						<td class="DataTD" style="padding-left: 5px">
							<div class="ct">
							<input class="entry FormElement ui-widget-content ipAddressForm reqIP" type="text" name="ED_STARTIP" id="ED_STARTIP" maxlength="39" />
							<spring:message code="ADMN_INFO_EDIT_TXT07" />
							<input class="entry FormElement ui-widget-content ipAddressForm reqIP" type="text" name="ED_ENDIP" id="ED_ENDIP" maxlength="39" />
							<strong style="color: #de4444;">(*)</strong>
							</div>
						</td>
					</tr>
					<tr height="30px">
						<td class="CaptionTD"></td>
						<td class="DataTD" style="padding-left: 5px">
							<spring:message code="CNFG_ADMN_ADD_DES02" htmlEscape="false" />
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr class="FormData" height="30px">
						<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_TXT06" /></td>
						<td class="DataTD" style="padding-left: 5px">
							<div class="ct">
							<input class="entry FormElement ui-widget-content ipAddressForm reqIP" type="text" name="ED_STARTIP" id="ED_STARTIP" maxlength="39" disabled />
							<spring:message code="ADMN_INFO_EDIT_TXT07" />
							<input class="entry FormElement ui-widget-content ipAddressForm reqIP" type="text" name="ED_ENDIP" id="ED_ENDIP" maxlength="39" disabled />
							<!-- <strong style="color: #de4444;">(*)</strong> -->
							</div>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr class="FormData" height="30px">
				<td class="CaptionTD"><spring:message code="CNFG_ADMN_LST06" /></td>
				<td class="DataTD">
					&nbsp;<input class="entry FormElement ui-widget-content" type="text" name="ED_DESCRIPTION" id="ED_DESCRIPTION" maxlength="30" />
				</td>
			</tr>
		</tbody>
	</table>
	</div>
</div>

<!-- 비밀번호 변경 다이얼로그 -->
<div id="changePwDialog" title="관리자 추가" style="display:none;height: auto;" >
	<div id="editcntgrid" class="ui-jqdialog-content">
	<table id="TblGrid_grid" class="EditTable" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<!-- 에러 화면 -->
			<tr id="FormError">
				<td class="ui-state-error" colspan="2"><spring:message code="DVIC_ADMN_ADD_DES01" /></td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_PW_TXT01" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content reqPW engNumCharForm" type="password"name="CH_CUR_PW" id="CH_CUR_PW" maxlength="32" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_PW_TXT02" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content reqPW engNumCharForm" type="password"name="CH_PW" id="CH_PW" maxlength="32" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="ADMN_INFO_EDIT_PW_TXT03" /></td>
				<td class="DataTD">
					&nbsp;<input class="FormElement ui-widget-content reqPW engNumCharForm" type="password"name="CH_PW_VERIFY" id="CH_PW_VERIFY" maxlength="32" />
					<strong style="color: #de4444;">(*)</strong>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
</div>

<!-- 단말기 제어의 공지 다이얼로그 -->
<div id="noticeDialog" style="display:none;height: auto;" >
	<div id="editcntgrid" class="ui-jqdialog-content">
	<table id="TblGrid_grid" class="EditTable" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<!-- 에러 화면 -->
			<tr id="FormError">
				<td class="ui-state-error" colspan="2"></td>
			</tr>
			<tr class="FormData">
				<td class="CaptionTD"><spring:message code="DVIC_CMD_TXT01" /></td>
				<td class="DataTD" rowspan="3">
					<textarea class="FormElement ui-widget-content required" rows="3" cols="25" id="DESCRIPTION" name="DESCRIPTION" style="resize: none; overflow: auto;" maxlength="30" onkeyup="return ismaxlength(this)">
					</textarea>
					 <!--
					&nbsp;
					<input class="FormElement ui-widget-content required" type="text" name="DESCRIPTION" id="DESCRIPTION" maxlength="30" />
					-->
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
		</tbody>
	</table>
	</div>
</div>
