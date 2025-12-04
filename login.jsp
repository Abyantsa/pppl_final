<%@ include file="classes/load.jsp" %>
<%
String act = request.getParameter("act");
boolean isLogin = false;
String message = null;

if ( "login".equals(act) ) {
	
	Db db = new Db();
	Connection con = db.createConnection();
	User user = new User(con);
	
	UserLogin ul = new UserLogin();
	
	ul.username = request.getParameter("username");
	ul.password = request.getParameter("password");
	
	message = "Tidak Dapat Login, Harap Cek Username Dan Password";
	
	isLogin = user.login(ul);
	
	con.close();
	
	if ( isLogin ){ 
	
		session.setAttribute("username",ul.username);
	
		message = null;
		response.sendRedirect("home.jsp");
		return;
	}
	
}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Sign in</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>
    
  </head>

  <body>

    <div class="container">
	  
      <form class="form-signin" method="POST" action="login.jsp">
	  
		<% if(message != null){ %>
	  
			<div class="alert">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong>Warning!</strong> <%=message%>
			</div>
		  
		<% } %>
	  
		<input type="hidden" name="act" value="login" />
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="text" name="username" class="input-block-level" placeholder="Username">
        <input type="password" name="password" class="input-block-level" placeholder="Password">
        <button class="btn btn-large btn-primary" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>

  </body>
</html>
