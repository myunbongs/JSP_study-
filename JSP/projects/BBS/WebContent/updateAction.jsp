<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
		String userID = null;
		if ( session.getAttribute("userID") != null ) {
			userID = (String) session.getAttribute("userID"); // userID라는 이름으로 세션이 존재하는 회원들은 userID에 해당 세션값 넣기
		}
		if ( userID == null ) {	// 세션이 없다면 
			PrintWriter script = response.getWriter();  
			script.println("<script>");	
			script.println("alert('로그인을 하세요!')");
			script.println("location.href = 'login.jsp'"); 
			script.println("</script>");	
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
		
		if (! userID.equals(bbs.getUserID()) ) {
			PrintWriter script = response.getWriter();  
			script.println("<script>");	
			script.println("alert('권한이 없습니다..')");
			script.println("location.href = 'bbs.jsp'"); 
			script.println("</script>");	
			
		} else {	// 세션이 있다면 
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null ||  request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
					PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다!')");
					script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
					script.println("</script>");
			} else {
					BbsDAO bbsDAO = new BbsDAO(); // BbsDAO 인스턴스 생성
					int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent")); // 입력된 값 넣어주기
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글수정에 실패하였습니다.')"); 
						script.println("history.back()"); 
						script.println("</script>");	
					} else {	// result == 0 이외의 ~~ = 글쓰기 성공! 
						PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
						script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
						script.println("location.href = 'bbs.jsp'");	// 회원가입 성공시 메인 페이지로 이동! 
						script.println("</script>");	
					}
				}
		}
	%>
</body>
</html>