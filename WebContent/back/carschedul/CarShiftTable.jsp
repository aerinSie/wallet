<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.cartype.model.*"%>
<%@ page import="com.carschedul.model.*"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
	
	<!-- 基本css -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back/carschedul/fullcalendar-3.7.0/fullcalendar.min.css">
	<link rel="stylesheet" media='print' type="text/css" href="<%=request.getContextPath()%>/back/carschedul/fullcalendar-3.7.0/fullcalendar.print.css">
	
	<!-- 班表css -->
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/theme.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/images/ui-bg_gloss-wave_35_f6a828_500x100.png">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/images/ui-bg_highlight-soft_100_eeeeee_1x100.png">
	
	<link rel="shortcut icon" type="image/x-icon" href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
	<link rel="mask-icon" type="" href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" />
	<link rel="canonical" href="https://codepen.io/akhil_001/pen/XNqQjw?depth=everything&order=popularity&page=58&q=translate&show_forks=false" />
	
	
	
	
	<jsp:useBean id="carSchedulSvc" scope="page" class="com.carschedul.model.CarSchedulService" />
    <jsp:useBean id="empSvc" scope="page" class="com.employee.model.EmployeeService" />

 		<%! String emp_no =null; %>
 		<%! String empName =null; %>
   		<%! String empTitle = null;%>
    	
 
