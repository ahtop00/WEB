<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content ="width=device-width, initial-scale=1">
	<link rel ="stylesheet" href="css/bootstrap.css">
	<link rel ="stylesheet" href="css/custom.css">
<title>게시판</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			session.setAttribute("messageType", "오류 메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있지 않습니다.");
			response.sendRedirect("main.jsp");
			return;
		}
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
		
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO board = boardDAO.getBoard(boardID);
		boardDAO.hit(boardID);
			
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
				<li class="active"><a href="boardView.jsp">게시판</a></li>
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
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<table class="table table-bordered table-hover" style="text-align: left; border: 1px solid #dddddd">
			<thead>
			<tr>
				<th colspan="7"><h4>게시물 보기</h4></th>
			</tr>
			<tr>
				<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>제목</h5></td>
				<td colspan="5"><h5><%= board.getBoardTitle() %></h5></td>
			</tr>
			<tr>
				<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>작성날짜</h5></td>
				<td colspan="3"><h5><%= board.getBoardDate() %></h5></td>
				<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>조회수</h5></td>
				<td colspan="1"><h5><%= board.getBoardHit() %></h5></td>
			</tr>
			<tr>
				<td style="vertical-align: middle; min-height: 150px; background-color: #fafafa; color: #000000; width: 80px;"><h5>글 내용</h5></td>
				<td colspan="5" style="text-align: left;"><h5><%= board.getBoardContent() %></h5></td>
			</tr>
			<tr>
				<td style="background-color: #fafafa; color: #000000; width: 80px;"><h5>첨부파일</h5></td>
				<td colspan="5"><h5><a href="boardDownload.jsp?boardID=<%= board.getBoardID() %>"><%= board.getBoardFile()%></a></h5></td>
			</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="8" style="text-align: right;">
						<a href="boardView.jsp" class="btn btn-primary">목록</a>
						<a href="boardReply.jsp?boardID=<%= board.getBoardID() %>" class="btn btn-primary">답글</a>
						<%
							if(userID.equals(board.getUserID())) {
						%>
							<a href="boardUpdate.jsp?boardID=<%= board.getBoardID() %>" class="btn btn-primary">수정</a>
							<a href="boardDelete?boardID=<%= board.getBoardID() %>" class="btn btn-primary" onclick="return confirm('정말로 삭제하시겠습니까?')">삭제</a>
						<%
							}
						%>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src= "js/bootstrap.js"></script>
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