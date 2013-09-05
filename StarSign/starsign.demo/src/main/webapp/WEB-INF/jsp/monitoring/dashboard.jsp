<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ include file="/WEB-INF/jsp/include/locale.jsp" %>
<script type="text/javascript">
	var userAgent = navigator.userAgent;
	var intervalFunc = null;
	var refreshTimePeriod = parseInt('${refreshTime}');

	// 최근 통지 수신결과 Grid 보이기/숨기기
	var isHide = false;
	var isRecentlyMessageSendGrid = false;
	
	// 연결 에이전트 현황 그래프
	var connectedAgentChart = null;
	// 정책 적용 현황 그래프
	var policyChart = null;
	// 서비스 서버 상태 그래프
	var ssActiveChart = null;
	// 악성 코드 감염 현황 그래프
	var badCodeDeviceChart = null;
	// 권고 App 설치 현황 그래프
	var installWhiteAppChart = null;
	// 서버 리소스 그래프
	var serverStatusChart = null;
	var serverStatusList = null;
	var showServerStatusChart = 1;

	function showServerStatusChartUp() {
		if(serverStatusList.length >= showServerStatusChart+1) {
			showServerStatusChart = showServerStatusChart+1;
			makeServerStatusChart(showServerStatusChart);
		}
	}
	function showServerStatusChartDown() {
		if(showServerStatusChart-1 > 0 ) {
			showServerStatusChart = showServerStatusChart-1;
			makeServerStatusChart(showServerStatusChart);
		}
	}
	
	
	// Init
	$(document).ready(function() {		
		init(makeDashboard);
		/*
		timedRefresh();
		
		$("#refreshButton").click(function() {
			location.reload(true);
		});
		*/

		$("#refreshButton").click(function() {
			clearInterval(intervalFunc);
			intervalFunc = null;
			makeDashboard();			
			intervalFunc = self.setInterval(makeDashboard, refreshTimePeriod);
		});
		
		intervalFunc = self.setInterval(makeDashboard, refreshTimePeriod);

	});
	
	/**
	 * 데쉬보드 새로고침
 	 */
	function timedRefresh() {
		setTimeout("location.reload(true);",refreshTimePeriod);
	}
	
	/**
	 * 최근 통지 수신 결과 Grid 보이기/숨기기
 	 */
 	function recentlyMessageSendGridShow() {
 		isHide = true;
 		recentlyMessageSendGridShowHide();
	}
 	function recentlyMessageSendGridHide() {
 		isHide = false;
 		recentlyMessageSendGridShowHide();
	}
 	function recentlyMessageSendGridShowHide() {
 		if(isHide) {
			$("#searchDiv").show();
			$("#pSearchDiv").css("height", 195);
			//isHide = false; 
			$("#searchHideButtonClosed").hide();
			$("#searchHideButtonOpened").show();
			$("#searchHideButton2 a").attr("href", 'javascript:recentlyMessageSendGridHide();');
			$("#searchHideButton2 img").attr("src", '<c:url value="/resources/image/btn_close01.gif" />');
		}
		else {
			$("#searchDiv").hide();
			$("#pSearchDiv").css("height", 31);
			//isHide = true; 
			$("#searchHideButtonClosed").show();
			$("#searchHideButtonOpened").hide();
			$("#searchHideButton2 a").attr("href", 'javascript:recentlyMessageSendGridShow();');
			$("#searchHideButton2 img").attr("src", '<c:url value="/resources/image/btn_open01.gif" />');
		}
	}
	
	/**
	 * 데쉬보드 만들기
 	 */
	function makeDashboard() {
		$("#refreshTime").html('<spring:message code='MNTR_TXT13' />' + getTimeStamp() + "  ");
		
		
		// 최근 통지 수신 결과 Grid 생성
		recentlyMessageSendGrid();
		
		// 최근 통지 수신결과 Grid 보이기/숨기기
		recentlyMessageSendGridShowHide();
		
		/*
		$("#searchHideButton").click(function() {
			if(isHide) {
				$("#searchDiv").show("blind");
				$("#pSearchDiv").css("height", 187);
				isHide = false;
				$("#searchHideButton img").attr("src", '<c:url value="/resources/image/btn_close01.gif" />');
			}
			else {
				$("#searchDiv").hide("blind");
				$("#pSearchDiv").css("height", 23);
				isHide = true;
				$("#searchHideButton img").attr("src", '<c:url value="/resources/image/btn_open01.gif" />');
			}
		});
		*/

		
		var service = {};
		var param1 = {};
		var param2 = {};
		var param3 = {};
		var param4 = {};
		var param5 = {};
		var param6 = {};
		var param7 = {};
		var param8 = {};
		var param9 = {};
		
		param1["ACTION"] = "select.ssActive";
		param2["ACTION"] = "select.policyApplyCount";
		param3["ACTION"] = "select.whiteAppCount";
		param4["ACTION"] = "list.serverStatus";
		param5["ACTION"] = "select.deviceCount";
		param6["ACTION"] = "select.connectedAgentCount";
		param7["ACTION"] = "select.badCodeCount";
		param8["ACTION"] = "list.badCodeCountWeek";
		param9["ACTION"] = "select.sendSucessCount";
		
		service["ssActive"] 		= param1;
		service["policyApplyCount"] = param2;
		service["whiteAppCount"] 	= param3;
		service["serverStatus"] 	= param4;
		service["deviceCount"] 		= param5;
		service["connectedCount"] 	= param6;
		service["badCodeCount"] 	= param7;
		service["badCodeCountWeek"] = param8;
		service["sendSucessCount"]  = param9;
		doAction(service, function(result) {
			// 통지 수신 결과 현황
			makeSendSucessCount(result["sendSucessCount"]);
			// 서비스 서버 상태 그래프 
			makessActiveChart(result["ssActive"]);
			// 정책 적용 현황 그래프
			makePolicyChart(result["policyApplyCount"]);
			// 단말기 및 에이전트 현황
			makeMobileAgentCount(result["deviceCount"]);
			// 연결 에이전트  현황
			makeConnectedAgentChart(result["connectedCount"]);
			// 악성코드 감염 현황
			makeBadCodeDeviceCount(result["badCodeCount"]);
			// 악성코드 감염 현황 그래프
			makeBadCodeDeviceChart(result["badCodeCountWeek"]);
			// 권고 App 설치 현황 그래프
			makeWhiteAppChart(result["whiteAppCount"]);
			
			// 서버 리소스 그래프
			serverStatusList = result["serverStatus"];
			showServerStatusChart = 1;
			makeServerStatusChart(showServerStatusChart);
			/*
			if(serverStatusList.length > 0) {
				showServerStatusChart = 1;
				makeServerStatusChart(showServerStatusChart);
			}
			*/

			delete result["sendSucessCount"]; 
			delete result["ssActive"];
			delete result["policyApplyCount"];
			delete result["deviceCount"];
			delete result["connectedCount"];
			delete result["badCodeCount"];
			delete result["badCodeCountWeek"];
			delete result["whiteAppCount"];
		});
	}
	/**
	 * 단말기 및 에이전트 현황 넣기
	 */
	function makeMobileAgentCount(obj) {
		$("#totalDevice").html(obj["TOTAL_DEVICE"]);
		$("#agentDevice").html('<spring:message code="MNTR_TXT18" /> ' + obj["AGENT_DEVICE"]);
		$("#lostDevice").html(obj["LOST_DEVICE"]);
	}
	/**
	 * 악성코드 감염 현황 넣기
	 */
	function makeBadCodeDeviceCount(obj) {
		$("#badCodeDevice").html(obj["BADCODE_DEVICE"]);
		//$("#badCodeList").html(obj["BADCODE_LIST"]);
	}
	/**
	 * 통지 수신 결과 현황
	 */
	function makeSendSucessCount(obj) {
		var sendCount = obj["SEND_COUNT"];
		var sendTotalCount = obj["SEND_TATAL_COUNT"];
		var sendSucessCount = obj["SEND_SUCESS_COUNT"];
		var sendSucessRate;
		if(sendSucessCount > 0 )
			sendSucessRate = roundXL(((sendSucessCount/sendTotalCount))*100, 0);
		else
			sendSucessRate = 0;
		
		$("#sendCount").html(sendCount);
		$("#sendSucessRate").html(sendSucessRate + '%');
	}

	/**
	 * 최근 통지 수신 결과 그리드 만들기
	 */
	function recentlyMessageSendGrid() {
		//$("#commandjqgrid").empty();
		//$("#commandjqgrid").html('<table id="commandgrid"></table>');
		
		if(isRecentlyMessageSendGrid == false) {
			// 그리드 만들기
			$("#commandgrid").jqGrid({
				url: gridPath + 'listGrid.sendSuccess',
				mtype: 'POST',
				datatype: 'json',
					colNames:['',
					          '<spring:message code="LOGS_LST04" />',
					          '<spring:message code="LOGS_LST03" />',
					          '<spring:message code="LOGS_LST05" />',
					          '<spring:message code="LOGS_LST06" />',
					          '<spring:message code="LOGS_LST07" />',
					          '<spring:message code="LOGS_LST08" />',
					          ''
					          ],
					colModel:[
						{title:false, name:'MSGID',index:'MSGID', align:"center", hidden:true, key:true},
						{title:false, name:'SENDTIME',index:'SENDTIME', align:"left", sortable:false, width:130},
						{title:false, name:'MSGCODE',index:'MSGCODE', align:"left", sortable:false, width:150},
						{title:false, name:'TOTALCOUNT',index:'TOTALCOUNT', align:"center", sortable:false, width:210},
						{title:false, name:'SUCCESSCOUNT',index:'SUCCESSCOUNT', align:"center", sortable:false, width:150},
						{title:false, name:'FAILCOUNT',index:'FAILCOUNT', align:"center", sortable:false, width:150},
						{title:false, name:'STATUS',index:'STATUS', align:"left", sortable:false, width:160},
						{title:false, name:'TOTALCNT',index:'TOTALCNT', hidden:true}
					],
					sortname: 'SENDTIME', sortorder: "desc", rowNum:6, height: '100%', width: 978, emptyrecords:"Empty Records", scrollOffset:0,
					loadComplete: function() {
						$("#commandgrid").jqGrid ('setLabel', 'SENDTIME', '', {'text-align':'left'});
						$("#commandgrid").jqGrid ('setLabel', 'MSGCODE', '', {'text-align':'left'});
						
						
						var ids = $("#commandgrid").jqGrid('getDataIDs');
						for(var i=0;i < ids.length;i++){ 
							var cl = ids[i];
							var pbId = "pb" + cl;
							var ed = "<div class=\"" + "progressbar\"" + " id=\"" + pbId + "\"></div>";
							$("#commandgrid").jqGrid('setRowData', ids[i], {"STATUS":ed});
							
							var ret = jQuery("#commandgrid").jqGrid('getRowData', cl);
							var sucessRate = 0;
							if(ret.SUCCESSCOUNT > 0 && ret.TOTALCOUNT > 0) {
								sucessRate = roundXL((ret.SUCCESSCOUNT/ret.TOTALCOUNT)*100, 0);
							}
							else
								sucessRate = 0;
							
							var boxImagePath = "${pageContext.request.contextPath}/resources/image/jquery/progressbar.gif";
							var barImagePath = "${pageContext.request.contextPath}/resources/image/jquery/progressbg_blue.gif";
							
							$("#"+ pbId).progressBar(sucessRate, {steps:0, boxImage: boxImagePath, barImage: barImagePath});
						}
					},
					gridComplete: function() { 
					// 색상 변경
					$('#commandgrid tr td').each(function(i, obj) {
						codeAlias("commandgrid", $(obj).attr('aria-describedby'), obj);
					});

					initGridUI('commandgrid');
					
					isRecentlyMessageSendGrid = true;
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
		else {
			$("#commandgrid").trigger("reloadGrid");
		}
	}
	/**
	 * 악성코드 감염 현황을 차트화
	 */
	function makeBadCodeDeviceChart(objList) {
		var pxAxis = {categories: []};
		var pSeries = {
				showInLegend: false,
				animation: false,
				id:'series-1',
				color: '#de4343',
				name: '', 
				data: []
		};
		var totalBadCodeCount = 0;
		var todayBadCodeCount = 0;
		if(objList.length > 0) {
			$.each(objList, function(i, obj) {
				pxAxis.categories.push(obj["DATE_TIME"]);
				pSeries.data.push(obj["BADCODE_COUNT"]);
				
				totalBadCodeCount = totalBadCodeCount + parseInt(obj["BADCODE_COUNT"]);
				if((objList.length-1) == i)
					todayBadCodeCount = parseInt(obj["BADCODE_COUNT"]);
			});
		}
		
		$("#badCodeList").html(todayBadCodeCount + "/" +totalBadCodeCount);
		
		var option = {
				chart: {
			         renderTo: 'badCodeDeviceGraph',
			         backgroundColor : null,
					 borderColor : null,
					 plotBackgroundColor: null,
				     plotBorderWidth: null,
				     plotShadow: false,
				     spacingLeft :0,
			         defaultSeriesType: 'line'
			      },
			      animation: false,
			      //colors: ['#de4343'],
			      title: {
			         text: ''
			      },
			      subtitle: {
			         text: ''
			      },
			      xAxis: pxAxis,
			      yAxis: {
			    	 min: 0,
			         title: {
			            text: ''
			         }
			      },
			      tooltip: {
			         enabled: false,
			         formatter: function() {
			            return '<b>'+ this.series.name +'</b><br/>'+
			               this.x +': '+ this.y +'Â°C';
			         }
			      },
			      plotOptions: {
			         line: {
			            dataLabels: {
			               enabled: true
			            },
			            enableMouseTracking: false
			         }
			      },
			      series: []
		};
		
		/*
		if(badCodeDeviceChart) {
			badCodeDeviceChart.destroy();	//delete badCodeDeviceChart;
			badCodeDeviceChart = null;
		}
		$("badCodeDeviceGraph").empty();
		badCodeDeviceChart = new Highcharts.Chart(option);
		*/
		
		if(badCodeDeviceChart) {
			var selSeries = badCodeDeviceChart.get('series-1');
			if(selSeries) {
				selSeries.remove();
			}
			
			badCodeDeviceChart.addSeries(pSeries);
			delete pSeries;
			pSeries = null;
		}
		else {
			option.series.push(pSeries);
			badCodeDeviceChart = new Highcharts.Chart(option);
			
			delete pSeries;
			pSeries = null;
			delete option;
			option = null;
		}
	}
	/**
	 * 새로 반영한 정책이 적용된 단말기 수를 차트화
	 */
	function makePolicyChart(obj) {
		//var total = parseInt(obj["POLICYAPPLY_Y"]) + parseInt(obj["POLICYAPPLY_N"]);
		var policyApplyY = parseInt(obj["POLICYAPPLY_Y"]);
		var policyApplyN = parseInt(obj["POLICYAPPLY_N"]);
		
		var policyApplyRate = 0;
		if(policyApplyY > 0) {
			policyApplyRate = roundXL(((policyApplyY / (policyApplyY+policyApplyN)) * 100), 0);
		}
		else {
			policyApplyRate = 0;
		}
		
		$("#policyApplyY").html(obj["POLICYAPPLY_Y"]);
		$("#policyApplyN").html(obj["POLICYAPPLY_N"]);
		$("#policyApplyRate").html(policyApplyRate+'%');
		
		var option = {
			chart: {
				renderTo: 'policyGraph',
				backgroundColor : null,
				borderColor : null,
				plotBackgroundColor: null,
		        plotBorderWidth: null,
		        plotShadow: false,
		        spacingLeft :0
			},
			colors: ['#068dc7', '#51b433'],
		    title: {
		        text: ''
		    },
		    tooltip: {
		       enabled: false,
		       formatter: function() {
		          return '<b>'+ this.point.name.split(":")[0] +'</b>: '+ this.y;
		       }
		    },
		    legend: {
		    	 enabled : false,
		         layout: 'horizontal',
		         align: 'center',
		         verticalAlign: 'bottom',
		         borderWidth: 0
		    },
		    plotOptions: {
		    	pie: {
					size : "120%",
					center: [55, 40],
			    	allowPointSelect: false,
			    	animation: false,
		            cursor: 'pointer',
		            borderWidth : 0,
		            dataLabels: {
			            enabled: false,
		            },
		            point: {
		            	   events: {
		            	    legendItemClick: function(){
		            	    	//this.slice(null);
		            	    	return false;
		            	    },
				            click: function(){
			           			return false;
			           		}
		            	   }
		            	  },
		           	events: {
		           		legendItemClick: function(){
		            	     this.slice(null);
		            	     return false;
		            	},
		           		click: function(){
		           			return false;
		           		}
		           	},
		            enableMouseTracking: false,
		            showInLegend: true
		        }
		    },
			series: []
		};

		var pSeries = {
				type : 'pie',
				id:'series-1',
				data: [{
						name: '<spring:message code="MNTR_TXT14" />' + obj["POLICYAPPLY_Y"],
						color: '#068dc7',
						y: obj["POLICYAPPLY_Y"]
						}, {
						name: '<spring:message code="MNTR_TXT15" />' + obj["POLICYAPPLY_N"],
						color: '#51b433',
						y: obj["POLICYAPPLY_N"]
						}]
		};

		/*
		if(policyChart) {
			policyChart.destroy();	//delete policyChart;
			policyChart = null;
		}
		$("policyGraph").empty(); 
		policyChart = new Highcharts.Chart(option);
		*/
		if(policyChart) {
			var selSeries = policyChart.get('series-1');
			if(selSeries) {
				selSeries.remove();	
			}
			
			policyChart.addSeries(pSeries);
			
			delete pSeries;
			pSeries = null;
		}
		else {
			option.series.push(pSeries);
			policyChart = new Highcharts.Chart(option);
			
			delete pSeries;
			pSeries = null;
			delete option;
			option = null;
		}
	}
	/**
	 * 연결 에이전트를 차트화
	 */
	function makeConnectedAgentChart(obj) {
		//var total = parseInt(obj["CONNECTED_Y"]) + parseInt(obj["CONNECTED_N"]);
		var connectedY = parseInt(obj["CONNECTED_Y"]);
		var connectedN = parseInt(obj["CONNECTED_N"]);
		
		var connectedAgentRate = 0;
		if(connectedY > 0) {
			connectedAgentRate = roundXL(((connectedY / (connectedY+connectedN)) * 100), 0);
		}
		else {
			connectedAgentRate = 0;
		}
		
		$("#connectedAgentY").html(obj["CONNECTED_Y"]);
		$("#connectedAgentN").html(obj["CONNECTED_N"]);
		$("#connectedAgentRate").html(connectedAgentRate + '%');
		
		//connectedAgentGraph
		var option = {
			chart: {
				renderTo: 'connectedAgentGraph',
				backgroundColor : null,
				borderColor : null,
				plotBackgroundColor: null,
		        plotBorderWidth: null,
		        plotShadow: false,
		        spacingLeft :0
			},
			colors: ['#51b433', '#6c6c6c'],
		    title: {
		        text: ''
		    },
		    tooltip: {
			   enabled: false,		    	
		       formatter: function() {
		          return '<b>'+ this.point.name.split(":")[0] +'</b>: '+ this.y;
		       }
		    },
		    legend: {
		    	 enabled : false,
		         layout: 'horizontal',
		         align: 'center',
		         verticalAlign: 'bottom',
		         borderWidth: 0
		    },
		    plotOptions: {
				pie: {
					size : "120%",
					center: [55, 40],
			    	allowPointSelect: false,
			    	animation: false,
		            cursor: 'pointer',
		            borderWidth : 0,
		            dataLabels: {
			            enabled: false,
		            },
		            point: {
		            	   events: {
		            	    legendItemClick: function(){
		            	    	//this.slice(null);
		            	    	return false;
		            	    },
				            click: function(){
			           			return false;
			           		}
		            	   }
		            	  },
		           	events: {
		           		legendItemClick: function(){
		            	     this.slice(null);
		            	     return false;
		            	},
		           		click: function(){
		           			return false;
		           		}
		           	},
		            enableMouseTracking: false,
		            showInLegend: true
		        }
		        /*
		        series: {
		            events: {
		                legendItemClick: function(event) {
		                    	return false;
		                    }
		                },
		                events: {
			           		click: function(){
			           			return false;
			           		}
			           	}
		            }
		        */
		    },
			series: []
		};

		var pSeries = {
				type : 'pie', 
				id:'series-1',
				data: [{
						name: '<spring:message code="MNTR_TXT03" />' + obj["CONNECTED_Y"],
						color: '#51b433',
						y: obj["CONNECTED_Y"]
						}, {
						name: '<spring:message code="MNTR_TXT04" />' + obj["CONNECTED_N"],
						color: '#6c6c6c',
						y: obj["CONNECTED_N"]
						}]
		};
		
		/*
		if(connectedAgentChart) {
			connectedAgentChart.destroy();	//delete connectedAgentChart;
			connectedAgentChart = null;
		}
		$("connectedAgentGraph").empty();
		connectedAgentChart = new Highcharts.Chart(option);
		*/
		if(connectedAgentChart) {
			var selSeries = connectedAgentChart.get('series-1');
			if(selSeries) {
				selSeries.remove();	
			}
			
			connectedAgentChart.addSeries(pSeries);
			delete pSeries;
			pSeries = null;
		}
		else {
			option.series.push(pSeries);
			connectedAgentChart = new Highcharts.Chart(option);
			
			delete pSeries;
			pSeries = null;
			delete option;
			option = null;
		}
	}
	/**
	 * 권고 App 설치 현황 넣기
	 */
	function makeWhiteAppChart(obj) {
		var whteAppCnt = parseInt(obj["TOTAL_WHITEAPP"]);
		var installDeviceCnt = parseInt(obj["INSTALL_DEVICE"]);
		var noInstallDeviceCnt = parseInt(obj["NOINSTALL_DEVICE"]);
		
		var installAppRate = 0;
		if(whteAppCnt > 0 && installDeviceCnt > 0) {
			installAppRate = roundXL(((installDeviceCnt / (installDeviceCnt+noInstallDeviceCnt)) * 100), 0);
		}
		else {
			installAppRate = 0;
		}
		
		//$("#totalWhiteApp").html(whteAppCnt);
		$("#installWhiteAppRate").html(installAppRate + '%');
		
		$("#whiteAppInstall").html('<spring:message code="MNTR_TXT07" /> ' + installDeviceCnt);
		$("#whiteAppNoInstall").html('<spring:message code="MNTR_TXT08" /> ' + noInstallDeviceCnt);
		
		var option = {
			chart: {
				renderTo: 'whiteAppGraph',
				backgroundColor : null,
				borderColor : null,
				plotBackgroundColor: null,
		        plotBorderWidth: null,
		        plotShadow: false,
		        spacingLeft :0
			},
			colors: ['#068dc7', '#6c6c6c'],
		    title: {
		        text: ''
		    },
		    tooltip: {
		       enabled: false,
		       formatter: function() {
		          return '<b>'+ this.point.name.split(":")[0] +'</b>: '+ this.y;
		       }
		    },
		    legend: {
		    	 enabled : false,
		         layout: 'horizontal',
		         align: 'center',
		         verticalAlign: 'bottom',
		         borderWidth: 0
		    },
		    plotOptions: {
		    	pie: {
					size : "120%",
					center: [55, 40],
			    	allowPointSelect: false,
			    	animation: false,
		            cursor: 'pointer',
		            borderWidth : 0,
		            dataLabels: {
			            enabled: false,
		            },
		            point: {
		            	   events: {
		            	    legendItemClick: function(){
		            	    	//this.slice(null);
		            	    	return false;
		            	    },
				            click: function(){
			           			return false;
			           		}
		            	   }
		            	  },
		           	events: {
		           		legendItemClick: function(){
		            	     this.slice(null);
		            	     return false;
		            	},
		           		click: function(){
		           			return false;
		           		}
		           	},
		            enableMouseTracking: false,
		            showInLegend: true
		        }
		    },
			series: []
		};

		var pSeries = {
				type : 'pie',
				id:'series-1',
				data: [{
						name: '<spring:message code="MNTR_TXT07" />' + installDeviceCnt,
						color: '#068dc7',
						y: installDeviceCnt
						}, {
						name: '<spring:message code="MNTR_TXT08" />' + noInstallDeviceCnt,
						color: '#6c6c6c',
						y: noInstallDeviceCnt
						}]
		};

		if(installWhiteAppChart) {
			var selSeries = installWhiteAppChart.get('series-1');
			if(selSeries) {
				selSeries.remove();	
			}
			
			installWhiteAppChart.addSeries(pSeries);
			
			delete pSeries;
			pSeries = null;
		}
		else {
			option.series.push(pSeries);
			installWhiteAppChart = new Highcharts.Chart(option);
			
			delete pSeries;
			pSeries = null;
			delete option;
			option = null;
		}
	}
	/**
	 * 서비스 서버 상태 그래프
	 */
	function makessActiveChart(obj) {
		//obj["ACTIVE_Y"]
		//obj["ACTIVE_N"]
		//obj["ACTIVE_N2"]
		
		//var total = parseInt(obj["ACTIVE_Y"]) + parseInt(obj["ACTIVE_N"]);
		var ssActiveN = parseInt(obj["ACTIVE_N"]) + parseInt(obj["ACTIVE_N2"]);
		if(parseInt(ssActiveN) > 0) {
			$("#serverActiveImg img").attr("src", '<c:url value="/resources/image/serverimg_no.png" />');
		}
		else {
			$("#serverActiveImg img").attr("src", '<c:url value="/resources/image/serverimg_ok.png" />');
		}
		
		$("#serverActiveY").html('<spring:message code="MNTR_TXT22" /> ' + obj["ACTIVE_Y"]);
		$("#serverActiveN").html('<spring:message code="MNTR_TXT23" /> ' + ssActiveN);
	}
	/**
	 * 서버 리소스 그래프
	 */
	function makeServerStatusChart(showServer) {
		var chartTitle = '';
		var curServerStatusPage = '';
		
		var boxImagePath  = "${pageContext.request.contextPath}/resources/image/jquery/progressbar.gif";
		var barImagePath1 = "${pageContext.request.contextPath}/resources/image/jquery/progressbg_green.gif";
		var barImagePath2 = "${pageContext.request.contextPath}/resources/image/jquery/progressbg_orange.gif";
		var barImagePath3 = "${pageContext.request.contextPath}/resources/image/jquery/progressbg_red.gif";
		var cpuRate = 0;
		var memRate = 0;
		var hddRate = 0;
		
		if(serverStatusList.length > 0) {
			curServerStatusPage = showServer + "/"+ serverStatusList.length;
			
			$.each(serverStatusList, function(i, obj) {
				if((showServer-1) == i) {
					chartTitle = '<spring:message code="MNTR_TXT24" />' + " (" + obj["SERVERIP"] + ")";
					cpuRate = roundXL(obj["CPU"], 0);
					memRate = roundXL(obj["MEMORY"], 0);
					hddRate = roundXL(obj["HDD"], 0);
				}
			});
		}
		else {
			chartTitle = '<spring:message code="MNTR_TXT24" />';
			curServerStatusPage = '0/0';
		}

		$("#serverStatusTitle").html(chartTitle);
		$("#serverStatusPage").html(curServerStatusPage);
		
		$("#pbCPU").progressBar(cpuRate, {steps:0, width:170, boxImage: boxImagePath, barImage: barImagePath1});
		$("#pbMemory").progressBar(memRate, {steps:0, width:170, boxImage: boxImagePath, barImage: barImagePath2});
		$("#pbHDD").progressBar(hddRate, {steps:0, width:170, boxImage: boxImagePath, barImage: barImagePath3});
	}
	
	/**
	 * 상세보기 페이지 이동
	 */
	function movePage(code) {
		switch(code) {
		case '1' :
			//정책관리 > 응용프로그램 관리
			window.location = '${pageContext.request.contextPath}/pageView/app.do?pageMenu=policy';
			break;
		case '2' :
			//모니터 > 정책 적용 현황
			window.location = '${pageContext.request.contextPath}/pageView/policyapply.do?pageMenu=monitoring';
			break;
		case '3' :
			//감염 현황 보기
			//모니터 > 악성코드 치료 현황
			window.location = '${pageContext.request.contextPath}/pageView/badcodesearch.do?pageMenu=monitoring';
			break;
		case '4' :
			//악성코드 리스트 보기
			window.location = '${pageContext.request.contextPath}/pageView/badcode.do?pageMenu=monitoring';
			break;
		case '5' :
			// 관리 대상 단말기 보기
			// 단말기 관리 > 단말기 제어
			window.location = '${pageContext.request.contextPath}/pageView/mobilecontrol.do?pageMenu=mobile';
			break;
		case '6' :
			// 분실 모드 단말기 보기
			// 단말기 관리 > 단말기 제어, 옵션: 분실모드
			window.location = '${pageContext.request.contextPath}/pageView/mobilecontrol.do?pageMenu=mobile&LOSTMODE=Y';
			break;
		case '7' :
			// 통지 수신 결과 건수
			// 모니터 > 통지 수신 결과
			window.location = '${pageContext.request.contextPath}/pageView/sendsuccess.do?pageMenu=monitoring';
			break;
		}
	}
</script>

<!--
<div class="updateTime">
	<span id="refreshTime"></span>
	<span class="buttonSg strong">
		<a href="#" id="refreshButton"><spring:message code='MNTR_BTN01' /></a>
	</span>
</div>
-->



<!-- 관리 단말기 -->
<div class="pop_wrap" style="width: 239px; height: 248px;">
	<h2 class="tit"><spring:message code="MNTR_TTL08" /></h2>
	<div class="cont">

		<div class="agent_state_wrap">
			<div class="txt01">
				<h3><spring:message code='MNTR_TXT01' /></h3>
				<p class="num1" id="totalDevice"></p>
				<ul>
					<li class="txt_link"><a href="javascript:movePage('5');"><spring:message code='MNTR_LNK01' /></a></li>
					<li class="agent" id="agentDevice"></li>
				</ul>
			</div>
			<div class="txt02">
				<h3><spring:message code='MNTR_TXT19' /></h3>
				<p id="lostDevice"></p>
				<ul>
					<li class="c02"><a href="javascript:movePage('6');"><spring:message code='MNTR_LNK02' /></a></li>
				</ul>
			</div>
		</div>
	
	</div> 
</div>

<!-- 연결 에이전트 현황 -->
<div class="pop_wrap" style="width: 240px; height: 248px;">
	<h2 class="tit"><spring:message code="MNTR_TTL01" /></h2>
	<div class="grahBoxtArea1">
		<div class="grah_Area" id="connectedAgentGraph" style="width: 105px; height: 105px; margin: 0 auto; padding:0"></div>
		<div class="dashNote">
			<div class="conditionArea">
			<p><spring:message code='MNTR_TXT29' /></p>
			<p class="num" id="connectedAgentRate"></p>
			</div>
			<ul>
			<li>
				<img src="<c:url value="/resources/image/app_green.gif" />" />
				<spring:message code="MNTR_TXT03" />
				<span id="connectedAgentY"></span>
			</li>
			<li>
				<img src="<c:url value="/resources/image/app_no.gif" />" />
				<spring:message code="MNTR_TXT04" />
				<span id="connectedAgentN"></span>
			</li>
			</ul>
		</div>
	</div>
</div>

<!-- 정책 적용 현황 -->
<div class="pop_wrap" style="width: 240px; height: 248px;">
	<h2 class="tit"><spring:message code='MNTR_TTL07' /></h2>
	<div class="moreBtn"><a href="javascript:movePage('2');"><spring:message code='COM_LNK_DETAIL' /></a></div>
	<div class="grahBoxtArea1">
		<div class="grah_Area" id="policyGraph" style="width: 105px; height: 105px; margin: 0 auto; padding:0"></div>
		<div class="dashNote">
			<div class="conditionArea">
			<p><spring:message code='MNTR_TXT30' /></p>
			<p class="num" id="policyApplyRate"></p>
			</div>
			<ul>
				<li><img src="<c:url value="/resources/image/app_ok.gif" />" />
				<spring:message code="MNTR_TXT14" />
				<span id="policyApplyY"></span>
				</li>
				<li><img src="<c:url value="/resources/image/app_green.gif" />" />
				<spring:message code="MNTR_TXT15" />
				<span id="policyApplyN"></span>
				</li>
			</ul>
		</div>
	</div>
</div>

<!-- 권고 App 설치 현황 -->
<div class="pop_wrap p_end" style="width: 240px; height: 248px;">
	<h2 class="tit"><spring:message code='MNTR_TTL09' /></h2>
	<div class="moreBtn"><a href="javascript:movePage('1');"><spring:message code='COM_LNK_DETAIL' /></a></div>
	<div class="grahBoxtArea1">
		<div class="grah_Area" id="whiteAppGraph" style="width: 105px; height: 105px; margin: 0 auto; padding:0"></div>
		<div class="dashNote">
			<div class="conditionArea">
			<p><spring:message code='MNTR_TXT31' /></p>
			<p class="num" id="installWhiteAppRate"></p>
			</div>
			<ul>
				<li><img src="<c:url value="/resources/image/app_ok.gif" />" />
				<span id="whiteAppInstall"></span>
				</li>
				<li><img src="<c:url value="/resources/image/app_no.gif" />" />
				<span id="whiteAppNoInstall"></span>
				</li>
			</ul>
		</div>
	</div>
</div>

<!-- 최근 통지 수신 결과 -->
<div class="pop_wrap_top" style="width: 977px; height: 195px;" id="pSearchDiv">
	<div>
	<h2 class="tit">
		<span id="searchHideButtonClosed">
			<a href="javascript:recentlyMessageSendGridShow();">
				<spring:message code='MNTR_TTL04' />
			</a>
		</span>
		<span id="searchHideButtonOpened">
			<a href="javascript:recentlyMessageSendGridHide();">
				<spring:message code='MNTR_TTL12' />
			</a>
		</span>
		<span class="count_w">
			(<spring:message code='MNTR_TXT25' /><a href="javascript:movePage('7');">&nbsp;<span id="sendCount" class="st40"></span></a> / <spring:message code='MNTR_TXT26' />&nbsp;<span id="sendSucessRate" class="st50"></span>)
		</span>
	</h2>
	<div class="openBtn" id="searchHideButton2">
		<a href="javascript:recentlyMessageSendGridHide();">
		<img src="<c:url value="/resources/image/btn_close01.gif" />" width="16" height="14" alt="" />
		</a>
	</div>
	</div>
	<div class="list" id="searchDiv">
		<div id="commandjqgrid"><table id="commandgrid"></table></div>
	</div>
	<!-- 
	<div class="count_w">
		(<spring:message code='MNTR_TXT25' /><a href="javascript:movePage('7');"><strong id="sendCount"></strong></a> / <spring:message code='MNTR_TXT26' /><strong id="sendSucessRate"></strong>)
	</div>
	 -->
</div>

<!-- 악성코드 감염 현황 -->
<div class="pop_wrap" style="width: 485px; height: 238px;">
	<h2 class="tit"><spring:message code='MNTR_TTL06' /></h2>
	<div class="cont">
	
		<div class="bed_code_wrap">
			<div class="agent_state_wrap02">
				<div class="txt01">
					<h3><spring:message code='MNTR_TXT20' /></h3>
					<p class="num2" id="badCodeDevice"></p>  
					<ul>
						<li class="num3"><a href="javascript:movePage('3');"><spring:message code='MNTR_LNK04' /></a></li>
					</ul>
					</div> 
				<div class="txt02">
					<h3><spring:message code='MNTR_TXT21' /></h3>
					<p class="num1" id="badCodeList"></p> 
					<ul>
						<li class="txt_link"><a href="javascript:movePage('4');"><spring:message code='MNTR_LNK05' /></a></li>
					</ul>
				</div> 
			</div>
			<div class="agent_state_gp" >
			<div id="badCodeDeviceGraph" style="width: 255px; height: 180px;"></div>
			<div class="grah_msg">&lt;<spring:message code='MNTR_TXT28' />&gt;</div>
			</div>
		</div>
	</div>
</div>

<!-- 서비스 서버 상태 -->
<div class="pop_wrap" style="width: 240px; height: 238px;">
	<h2 class="tit"><spring:message code='MNTR_TTL10' /></h2>
	<div class="grahBoxtArea1">
		<div class="grah_Area2" id="serverActiveImg">
			<img src="<c:url value="/resources/image/serverimg_ok.png" />" />
		</div>
		<div class="dashNote2">
		<ul>
			<li>
			<img src="<c:url value="/resources/image/server_ok.gif" />" /><strong id="serverActiveY"></strong>
			<img src="<c:url value="/resources/image/server_no.gif" />" /><strong id="serverActiveN"></strong>
			</li>
		</ul>
		</div>
	</div>
</div>

<!-- 서버 리소스 현황 -->
<div class="pop_wrap p_end" style="width: 240px; height: 238px;">
	<h2 class="tit"><spring:message code='MNTR_TTL11' /></h2>
	<div class="con">
		<div class="server_state_wrap"> 
			<h3 id=serverStatusTitle></h3>
			<div class="grah">
				<h2>CPU</h2>
				<span id="pbCPU"></span><br></br>
				<h2>Memory</h2>
				<span id="pbMemory"></span><br></br>
				<h2>HDD</h2>
				<span id="pbHDD"></span><br></br>
			</div>
		</div>
	</div>
	<div class="moreBtn02">
		<a href="javascript:showServerStatusChartDown();"><img src="<c:url value="/resources/image/btn_prew.gif" />" width="16" height="15" alt="" /></a> 
		<span id="serverStatusPage"></span>
		<a href="javascript:showServerStatusChartUp();"><img src="<c:url value="/resources/image/btn_next.gif" />" width="16" height="15" alt="" /></a>
	</div>
</div>