<style>
body {
		margin-top: 40px;
		text-align: center;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
	}
		
	#wrap {
		width: 1250px;
		margin: 0 auto;
	}
		
	#external-eventsbox {
		float: left;
	    width: 150px;
	    padding: 10px 10px;
	    border: 1px solid #ccc0;
	    background: #eee0;
	    margin-left: 70px;
	    text-align: left;

	} 
	
	.fc .fc-toolbar>*>:first-child {
    	margin-right: 40px;
	}
		
	#external-eventsbox h4 {
		font-size: 16px;
		margin-top: 0;
		padding-top: 1em;
	}
		
	#external-eventsbox .fc-event {
		margin: 10px 0;
		cursor: pointer;
	}
		
	#external-eventsbox p {
		margin: 1.5em 0;
		font-size: 11px;
		color: #666;
	}
		
	#external-eventsbox p input {
		margin: 0;
		vertical-align: middle;
	} 

	#calendar {
		float: right;
		width: 980px;
		margin-right: 50px;
	}
	
	.fc-event.fc-draggable, .fc-event[href], .fc-popover .fc-header .fc-close, a[data-goto] {
    cursor: pointer;
    width: 75px;
	}
	
	#deleter{
	width: 100px;
	height: 100px;
	opacity: 0.8;
	
	-moz-background-size:contain;
    -webkit-background-size:contain;
    -o-background-size:contain;
    background-size:contain;
	}

	
	span.input-group-addon.custom__addon.blue_addon {
    color: #fff;
    border: none;
    font-size: 12px;
    border-radius: 2px;
    text-transform: uppercase;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
	}
	span.input-group-addon.custom__addon.blue_addon {
    background-color: #428fdc;
	}
	
	select.form-control.custom__select {
    border: none;
    border-radius: 2px;
    bx-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
    }
    
    .fc-icon, .fc-toolbar .fc-center {
    display: inline-block;
    margin-right: 120px;
	}
	
	.fc-event, .fc-event-dot {
    background-color: #5bc0de;
    border: 1px solid #9ebece;
	}
	
	.fc-day-grid-event .fc-content {
    white-space: nowrap;
    overflow: hidden;
    box-shadow: 4px 4px 3px rgba(20%,20%,40%,0.5);
	}
	
	.event_icon {
    padding-left: 20px;
    background-image: url("<%=request.getContextPath()%>/back/images/sedan-512.png");
    background-size: 100%;
    background-repeat: no-repeat;
    background-position: 2px 50%;
    background-color: #3a87ad00;
    font-family: Microsoft JhengHei;
    font-weight: bold;
    text-align: left;
    position: relative;
    display: block;
    font-size: 30px;
    line-height: 1.3;
    border-radius: 3px;
    border: 1px solid #bdbdbd00;
    height: 50px;
    width: auto;
    color: #e8bb14;
    opacity: 0.8;
	}
	
	/* 車型按鈕 */
	.btn {
	  position: relative;
	  display: inline-block;
	  letter-spacing: 1.2px;
	  padding: 12px 32px;
	  text-align: center;
	  text-transform: uppercase;
	  overflow: hidden;
	  z-index: 1;
	  cursor: pointer;
	}
	.btn:focus {
	  outline: none;
	}
	.btn--primary {
	  color: lightslategray;
	}
	.btn--border {
	  border-width: 1px;
	  border-style: solid;
	  border-radius: 10px;
	  box-sizing: border-box;
	}
	.btn--animated {
	  transition-property: color;
	  transition-duration: 0.5s;
	}
	.btn--animated.btn--border.btn--primary {
	  border: 1px solid lightslategray;
	}
	.btn--animated:before {
	  content: "";
	  position: absolute;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background: lightslategray;
	  transform: scaleX(0);
	  transform-origin: 0 50%;
	  transition-property: transform;
	  transition-duration: 0.5s;
	  transition-timing-function: ease-out;
	  z-index: -1;
	}
	.btn--animated:hover {
	  color: white;
	}
	.btn--animated:hover:before {
	  transform: scaleX(1);
	  transition-timing-function: cubic-bezier(0.45, 1.64, 0.47, 0.66);
	}
	/* 3D按鈕 */
	.btn3d {
    position:relative;
    top: -6px;
    border:0;
     transition: all 40ms linear;
     margin-top:10px;
     margin-bottom:10px;
     margin-left:2px;
     margin-right:2px;
	}
	.btn3d:active:focus,
	.btn3d:focus:hover,
	.btn3d:focus {
	    -moz-outline-style:none;
	         outline:medium none;
	}
	.btn3d:active, .btn3d.active {
	    top:2px;
	}
	
	.btn3d.btn-success {
    box-shadow:0 0 0 1px #31c300 inset, 0 0 0 2px rgba(255,255,255,0.15) inset, 0 8px 0 0 #5eb924, 0 8px 8px 1px rgba(0,0,0,0.5);
    background-color:#78d739;
	}
	.btn3d.btn-success:active, .btn3d.btn-success.active {
    box-shadow:0 0 0 1px #30cd00 inset, 0 0 0 1px rgba(255,255,255,0.15) inset, 0 1px 3px 1px rgba(0,0,0,0.3);
    background-color: #78d739;
	}
	.media-object {
    display: block;
    position: absolute;
    /* top: 120px; */
    left: 38px;
	}
	/* 員工BANNER */
	.titleName {
    background-image: url(<%=request.getContextPath()%>/back/image/car/titleName.png);
    background-size: 100%;
    background-repeat: no-repeat;
    background-position: 2px 50%;
    background-color: #3a87ad00;
    display: block;
    border-radius: 3px;
    border: 1px solid #bdbdbd00;
    height: 50px;
    width: auto;
    color: #dde8e8;
    opacity: 0.8;
    text-align:center
    
	}
	.media-heading {
    display: block;
    position: absolute;
    margin-left: 225px;
    top: 8px;
	}
	.media, .media-body {
    margin-left: 120px;
    overflow: hidden;
    zoom: 1;
    margin-top: 0;
	}
	/* 事件圖示 */
	.hot
	{ position: absolute;
		top:25%;
		left:20%;
		background:linear-gradient( to top right, rgba(255,87,34,1) 0%,
		rgba(251,140,0 ,1) 100%);
		box-shadow: 1px 1px 30px rgba(255,111,0 ,1);
	}
	.sun
	{
		position: absolute;
		top:-10%;
		left:65%;
		width:50px;
		height: 50px;
		border-radius: 100%;
		background:linear-gradient( to bottom left, rgba(255,235,59,1) 0%,
		rgba(249,168,37 ,1) 90%);
		box-shadow: 1px 1px 30px rgba(255,160,0 ,1);
		animation: inex 3s infinite linear ;
		
	}
	
	.sunx
	{
		position: absolute;
		top:30%;
		left:45%;
		width:10px;
		height: 10px;
		border-radius: 100%;
		background-color: #fff;
		opacity:0.2;
	}
	.cloudy
	{ position: absolute;
		top:25%;
		left:45%;
		background:linear-gradient( to top right, rgba(63,81,181,1) 0%,
		rgba(3,155,229 ,1) 40%);
		box-shadow: 1px 1px 30px rgba(2,119,189 ,1);
	
	}
	.cloud
	{
	position: absolute;
		top:5%;
		left:70%;
		width:60px;
		height: 20px;
		border-radius:10px;
		background-color: rgba(129,212,250 ,1);
		box-shadow: 1px 1px 30px rgba(0,151,167 ,1);
	animation: move 3s infinite linear ;
	
	}
	.cloudx
	{
		position: absolute;
		top:23%;
		left:55%;
		width:60px;
		height: 20px;
		border-radius:10px;
		background-color: rgba(129,212,250 ,1);
		animation: move 3s infinite linear ;
	
	}
	
	
	
	.cloudr
	{
	position: absolute;
		top:5%;
		left:60%;
		width:60px;
		height: 20px;
		border-radius:10px;
		background-color: rgba(96,125,139 ,1);
		box-shadow: 1px 1px 30px rgba(84,110,122 ,1);
	animation: flash 1.5s infinite linear;
	
	}
	
	.moon
	{
		position: absolute;
		top:-10%;
		left:65%;
		width:50px;
		height:50px;
		border-radius: 100%;
		background:rgba(255,241,118 ,1);
		box-shadow: 1px 1px 30px rgba(224,224,224 ,1);
	}
	.spot1
	{
		position: absolute;
		top:0%;
		left:85%;
		width:10px;
		height: 10px;
		border-radius: 100%;
		background-color: #777;
	}
	.spot2
	{
		position: absolute;
		top:30%;
		left:75%;
		width:5px;
		height: 5px;
		border-radius: 100%;
		background-color: #777;
	}




