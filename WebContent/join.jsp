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
<title>JSP BOARD Register</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
	 
	function registerCheckFunction() {
	    var userID = $('#userID').val();
	        $.ajax({
	            type : 'POST',
	            url : './UserRegisterCheckServlet',
	            data : {
	                userID : userID
	            },
	            success : function(result) {
	                if (result == 1) {
	                    $('#checkMessage').html("사용 가능한 아이디입니다.");
	                    $('#checkType')
	                            .attr('class', 'modal-content panel-success');
	                } else {
	                    $('#checkMessage').html("사용 불가능한 아이디입니다.");
	                    $('#checkType')
	                            .attr('class', 'modal-content panel-warning');
	                }
	                $('#checkModal').modal("show");
	            }
	        })
	    }
	    function passwordCheckFunction(){
	        var userPassword1 = $('#userPassword1').val();
	        var userPassword2 = $('#userPassword2').val();
	         
	        if(userPassword1!=userPassword2){
	            $('#passwordCheckMessage').html("비밀번호가 일치하지 않습니다");
	        }
	        else{
	            $('#passwordCheckMessage').html("");
	        }
	    }
	</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			session.setAttribute("messageType", "오류 메세지");
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
				<li class="active"><a href="main.jsp">메인</a></li>
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
      <form method="post" action="./userRegister">
          <table class="table table-bordered table-hover"
              style="text-align: center; border: 1px solid #dddddd;">
              <thead>
                  <tr>
                      <th colspan="3"><h4>회원 등록</h4></th>
                  </tr>
              </thead>
              <tbody>
                  <tr>
                      <td style="width: 110px;"><h5>ID</h5></td>
                      <td><input class="form-control" type="text" id="userID"
                          name="userID" maxlength="20"></td>
                      <td style="width: 110px;"><button class="btn btn-primary"
                              onClick="registerCheckFunction();" type="button">ID
                              CHECK</button></td>
                  </tr>
                  <tr>
                      <td style="width: 110px;"><h5>Password</h5></td>
                      <td colspan="2"><input class="form-control" type="password"
                          onkeyup="passwordCheckFunction();" id="userPassword1"
                          name="userPassword1" maxlength="20"></td>
                  </tr>
                  <tr>
                      <td style="width: 110px;"><h5>Password Check</h5></td>
                      <td colspan="2"><input class="form-control" type="password"
                          onkeyup="passwordCheckFunction();" id="userPassword2"
                          name="userPassword2" maxlength="20"></td>
                  </tr>
                  <tr>
                      <td style="width: 110px;"><h5>Name</h5></td>
                      <td colspan="2"><input class="form-control" type="text"
                          id="userName" name="userName" maxlength="20"></td>
                  </tr>
                  <tr>
                      <td style="width: 110px;"><h5>Email</h5></td>
                      <td colspan="2"><input class="form-control" type="email"
                          id="userEmail" name="userEmail" maxlength="20"></td>
                  </tr>
                  <tr>
                      <td colspan="3" style="text-align: left"><input
                          class="btn btn-primary pull-right" type="submit" value="회원가입">
                          <h5 style="color: red;" id="passwordCheckMessage"></h5></td>
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