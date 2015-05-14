<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@  page import="com.zh.base.util.JspUtil" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:property value="getText('COM.OSFI.WINDOW.TITLE')" /></title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet" href="<%=path%>/css/font-awesome.css">
<link rel="stylesheet" href="<%=path%>/js/select2/select2.css">
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/jqPaginator.min.js"></script>
<!-- Demo page code -->
<style type="text/css">
#line-chart {
	height: 300px;
	width: 800px;
	margin: 0px auto;
	margin-top: 1em;
}

.brand {
	font-family: georgia, serif;
}

.brand .first {
	color: #ccc;
	font-style: italic;
}

.brand .second {
	color: #fff;
	font-weight: bold;
}
</style>
<link href="<%=path%>/img/favicon_32.ico" rel="bookmark"
	type="image/x-icon" />
<link href="<%=path%>/img/favicon_32.ico" rel="icon" type="image/x-icon" />
<link href="<%=path%>/img/favicon_32.ico" rel="shortcut icon"
	type="image/x-icon" />
</head>
<!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
<!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
<!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
<!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<body class="">
<jsp:useBean id="userName" class="com.zh.base.util.JspUtil" scope="session"></jsp:useBean>
	<!--<![endif]-->
	<%@ include file="/pages/common/titleWithNav.jsp"%>
	<%@ include file="/pages/common/sidebarWithNav.jsp"%>

	<div class="content">
		<div class="header">
			<div class="stats">
				<p class="stat">
					<span class="number">53</span>tickets
				</p>
				<p class="stat">
					<span class="number"><s:property value="#session.taskSize" /></span>tasks
				</p>
				<p class="stat">
					<span class="number">15</span>waiting
				</p>
			</div>

			<h1 class="page-title" id="menu2Name">&nbsp;</h1>
		</div>

		<ul class="breadcrumb">
			<li><a href="<%=path%>/home/main.jspa">主页</a> <span
				class="divider">/</span></li>
			<li><a href="" id="navigation"></a> <span class="divider">/</span></li>
			<li class="active">查看</li>
		</ul>
		<div class="container-fluid">
				<input type="hidden" id="formChanged" name="formChanged" value="0" />
				<div class="row-fluid">

					<div class="btn-toolbar">
						
						<a class="btn" id="backList" href=""> 返回</a>
						<div class="btn-group"></div>
						
					</div>
					<div class="well">
						<ul class="nav nav-tabs">
							<li class="active"><a id="homeButt" href="#home" data-toggle="tab">基本信息</a></li>
							<li><a id="storagedetailButt" href="#storagedetail" data-toggle="tab">出库清单</a></li>
						</ul>
						<div id="myTabContent" class="tab-content">
							<dl class="tab-pane active dl-horizontal" id="home">
								<dir class="row">
									<div class="span4">
										<div class="control-group">
											<dt>出库单号：</dt>
											<dd>${libraryPrimary.orderNoID}</dd>
										</div>
									</div>
									
									<div class="span4">
										<div class="control-group">
											<dt>出库时间：</dt>
											<dd>
												${libraryPrimary.librarydate}
											</dd>
										</div>
									</div>
								</dir>
								
								<dir class="row">
									<div class="span4">
										<div class="control-group">
											<dt>发货人：</dt>
											<dd><%=userName.queryUserName(String.valueOf(request.getAttribute("libraryPrimary.userID"))) %></dd>
										</div>
									</div>
									<div class="span4">
										<div class="control-group">
											<dt>接收客户：</dt>
											<dd>
												<s:iterator value="customerList" var="tp" status="index">
													<s:if test="#tp.id == libraryPrimary.customerID">
														<s:property value="#tp.name"/>
													</s:if>
												</s:iterator>
											</dd>
										</div>
									</div>
								</dir>
								
								<dir class="row">
									<div class="span4">
										<div class="control-group">
											<dt>发货仓库：</dt>
											<dd>
												<s:iterator value="warehouseList" var="tp" status="index">
													<s:if test="#tp.id == libraryPrimary.warehouseID">
														<s:property value="#tp.name"/>
													</s:if>
												</s:iterator>
											</dd>
										</div>
									</div>
									<div class="span4">
										<div class="control-group">
											<dt>出库：</dt>
											<dd>
												<s:if test="#libraryPrimary.status==0">
													否
												</s:if>
												<s:else>
													是
												</s:else>
											</dd>
										</div>
									</div>
								</dir>
								
								<dir class="row">
									<div class="span8">
										<div class="control-group">
											<dt>备注：</dt>
											<dd>${libraryPrimary.remarks}</dd>
										</div>
									</div>
								</dir>
							</dl>
							
							<div class="tab-pane fade" id="storagedetail">
								<table class="table ">
									<thead>
										<tr>
											<th>序号</th>
											<th>产品编号</th>
											<th>产品名称</th>
											<th>出库数量</th>
											<th>库存量</th>
											<th>用途</th>
											<th>备注</th>
										</tr>
									</thead>
									
									<tbody id="maillistSearch">
										<tr>
											<!-- 产品列表-->
										<s:iterator value="libraryDetailList" var="tp" status="index">
										<tr>
											<td><s:property value="#index.index +1" /></td>
											<td><s:property value="#tp.productsID" /></td>
											<td><s:property value="#tp.productsName" /></td>
											<td><s:property value="#tp.storageNumber" /></td>
											<td>
												<s:if test="#tp.storageNumber > #tp.stockNumber">
													<span style="color: red">
												</s:if>
												<s:else>
													<span>
												</s:else>
														<s:property value="#tp.stockNumber" />
													</span>
											</td>
											<td><s:property value="#tp.use" /></td>
											<td><s:property value="#tp.remarks" /></td>
										</tr>
										</s:iterator>
											
										</tr>
									</tbody>
								</table>
								<div class="pagination">
									<ul id="pagination">
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
		</div>
	</div>
	
	<form action="${menu2Id}.jspa?menuId=${menuId}&menu2Id=${menu2Id}" id="queryForm" method="post">
		<input id="curPage" name="pageInfo.curPage" value="${pageInfo.curPage}" type="hidden"/>
		<input type="hidden" name="spaceId" value="${spaceId}">
	</form>
	
	<%@ include file="/pages/common/footer.jsp"%>
	<script src="<%=path%>/js/bootstrap.js"></script>
	<script src="<%=path%>/js/collapsePulg.js"></script>
	<script src="<%=path%>/js/common.js"></script>
	<script type="text/javascript">
		$("[rel=tooltip]").tooltip();
		var menuId = '${menuId}';
		var menu2Id = '${menu2Id}';
		var spaceId = '${spaceId}';
		var url = $("#" + menu2Id).attr('url');
		var totalPage = ${pageInfo.totalPage};
		var totalRow = ${pageInfo.totalRow};
		var pageSize = ${pageInfo.pageSize};
		var curPage = ${pageInfo.curPage};
		
		$.jqPaginator('#pagination', {
			//设置分页的总页数
	        totalPages: totalPage,
	        //设置分页的总条目数
	        totalCounts:totalRow,
	        pageSize:pageSize,
	        //最多显示的页码
	        visiblePages: 10,
	        currentPage: curPage,
	        onPageChange: function (num, type) {
	           if("init"==type)
	        	{
	        	 	return false;  
	        	}
	           $('#curPage').val(num);
	        	$('#queryForm').submit();
	        	//document.getElementsByName("operateForm")[0].submit(); 
	        }
	    });
	</script>
</body>
</html>