@keyframes inex {


	50% {
	opacity: 0.4;

	}
	60%
	{
		opacity: 1;
	}
}
@keyframes move {


	50% {
	transform: translateX(-10px);

	}
}
@keyframes fall {
10%
{
	opacity:0.8;
}

	50% {
		opacity:1;
	transform: translate(-10px,30px);

	}
	100%
	{
		transform: translate(-25px,70px);

		
	}
}
@keyframes flash
{
	48%
	{
		background-color: rgba(96,125,139 ,1);
	}
	50%
	{
		background-color: #fff;
	}
	55%
	{
		background-color: rgba(96,125,139 ,1);
	}
	57%
	{
		background-color: #fff;	
	}
	}
	@keyframes meteor
	{
	
	10%
	{opacity: 1;
	}
	80%	
	{
	left:10%;
	top:75%;
	opacity: 0;
	}
	}
	
	/* 事件選單 */
	  .animate {
		-webkit-transition: all 0.3s ease-in-out;
		-moz-transition: all 0.3s ease-in-out;
		-o-transition: all 0.3s ease-in-out;
		-ms-transition: all 0.3s ease-in-out;
		transition: all 0.3s ease-in-out;
	}

	.navbar-fixed-left {
		position: fixed;
		top: 0px;
		left: 0px;
		border-radius: 0px;
	}

	.navbar-minimal {
		width: 60px;		
		min-height: 60px;
		max-height: 100%;
		background-color: rgb(51, 51, 51);
		background-color: rgba(51, 51, 51, 0.8);
		border-width: 0px;
		z-index: 1000;
	}

	.navbar-minimal > .navbar-toggler {
		position: relative;
		min-height: 60px;
		border-bottom: 1px solid rgb(81, 81, 81);
		z-index: 100;
		cursor: pointer;
	}

	.navbar-minimal.open > .navbar-toggler,
	.navbar-minimal > .navbar-toggler:hover {
		background-color: rgb(158, 202, 59);
	}

	.navbar-minimal > .navbar-toggler > span {
		position: absolute;
		top: 50%;
		right: 50%;
		margin: -8px -8px 0 0;
		width: 16px;
		height: 16px;
		background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE2LjIuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjMycHgiIHZpZXdCb3g9IjAgMCAxNiAzMiIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgMTYgMzIiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTEsN2gxNGMwLjU1MiwwLDEsMC40NDgsMSwxcy0wLjQ0OCwxLTEsMUgxQzAuNDQ4LDksMCw4LjU1MiwwLDgKCVMwLjQ0OCw3LDEsN3oiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiNGRkZGRkYiIGQ9Ik0xLDEyaDE0YzAuNTUyLDAsMSwwLjQ0OCwxLDFzLTAuNDQ4LDEtMSwxSDFjLTAuNTUyLDAtMS0wLjQ0OC0xLTEKCVMwLjQ0OCwxMiwxLDEyeiIvPgo8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTEsMmgxNGMwLjU1MiwwLDEsMC40NDgsMSwxcy0wLjQ0OCwxLTEsMUgxQzAuNDQ4LDQsMCwzLjU1MiwwLDMKCVMwLjQ0OCwyLDEsMnoiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiNGRkZGRkYiIGQ9Ik0xLjMzLDI4Ljk3bDExLjY0LTExLjY0YzAuNDU5LTAuNDU5LDEuMjA0LTAuNDU5LDEuNjYzLDAKCWMwLjQ1OSwwLjQ1OSwwLjQ1OSwxLjIwNCwwLDEuNjYzTDIuOTkzLDMwLjYzM2MtMC40NTksMC40NTktMS4yMDQsMC40NTktMS42NjMsMEMwLjg3MSwzMC4xNzQsMC44NzEsMjkuNDMsMS4zMywyOC45N3oiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiNGRkZGRkYiIGQ9Ik0yLjk5MywxNy4zM2wxMS42NDEsMTEuNjRjMC40NTksMC40NTksMC40NTksMS4yMDQsMCwxLjY2MwoJcy0xLjIwNCwwLjQ1OS0xLjY2MywwTDEuMzMsMTguOTkzYy0wLjQ1OS0wLjQ1OS0wLjQ1OS0xLjIwNCwwLTEuNjYzQzEuNzg5LDE2Ljg3MSwyLjUzNCwxNi44NzEsMi45OTMsMTcuMzN6Ii8+Cjwvc3ZnPgo=);
		background-repeat: no-repeat;
		background-position: 0 0;
		-webkit-transition: -webkit-transform .3s ease-out 0s;
		-moz-transition: -moz-transform .3s ease-out 0s;
		-o-transition: -moz-transform .3s ease-out 0s;
		-ms-transition: -ms-transform .3s ease-out 0s;
		transition: transform .3s ease-out 0s;
		-webkit-transform: rotate(0deg);
		-moz-transform: rotate(0deg);
		-o-transform: rotate(0deg);
		-ms-transform: rotate(0deg);
		transform: rotate(0deg);
	}

	.navbar-minimal > .navbar-menu {
		position: absolute;
		top: -1000px;
		left: 0px;
		margin: 0px;
		padding: 0px;
		list-style: none;
		z-index: 50;
		background-color: rgb(51, 51, 51);
		background-color: rgba(51, 51, 51, 0.8);
	}
	.navbar-minimal > .navbar-menu > li {
		margin: 0px;
		padding: 0px;
		border-width: 0px;
		height: 54px;
	}
	.navbar-minimal > .navbar-menu > li > a {
		position: relative;
		display: inline-block;
		color: rgb(255, 255, 255);
		text-align: left;
		cursor: pointer;
		border-bottom: 1px solid rgb(81, 81, 81);
		width: 100%;
		text-decoration: none;
		margin: 0px;
	}

	.navbar-minimal > .navbar-menu > li > a:last-child {
		border-bottom-width: 0px;
	}
	.navbar-minimal > .navbar-menu > li > a:hover {
		background-color: rgb(158, 202, 59);
	}
	.navbar-minimal > .navbar-menu > li > a > .glyphicon {
		float: right;
	}

	.navbar-minimal.open {
		width: 320px;
	}

	.navbar-minimal.open > .navbar-toggler > span {
		background-position: 0 -16px;
		-webkit-transform: rotate(-180deg);
		-moz-transform: rotate(-180deg);
		-o-transform: rotate(-180deg);
		-ms-transform: rotate(-180deg);
		transform: rotate(-180deg);
	}

	.navbar-minimal.open > .navbar-menu {
		top: 60px;
		width: 100%;
		min-height: 100%;
	}

	@media (min-width: 768px) {
		.navbar-minimal.open {
			width: 60px;
		}
		.navbar-minimal.open > .navbar-menu {
			overflow: visible;
		}
		.navbar-minimal > .navbar-menu > li > a > .desc {
			position: absolute;
			display: inline-block;
			top: 50%;
			left: 130px;
			margin-top: -20px;
			margin-left: 20px;
			text-align: left;
			white-space: nowrap;
			padding: 10px 13px;
			border-width: 0px !important;
			background-color: rgb(51, 51, 51);
			background-color: rgba(51, 51, 51, 0.8);
			opacity: 0;
		}
		.navbar-minimal > .navbar-menu > li > a > .desc:after {
			z-index: -1;
			position: absolute;
			top: 50%;
			left: -10px;
			margin-top: -10px;
			content:'';
			width: 0;
			height: 0;
			border-top: 10px solid transparent;
			border-bottom: 10px solid transparent; 	
			border-right: 10px solid rgb(51, 51, 51);
			border-right-color: rgba(51, 51, 51, 0.8);
		}
		.navbar-minimal > .navbar-menu > li > a:hover > .desc {
			left: 60px;
			opacity: 1;
		}
		}
		.navbar-minimal.open > .navbar-toggler, .navbar-minimal > .navbar-toggler:hover {
   		 background-color: rgb(248, 182, 74);
		}
		#sendSCbtn{
			width: 50px;
			height: 50px;
			margin-left: 5px;
		}
		#deleter{
			width: 100px;
			height: 100px;
			margin-left: 5px;
			margin-top: 0px;
		}
		#reload{
			width: 50px;
			height: 50px;
			margin-left: 5px;
		}
		/* 月曆上事件圖示 */
	   .mo {
       padding-left: 20px;
       background-image: url('<%=request.getContextPath() %>/back/image/car/mo.png');  
       background-size: 17px 17px;
       background-repeat: no-repeat;
       background-position: 2px 50%;
       }
       .af {
       padding-left: 20px;
       background-image: url('<%=request.getContextPath() %>/back/image/car/af.png');  
       background-size: 17px 17px;
       background-repeat: no-repeat;
       background-position: 2px 50%;
       }
       .ni {
       padding-left: 20px;
       background-image: url('<%=request.getContextPath() %>/back/image/car/ni.png');  
       background-size: 17px 17px;
       background-repeat: no-repeat;
       background-position: 2px 50%;
       }
       
		
