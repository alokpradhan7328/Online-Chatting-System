<%@ page import="java.sql.*" %>
<%
    Connection con=null;
    Statement st=null;
    ResultSet rs=null;
    
    String PHONENO=(String)session.getAttribute("phoneno");
    String PASSWORD = request.getParameter("password");
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat_system","root","12345");
        
        st=con.createStatement();
        String query="update userreg set password='"+PASSWORD+"' where phoneno='"+PHONENO+"' ";
        st.execute(query);

        String message = "Sucessfully changed your password";
        RequestDispatcher rd = request.getRequestDispatcher("updatepassword.jsp");
        request.setAttribute("msg",message);
        rd.forward(request, response);
        
        st.close();
        con.close();
    }
    catch(Exception exp){
        out.print("error in dsn :  "+exp.getMessage());
    }
    
%>