<%@ page import="java.sql.*" %>
<%
    Connection con=null;
    Statement st=null;
    ResultSet rs=null;
    
    String PHONENO_EMAILID = request.getParameter("phone_email");
    String QUESTION = request.getParameter("secure_question");
    String ANSWER = request.getParameter("answer");
    
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat_system","root","12345");
    }
    catch(Exception exp){
        out.print("error in dsn :  "+exp.getMessage());
    }
    try{
        st=con.createStatement();
        String query="select * from userreg where phoneno='"+PHONENO_EMAILID+"' or emailid='"+PHONENO_EMAILID+"' and secure_question='"+QUESTION+"' and answer='"+ANSWER+"' ";
        rs=st.executeQuery(query);
        if(rs.next()){
            String s1=rs.getString("password");                           
            out.println("Your Password is '"+s1+"' ");
            
            String message = "Check below ?";
            RequestDispatcher rd = request.getRequestDispatcher("recovery.jsp");
            request.setAttribute("msg",message);
            request.setAttribute("phone_email",PHONENO_EMAILID);
            request.setAttribute("secure_question",QUESTION);
            request.setAttribute("answer",ANSWER);
            rd.forward(request, response);
        }
        else{
            String message1 = "Invalid Data";
            RequestDispatcher rd = request.getRequestDispatcher("recovery.jsp");
            request.setAttribute("msg1",message1);
            rd.forward(request, response);
        }
    }
    catch(Exception exp)
    {
        out.print("error in checking"+exp.getMessage());
    }
%>