</style>
<title>有我罩你-派車人員排班表</title>
</head>
<body onload="connect();" onunload="disconnect();">

<%@ include file="/back/production/BA104G1_navbar_sidebar.jsp" %> 

  <!-- page content -->
     <div class="right_col" role="main">
          <div class="">

           <!--  <div class="page-title">
              <div class="title_left" style="background-color:#337ab7;height:100px;width:100%">
			      <h1 class="text-center" style="color:white;margin-top:30px">派車班表管理</h1>
			</div>
              </div> -->

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <!-- <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div> -->
                </div>
              </div>
            </div>


            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content"> 
         <!-- =================================排班表start================================= -->            
		
		
		<div id='wrap'>
		 <!-- =================================派車員工列表================================= -->  
		<div class="container">
	<div class="row">
        <div class="col-md-6">
            <div class = 'cartypechose'>
            <jsp:useBean id="cartypeSvc" scope="page" class="com.cartype.model.CarTypeService" />
            <c:forEach var="cartypeVO" items="${cartypeSvc.all}">
            <div class="btn btn--border btn--primary btn--animated cartype_btn" cartypeno = "${cartypeVO.cartypeno}">${cartypeVO.cartypename}</div>
            </c:forEach>
            </div>
            <div class="input-group">
              <span class="input-group-addon custom__addon blue_addon">
                <span class="glyphicon glyphicon-cog"></span> 選擇員工
              </span>
              
              <select class="form-control custom__select" id ="empSelect">
              
            	<%-- <% for(CarSchedulVO carSchedulVO : carSchedulSvc.getAll()){
            		emp_no = carSchedulVO.getEmp_no();
            		empName = empSvc.findByPrimaryKey(emp_no).getEmpName();
            		empTitle = empSvc.findByPrimaryKey(emp_no).getEmpTitle();%>
            		<option value="<%=emp_no%>" empTitle='<%=empTitle%>'><%=empName%></option>
            	<%}%> --%>
            	
            	
             </select>
            
            </div>
            <hr />
            
        </div>
         <div class="col-md-6">
        <div class="media">
            <a class="pull-left" href="#">
                <img class="media-object dp img-circle empPic" src="<%=request.getContextPath() %>/DBGifReader4?emp_photo_no="  style="width: 100px;height:100px;">
               
            </a>
            <div class="media-body">
                <div class='titleName'>
                <h4 class="media-heading">員工姓名</h4>
                </div>
                <h5 class="emptitle">專業司機 來自 <a href="#" class='loc'><b>桃園中心</b></a></h5>
                <hr style="margin:8px auto ;width:400px">

                <span class="label label-default phone">電話</span>
                <span class="label label-info cartype">四人座</span>
                <span class="label label-default workhours">服務時數:小時</span>
            </div>
        </div>

    </div>
	</div>
