<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>

<%@ page import="com.member.model.*"%>
<%@ include file="/front/navbar.jsp"%>

<jsp:useBean id="shopOrderSvc" scope="page"
	class="com.shoporder.model.ShopOrderService" />


<%
	String orderNO = "0";
%>

<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front/css/navbar/bootstrap.css"
	media="screen">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front/css/navbar/usebootstrap.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front/css/navbar/newstyle_footer.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.3/sweetalert2.css">


<!-- 歐歐加的 -->
<%@ include file="/front/css/complain/com.file"%>
<!-- 歐歐加的 -->

</head>

<body>
	<div class="container">
		<div class="row">

			<br> <br>
			<hr>
			<img alt=""
				src="<%=request.getContextPath()%>/img/member/longterm4.jpg">

			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/index.jsp">首頁</a></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/front/member/MemberInfo.jsp">會員資料管理</a></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/front/member/MyWallet.jsp">我的錢包</a></li>
				<li class="breadcrumb-item active" aria-current="page"><a
					href="<%=request.getContextPath()%>/front/member/MemberHcOrder.jsp">訂單管理</a></li>
			</ol>
			<!-- ----------------------下方訂單管理區選項------------------------->
			<ul class="nav nav-tabs" id="navList">
				<li data-name="loginLogTab"><a
					href="<%=request.getContextPath()%>/front/member/MemberHcOrder.jsp">
						<i class="fa fa-briefcase"></i>長照訂單
				</a></li>
				<li data-name="receiveLogTab"}><a
					href="<%=request.getContextPath()%>/front/member/MemberCarOrder.jsp">
						<i class="fa fa-briefcase"></i>派車訂單
				</a></li>
				<li data-name="socketInputTab"><a
					href="<%=request.getContextPath()%>/front/member/MemberMealOrder.jsp">
						<i class="fa fa-briefcase"></i>派餐訂單
				</a></li>
				<li data-name="socketOutputTab" class="active"><a
					href="<%=request.getContextPath()%>/front/member/MemberShopOrder.jsp">
						<i class="fa fa-briefcase"></i>商城訂單
				</a></li>

			</ul>
			<!-- ----------------------上方訂單管理區選項------------------------->

			<div class="row">


				<div class="container-fluid">
					<div class="row">
						<table class="table table-hover">
							<thead>
								<tr>
									<th class="text-center">
										<div class="col-sm-2">訂單編號</div>
										<div class="col-sm-2">訂購日期</div>
										<div class="col-sm-2">客戶名稱</div>
										<div class="col-sm-2">客戶電話</div>
										<div class="col-sm-2">客戶地址</div>
										<div class="col-sm-2">申訴</div>
									</th>
								</tr>
							</thead>
							<tbody>



								<tr>
									<td>

										<div class="panel-group" id="accordion2" role="tablist"
											aria-multiselectable="true">

											<c:forEach var="shopOrder"
												items="${shopOrderSvc.getOneByMenNO(memberVO.memNo)}"
												varStatus="s">

												<div class="panel panel-default">
													<div class="panel-heading" role="tab" id="panel${s.index}">
														<h4 class="panel-title text-center">
															<div class="row">
																<div class="col-xs-12 col-sm-2">
																	<a href="#aaa${s.index}" data-parent="#accordion2"
																		data-toggle="collapse" role="button"
																		aria-expanded="true" aria-controls="aaa">
																		${shopOrder.orderno}</a>
																</div>
																<div class="col-xs-12 col-sm-2 newsTime">${shopOrder.order_date}</div>
																<div class="col-xs-12 col-sm-2">${shopOrder.customer_name}</div>
																<div class="col-xs-12 col-sm-2">${shopOrder.customer_phone}</div>
																<div class="col-xs-12 col-sm-2">${shopOrder.customer_address}</div>
																<div class="col-xs-12 col-sm-2">
																	<div>
																		<p class="col-text" data-toggle="modal"
																			data-target="#ansower">
																			<input type="button"
																				class="btn btn-danger clickDetail" value="申訴">
																			<input type="hidden" name="orderNo"
																				class="order_noBtn" value="${shopOrder.orderno}">
																			<input type="hidden" name="action"
																				value="getOne_For_Update_front">
																		<p>
																	</div>

																</div>
															</div>
														</h4>
													</div>


													<div id="aaa${s.index}" class="panel-collapse collapse"
														role="tabpanel" aria-labelledby="panel${s.index}">
														<div class="panel-body">
															<table class="table table-hover text-center">
																<thead>
																	<tr>
																		<th class="text-center">明細編號</th>
																		<th class="text-center">服務日期</th>
																		<th class="text-center">服務時段</th>
																		<th class="text-center">服務人員</th>
																		<th class="text-center">明細狀態</th>
																	</tr>
																</thead>
																<tbody>
																	<c:forEach var="detail"
																		items="${hcDetailSvc.getAllByOrderNo(hcOrder.orderNo)}">

																		<tr>
																			<td>${detail.orderDetailNo}</td>
																			<td>${detail.serviceDate}</td>
																			<td>${detail.serviceTime}</td>
																			<td>${empSvc.findByPrimaryKey(detail.empNo).empName}</td>
																			<td>${detail.orderDetailStataus}</td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>

												</div>
											</c:forEach>
										</div>


									</td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/front/footerbar.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			for (i = 0; i++; i < 100) {
				$("#panel" + i).click(function() {
					$("#aaa" + i).toggle();

				});
			}
		});
		$(document).ready(function() {
			$("#panel0").click(function() {
				$("#aaa0").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel1").click(function() {
				$("#aaa1").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel2").click(function() {
				$("#aaa2").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel3").click(function() {
				$("#aaa3").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel4").click(function() {
				$("#aaa4").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel5").click(function() {
				$("#aaa5").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel6").click(function() {
				$("#aaa6").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel7").click(function() {
				$("#aaa7").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel8").click(function() {
				$("#aaa8").toggle();

			});
		});
		$(document).ready(function() {
			$("#panel9").click(function() {
				$("#aaa9").toggle();

			});
		});
	</script>
	<!--  跟navbar js會衝突 所以共用即可 ======-->
	<%-- <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
			<script
				src="<%=request.getContextPath()%>/front/js/navbar/bootstrap.min.js"></script>
			<script
				src="<%=request.getContextPath()%>/front/js/navbar/usebootstrap.js"></script> --%>
	<!--  跟navbar js會衝突 所以共用即可 ======-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.3/sweetalert2.min.js"></script>
</body>

<!-- 歐歐加的 -->
<%@ include file="/front/complain/AllCom.jsp"%>
<%@ include file="/front/complain/ShopCom.file"%>
<!-- 歐歐加的 -->


</html>