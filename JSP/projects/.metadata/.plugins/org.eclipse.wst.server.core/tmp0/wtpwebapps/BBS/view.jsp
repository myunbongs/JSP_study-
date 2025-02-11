<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BINNY'S BOARD</title>
<style>
	#navbar {
		height: 30px;
		width: 850px;
	}
	#navbar ul li {
		list-style: none; 
		color: white;
		background-color: black;
		float: left;
		line-height: 30px;
		vertical-align: middle; /* 잘 모르겠구만 */
		text-align: center;
	}
	#navbar .link {
		text-decoration: none;
		color: white;
		display: block;
		width: 150px;
		font-size: 15px;
		font-weight: bold;
	}
	
	#navbar .link:hover {
		color: black;
		background-color: white;
	}
	
	#navbar .dropdown {
		position: absolute;
		display: none;
	}
	
	#navbar li:hover ul  {
		display: block;
	}
	
	#navbar ul li li {
		float: none;
		width: 150px;
	}
	
</style>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null ) {
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if ( request.getParameter("bbsID") != null ) {	// 매개변수로 넘어온 bbsID가 존재한다면
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();  
		script.println("<script>");	
		script.println("alert('유효하지 않은 글입니다!')");
		script.println("location.href = 'bbs.jsp'"); 
		script.println("</script>");	
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
BINNY'S BOARD
	<nav id="navbar">
		<ul>
			<li><a class="link" href="main.jsp">메인</a></li>
			<li class="active"><a class="link" href="bbs.jsp">게시판</a></li>
		</ul>
		<%
			if ( userID == null ) {		//login이 되어있지 않은 사람만 접속하기가 뜨도록 
		%>
		
		<ul>
			<li>
			<a class="link" href="#">접속하기</a>
          		<ul class="dropdown">
            		<li><a class="link" href="login.jsp">로그인</a></li>
            		<li><a class="link" href="join.jsp">회원가입</a></li>
          		</ul>
          	</li>
		</ul>
			
		<% 
			} else {	//login이 된 사람이 볼 수 있는 
		%>
			<ul>
			<li>
			<a class="link" href="#">회원관리</a>
          		<ul class="dropdown">
            		<li><a class="link" href="logoutAction.jsp">로그아웃</a></li>
          		</ul>
          	</li>
		</ul>
		<% 
			}
		%>
	</nav>
	
	<div class=container>
		<div class="row">
				<table style="text-align: center; border: 1px slid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글제목</td>
							<td colspan="2"><%=bbs.getBbsTitle()%></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID()%></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" +  bbs.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>></td>
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp">목록</a>
				<%
					if (userID != null && userID.equals(bbs.getUserID())) {
				%>
					<a href="update.jsp?bbsID=<%=bbsID%>">수정</a>
					<a onclick="return confirm('정말로 삭제할 겨?')" href="deleteAction.jsp?bbsID=<%=bbsID%>">삭제</a>
				<% 		
					}
				%>

		</div>
	</div>
	
</body>
</html>