</div>
	<!-- 排班事件表-------------------------------- -->
	
  
		<div id='external-eventsbox'>
		
			<h4>排班選單</h4>
			 <nav class="navbar navbar-fixed-left navbar-minimal animate" role="navigation">
				 <div class="navbar-toggler animate">
					<span class="menu-icon"></span>
				 </div>
				<ul class="navbar-menu animate" id="external-events">
				<li>
					<a href="#" class="animate">
						<span class="desc animate">早班</span>
						<div class='fc-event event_icon' c='' b='08:00:00'><span class="cloud"></span><span class="cloudx"></span></div>
					</a>
				</li>
				<li>
					<a href="#" class="animate">
						<span class="desc animate">中班</span>
						<div class='fc-event event_icon' c='' b='13:00:00'><span class="sun"></span></div>
					</a>
				</li>
				<li>
					<a href="#" class="animate">
						<span class="desc animate">晚班</span>
						<div class='fc-event event_icon' c='' b='18:00:00'><span class="moon"></span><span class="spot1"></span><span class="spot2"></span></div>
					</a>
				</li>
				<li>
					
				
					<a href="#" class="animate">
					<img id="deleter" src="<%=request.getContextPath() %>/back/image/car/oie_trans.gif">
					</a>
				</li>
				<li>
					
				</li>
				
				<li>
					<a href="#" class="animate">
					<img id="reload" src="<%=request.getContextPath() %>/back/image/car/reload.png"">
					</a>
				</li>
				
				
				<li>
					<a href="#" class="animate">
					<img id="sendSCbtn" src="<%=request.getContextPath() %>/back/image/car/send_sc.png">
					</a>
				</li>
				</ul>
				
			</nav>
			
			
				<!-- <div id="deleter"></div> -->
			<!-- <p>
				<input type='checkbox' id='drop-remove' />
				<label for='drop-remove'>remove after drop</label>
				 
			</p> -->
			
		
		</div>
		<!-- =================================派車員工列表================================= -->  
		
		<div id='calendar'></div>

		<div style='clear:both'></div>
		
	</div>

	<!-- =================================排班表end================================= -->	
               </div>
                </div>
              </div>
            </div>

          </div>
        </div> 
        <!-- /page content -->
		
			
			 
                  
		
		
		
			<%@ include file="/back/production/BA104G1_footer.jsp" %>
	 
	 		<script src="<%=request.getContextPath()%>/back/js/carschedul/moment.min.js"></script><!-- -->
			<script src="<%=request.getContextPath()%>/back/carschedul/fullcalendar-3.7.0/lib/jquery.min.js"></script>
			<script src="<%=request.getContextPath()%>/back/carschedul/fullcalendar-3.7.0/lib/jquery-ui.min.js"></script>
			<script src="<%=request.getContextPath()%>/back/carschedul/fullcalendar-3.7.0/fullcalendar.js"></script><!-- -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.5/sweetalert2.all.js"></script><!-- 甜甜的sweetalert2 -->
			<script src='https://production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script>
			<script src="<%=request.getContextPath()%>/back/carschedul/fullcalendar-3.7.0/locale/zh-tw.js"></script>
			
		<script>
		var emp_no="";
	$(document).ready(function() {
		//載入頁面初始設定
		var empNameSelected =  $('.form-control :selected').text()
		$('.fc-event').attr('c' , empNameSelected);
		$('.media-heading').text(empNameSelected);
		$('.media-heading').text(empNameSelected);
		
		//事件選單
		
	    $('.navbar-toggler').on('click', function(event) {
			event.preventDefault();
			$(this).closest('.navbar-minimal').toggleClass('open');
		})
		

		/* initialize the external events
		-----------------------------------------------------------------*/

		$('#external-events .fc-event').each(function() {

			// store data so the calendar knows to render an event upon drop
			$(this).data('event', {
				title: $.trim($(this).attr('c')), // use the element's text as the event title
				start: $.trim($(this).attr('b')),
				stick: true, // maintain when user navigates (see docs on the renderEvent method)
				editable : true,
				overlap : false
			});

			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});

		});


		/* initialize the calendar
		-----------------------------------------------------------------*/
		
		
		var day = new Date();
		var month = day.getMonth()+1;
		console.log("這個月"+month)
		var year = day.getFullYear();
		console.log("這年"+year)
		var toDay = year+"-"+month+"-01";
		var work_hours;
		var empName;
		var cartype_no;
		var vehicle_No;
		
		
			$('#reload').click(function(){
				//emp_no=	$('#empSelect').val();
				console.log(emp_no);
				
				$("#empSelect option[value="+emp_no+"]").attr('selected', 'selected');
				 console.log('(reload)將選項已選改為'+emp_no);
				 selectInfo(cartype_no,toDay);	
				//切換工時
				empWorkHoursSelected = "本月服務時數:"+$('.form-control :selected').attr('work_hours')+"小時";
				$('.workhours').text(empWorkHoursSelected);
				$('#calendar').fullCalendar('removeEvents')
				$('#calendar').fullCalendar( 'refetchEvents' )
			}); 
			
		
		$('.cartype_btn').click(function(){
			cartype_no =$(this).attr('cartypeno');
			console.log(cartype_no);
			selectInfo(cartype_no,toDay);
			$('.form-control').empty();		
			$('#calendar').fullCalendar( 'refetchEvents' );
			
		});
		
			
			//班表切換員工
			$('#empSelect').change(function(){
					
				emp_no=	$(this).val();
				newEmpNo = $(this).val();
				console.log("切換器找到的員工編號:"+newEmpNo);
				$('#calendar').fullCalendar('removeEvents')
				$('#calendar').fullCalendar( 'refetchEvents' ) 
				//斷開連線
				disconnect ();
			    
				
				//切換員工資料區
				//切換員工照片
				var emp_photoNO = emp_no.replace(/EMP/, "EPH");
				var empPicURL = "<%=request.getContextPath() %>/DBGifReader4?emp_photo_no=" + emp_photoNO;
				console.log("empPicURL:"+empPicURL);
				$('.empPic').attr('src',empPicURL);
				
				
				
				empNameSelected =  $('.form-control :selected').text();
				$('.fc-event').attr('c' , empNameSelected);
				console.log(empNameSelected);
				//切換姓名
				$('.media-heading').text(empNameSelected);
				//切換工時
				empWorkHoursSelected = "本月服務時數:"+$('.form-control :selected').attr('work_hours')+"小時";
				$('.workhours').text(empWorkHoursSelected);
				//切換車型
				empCarTypeName = $('.form-control :selected').attr('car_type_name');
				$('.cartype').text(empCarTypeName);
				
				//切換車型
				empCarLoc = $('.form-control :selected').attr('empCarLoc');
				$('.loc').text(empCarLoc);
				
				//切換電話
				empPhone = "電話:0"+$('.form-control :selected').attr('phone');
				$('.phone').text(empPhone);
				
				
				//把時段事件替換成該員工的
				$('#external-events .fc-event').each(function() {

					// store data so the calendar knows to render an event upon drop
					$(this).data('event', {
						title: $.trim($(this).attr('c')), // use the element's text as the event title
						start: $.trim($(this).attr('b')),
						stick: true, // maintain when user navigates (see docs on the renderEvent method)
						editable : true,
						overlap : false
						
					});

					// make the event draggable using jQuery UI
					$(this).draggable({
						zIndex: 999,
						revert: true,      // will cause the event to go back to its
						revertDuration: 0  //  original position after the drag
					});

				});
				//取得新連線
				connect(newEmpNo);
			});
			
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: ''
			},
			locale: 'zh-tw',
			dragRevertDuration:0,
			contentHeight:'auto',
			defaultView: 'month',
			validRange:function(currentDate) { 
			    return { 
			        start: currentDate.clone().subtract(1, 'days'), 
			    };
			 },
			themeSystem: 'jquery-ui',
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
			},
			allDay: false,
			businessHours: { 
				dow: [ 0, 1, 2, 3, 4 ,5, 6], // 周一 - 周四 
			    start:'08:00',  
			    end: '22:00', 
			},
			
			slotDuration:'01:00:00',
			defaultTimedEventDuration:'04:00:00',
			
			//取回班表
			events:function(start, end, timezone, callback) {
				console.log(toDay)
                $.ajax({
                	
                    url:"<%=request.getContextPath()%>/carschedul/carschedul.do?action=fullCalendarSource&year_month="+toDay+"&emp_no="+ emp_no+"&cartype_no="+cartype_no,
                    cache:false,
                    success:function(data) {
                        
                        eval("var j=" + data);
                        var events = [];
                        console.log(j);
                        var info = j.eventinfo;
                        //偷渡車輛編號回來^_^
                        vehicle_No = j.vehicle_No;
                        console.log("取回來的vehicle_No:"+vehicle_No);
                        for (var i = 0; i < info.length; i++) {
                            var ev = info[i];
                            var title = ev.title;
                           	var evtstart = ev.start;
                            var evtend = ev.end;
                            var classname ="";
                            if(evtstart.substring(11,13) == "08"){
                           	  classname ="mo";
                            };
                            if(evtstart.substring(11,13) == "13"){
                              classname ="af";
                            };
                            if(evtstart.substring(11,13) == "18"){
                                classname ="ni";
                            };
                            
                            
                           
                            events.push({
                                title:title,
                                //2017-12-01T13:00:00
                                start:evtstart,
                                end:evtend,
                                className:classname
                            });
                        }
                        
                        callback(events);
                    },
                    error:function() {
                        
                    }
                })
            },
		        
			//判斷是否全天的CODE
		                   /*  var x;   
		                    if(ev.allDay=='true'){  
		                      x=true;  
		                    }else{  
		                        x=false;  
		                        
		                    }*/
		            
		           eventReceive:function(event) {
		        	   console.log('eventReceive:', event);
		           },
		           eventDrop:function(event) {
		        	   console.log('eventDrop:', event);
		           },
		           
		           eventDragStop:function(event , jsEvent) {
		        	   
		        	   var trashEl = $('#deleter');
		        	   var ofs = trashEl.offset();
		        	   
		        	   var x1 = ofs.left;
		        	   var x2 = ofs.left + trashEl.outerWidth(true);
		        	   var y1 = ofs.top;
		        	   var y2 = ofs.top + trashEl.outerHeight(true);
		        	   if(jsEvent.pageX >= x1 && jsEvent.pageX <= x2 &&
		        			   jsEvent.pageY  >= y1 && jsEvent.pageY <= y2) {
		        		   	
		        		   $(this).remove();
		        		   $('#calendar').fullCalendar('removeEvents', event._id);
		        			 
		        	   }
		         },
		          
			
			
			eventClick: function(calEvent, jsEvent, view) { 
		      /*   alert('Event: ' + calEvent.title); 
		        alert('start: ' + calEvent.start.format("YYYY-MM-DD"));
		        
		        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY); 
		        alert('View: ' + view.name);  */
		        //$('#calendar').fullCalendar('removeEvents',calEvent.id)
		        // change the border color just for fun 
		        //$(this).css('border-color', 'red'); 
		     	 //查找明細
		   	 	
		         var vno = vehicle_No;
		   		 var detail_date = calEvent.start.format("YYYY-MM-DD");
		   		 
		   	 		console.log("點擊事件:"+vehicle_No+","+detail_date)
		   	 		 findList(vno,detail_date);
		   	 	var tsa = tableStringAll;
		   	 	
				
		    },
		    
		 	 
		});
		
		/* function toDay(){
			var moment = $('#calendar').fullCalendar('getDate');
			 today = moment.format("YYYY-MM");
			 toDay = today + "-01";
			 // 轉為 MM/DD/YYYY 字串格式
			 console.log("本月:"+toDay);
			return toDay;
 		}; */
 		
		 $('.ui-button').click(function(){
		//得到今日年月日
	    var moment = $('#calendar').fullCalendar('getDate');
		 today = moment.format("YYYY-MM");
		 toDay = today + "-01";
		 // 轉為 MM/DD/YYYY 字串格式
		 $('#calendar').fullCalendar( 'refetchEvents' ) 
		 console.log("本月:"+toDay);
		}); 
	   	
		 $('#sendSCbtn').click(function(){
			 var fullCalendarArray =[];
			 var eventsList=[];
			 fullCalendarArray = $('#calendar').fullCalendar('clientEvents');
			// console.log("排班表array:"+fullCalendarArray);
		
		 
		 for(i = 0;i<fullCalendarArray.length;i++){
			 
			 var evtitle = fullCalendarArray[i].title;
			 var evstart = fullCalendarArray[i].start;
			 //console.log("前端排班title:"+ title);
			 var sfd = moment(evstart).format('YYYY-MM-DD,HH');
			 //console.log("前端排班start:"+  sfd);	
			 eventsList.push({title:evtitle,start:evstart});
		 }
			 var jsonText = JSON.stringify(eventsList);
			 var eventSendString = {action:"fullCalendarInsert",empno:emp_no,setEventsInfo:jsonText};
			 console.log("AAA:"+eventsList);
			 $.ajax({
				 type: "POST",
				 url: "<%=request.getContextPath()%>/carschedul/carschedul.do",
				 data: eventSendString,
				 dataType: "json",
				 
				 success: function (data){
					
						 console.log(data);
						 
					
					 sendMessage();
			     },
	            error: function(){
	            	
	            	sendMessage();
	            }
	       })
		 
		});
		   

		 function creatQueryString(year_month, emp_no){
				console.log("year_month:"+year_month+"; emp_no:"+emp_no);
				var queryString= {"action":"fullCalendarSource", "year_month":year_month, "emp_no":emp_no};
				return queryString;
		
	 	};
	 function selectInfo(cartype_no,toDay){
	 	 var SendString = {"action":"getEmpNo","cartype_no":cartype_no,"year_month":toDay};
	 	 
		 console.log("3.送出資料檢查:"+SendString);
		 $.ajax({
			 type: "POST",
			 url: "<%=request.getContextPath()%>/carschedul/carschedul.do",
			 data: SendString,
			 dataType: "json",
			 
			 success: function (data){
				 
               
                 var info = data.empScList;
                 console.log("ajax接到的選單資料:"+info);
                 //emp_no = info2[0];
                 $('.form-control').empty();
                 $("#empSelect").append($("<option value='0'>請選擇員工</option>"))
                 for (var i = 0; i < info.length; i++) {
                     var ev = info[i];
                     var emp_no = ev.emp_no;
                     var work_hours = ev.work_hours;
                     var empName = ev.empName; 
                     var car_type_name = ev.carTypeName;
                     var empCarLoc = ev.empCarLoc;
                     var phone = ev.phone;
                    
                     $("#empSelect").append($("<option value='"+emp_no+"' work_hours='"+work_hours+"'car_type_name='"+car_type_name+
                    		 "'empCarLoc='"+empCarLoc+"'phone='"+phone+"'>"+empName+"</option>"))
                     
                 }
                 
		     },
            error: function(){alert("撈選單資料失敗!!請再重新選擇車型")}
       })
	 }; 
	 
	
	 
	 
	
	//找訂單明細的ajax
		function findList(vehicle_no,detail_date){
			 var SendString = {"action":"get_BY_CAR_For_Display","vehicle_no":vehicle_no,"detail_date":detail_date};
			 console.log('取明細送出資料，車輛編號:'+vehicle_no+",明細時間:"+detail_date);
			 console.log("送出資料檢查:"+SendString);
			 $.ajax({
				 type: "POST",
				 url: "<%=request.getContextPath()%>/cardetail/cardetail.do",
				 data: SendString,
				 dataType: "json",
				 
				 success: function (data){
					 var orderStatus = data.cardetailList;
		          console.log("取回來的訂單明細:"+orderStatus);
		          //$(".dttbody").empty();
		         
		          var tableStringAll ="";
		          for (var i = 0; i < orderStatus.length; i++) {
	                  var cd = orderStatus[i];
	                  var detail_no = cd.detail_no;
	                  console.log("取回來的明細編號:"+detail_no);
	                  var detail_date = cd.detail_date;
	                  var detail_time = cd.detail_time; 
	                  var detail_timeString;
	                  if(detail_time == "M"){
				    		 detail_timeString = "早";
				    	 }
				    	 if(detail_time == "A"){
				    		 detail_timeString = "中";
				    	 }
				    	 if(detail_time == "N"){
				    		 detail_timeString = "晚";
				    	 }
	                  
	                  
	                  var passenger_name = cd.passenger_name;
	                  var passenger_phone = cd.passenger_phone;
	                  var getinto_address = cd.getinto_address; 
	                  var arrival_address = cd.arrival_address;
	                  var vehicle_no = cd.vehicle_no;
	                  var sendcar_status = cd.sendcar_status;
	                  var tableString = "<tr><td><a href='<%=request.getContextPath()%>/back/carorder/listAllCarOrder.jsp'>"+detail_no+"</a></td><td>"+detail_date+"</td><td>"+detail_timeString+"</td><td>"+passenger_name+"</td><td>0"
	                		  +passenger_phone+"</td><td>"+getinto_address+"</td><td>"+arrival_address+"</td><td>"+vehicle_no+"</td><td>"+sendcar_status+"</td></tr>"
	                		  console.log("明細td字串1:"+tableString);  	  
	                tableStringAll =tableStringAll + tableString;
	                
	              }
		          
		          console.log('明細td字串2:'+tableStringAll);  
		          
		          
		          swal({
					  title: '訂單明細',
					  type: 'info',
					  width: 'auto',
					  html:'<table class="table table-striped text-center">'+
	              	'<thead>'+
				         '<tr>'+
				           	  '<th class="text-center"> 明細編號</th>'+
				              '<th class="text-center"> 明細日期 </th>'+
				              '<th class="text-center"> 明細時段 </th>'+
				              '<th class="text-center"> 乘客姓名 </th>'+
				              '<th class="text-center"> 乘客電話 </th>'+
				              '<th class="text-center"> 上車地點 </th>'+
				              '<th class="text-center"> 目的地 </th>'+
				              '<th class="text-center"> 搭乘車號 </th>'+
				              '<th class="text-center"> 派車狀態 </th>'+
				          '</tr>'+ 
				         '</thead>'+
				         '<tbody class="dttbody">'+
				         	
				         
				         tableStringAll+
				         
				         
				         '</tbody>'+
	           
	              	'</table>',
					  showCloseButton: true,
					 
					
					})
		         },

		       error: function(){alert("訂單明細不存在!!")}
		  })
		}; 
		
	 
	 
	 
	});
	
	//推播  (主管)
	
	
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    
    
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	function connect(newEmpNo) {
		// 建立 websocket 物件
		var MyPoint = "/SchedulEchoServer/shift/"+newEmpNo;
		var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
		webSocket = new WebSocket(endPointURL);
		console.log("我現在的連線為:"+endPointURL)
		webSocket.onopen = function(event) {
			console.log("WebSocket 成功連線");
			
		};

		webSocket.onmessage = function(event) {
		
		};

		webSocket.onclose = function(event) {
			console.log("WebSocket 已離線");
		};
	}

	function sendMessage() {
	    var userName = "預設";
	    if (userName === ""){
	        alert ("找不到該員工!");
	        inputUserName.focus();	
			return;
	    }
	    var emp_no = "EMP0018"
	   // var message = inputMessage.value.trim();
	    var message = "班表已更新，請檢查本月最新的班表!!";
	    if (message === ""){
	        alert ("訊息請勿空白!");
	    }else{
	        var jsonObj = {"userName" : emp_no, "message" : message};
	        webSocket.send(JSON.stringify(jsonObj));

	    }
	}

	
	function disconnect () {
		webSocket.close();
		
	}
	
	
	

</script>
							
</body>
</html>