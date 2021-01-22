<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content ="width=device-width, initial-scale=1">
	<link rel ="stylesheet" href="css/bootstrap.css">
	<title>게시판</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src= "js/bootstrap.js"></script>
	<link rel ="stylesheet" href="css/custom.css">
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) { 
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있지 않습니다.");
			response.sendRedirect("main.jsp");
			return;
		}
		UserDTO user = new UserDAO().getUser(userID);	
		
		String boardID = null;
		if (request.getParameter("boardID") !=  null) {
			boardID = (String) request.getParameter("boardID");
		}
		if(boardID == null || boardID.equals("")) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "게시물을 선택해주세요.");
			response.sendRedirect("main.jsp");
			return;
		}
	%>
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type="button" class="navbar-toggle collapsesd"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">JSP Board</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="boardView.jsp">게시판</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<form method="post" action="./boardWrite" enctype="multipart/form-data">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>게시물 답글 작성</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td><h5><%= user.getUserID() %></h5>
						<input type="hidden" name="userID" value="<%=user.getUserID() %>">
						<input type="hidden" name="boardID" value="<%=boardID %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>글 제목</h5></td>
						<td><input class="form-control" type="text" maxlength="50" name="boardTitle" placeholder="글 제목을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>글 내용</h5></td>
						<td><textarea class="form-control" rows="10" name="boardContent" maxlength="2048" placeholder="글 내용을 입력하세요."></textarea></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>파일 업로드</h5></td>
						<td colspan="2">
							<input type="file" name="boardFile" class="glyphicon glyphicon-picture">
						</td>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="3"><h5 style="color: red;"></h5><input class="btn btn-primary pull-right" type="submit" value="등록"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-content <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success"); %>">
				<div class="modal-header panel-heading">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">x</span>
						<span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">
						<%= messageType %>
					</h4>
				</div>
				<div class="modal-body">
					<%= messageContent %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dissmiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div id="checkType" class="modal-content panel-info">
				<div class="modal-header panel-heading">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">x</span>
						<span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">
						확인 메세지
					</h4>
				</div>
				<div id="checkMessage" class="modal-body">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dissmiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>