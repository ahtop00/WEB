<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content ="width=device-width, initial-scale=1">
	<link rel ="stylesheet" href="css/bootstrap.css">
	<link rel ="stylesheet" href="css/custom.css">
	<title>JSP Board Login</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src= "js/bootstrap.js"></script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있는 상태입니다.");
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
			<%
				if(userID == null) {
			%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="./userLogin">
					<h3 style= "text-align: center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
			</div>
		</div>
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
  <div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
      aria-hidden="true">
      <div class="vertical-alignment-helper">
      <div class="modal-dialog vertical-align-center">
          <div
              class="modal-content
              <%if (messageType.equals("오류 메시지"))
                  out.println("panel-warning");
              else
                  out.println("panel-success");%>">
              <div class="modal-header panel-heading">
                  <button type="button" class="close" data-dismiss="modal">
                      <span aria-hidden="true">×</span> <span class="sr-only">Close</span>
                  </button>
                  <h4 class="modal-title">
                      <%=messageType%>
                  </h4>
              </div>
              <div class="modal-body">
                  <%=messageContent%>
              </div>
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
  <div class="modal fade" id="checkModal" tabindex="-1" role="dialog"
      aria-hidden="true">
      <div class="vertical-alignment-helper">
      	<div class="modal-dialog vertical-align-center">
          <div id="checkType" class="modal-content panel-info">
              <div class="modal-header panel-heading">
                  <button type="button" class="close" data-dismiss="modal">
                      <span aria-hidden="true">×</span> <span class="sr-only">Close</span>
                  </button>
                  <h4 class="modal-title">Check Message</h4>
              </div>
              <div class="modal-body" id="checkMessage"></div>
          </div>
      	</div>
      </div>
  </div>
</body>
</html>