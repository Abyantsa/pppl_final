<%@ include file="cek-session.jsp" %>
<%@ include file="../classes/load.jsp" %>
<%
String username = (String) session.getAttribute("username");
Db db = new Db();

Connection con = db.createConnection();

VarUtil varUtil = new VarUtil();
JenisKelamin jenisKelamin = new JenisKelamin(con);
Jenjang jenjang = new Jenjang(con);
Role role = new Role(con);
User user = new User(con);
Prodi prodi = new Prodi(con);
Mahasiswa mahasiswa = new Mahasiswa(con);

UserObject userLogin = user.get(username);
RoleObject roleLogin = role.get(userLogin.kode_role);

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>latihan1-jsp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="home.jsp">latihan1-jsp</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li><a href="home.jsp">Home</a></li>
              <li><a href="role.jsp">Role</a></li>
              <li><a href="jenis-kelamin.jsp">Jenis Kelamin</a></li>
              <li><a href="jenjang.jsp">Jenjang</a></li>
              <li><a href="prodi.jsp">Prodi</a></li>
              <li><a href="user.jsp">User</a></li>
              <li><a href="mahasiswa.jsp">Mahasiswa</a></li>
              <li><a href="logout.jsp">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
	
	<br /> <br />
	
	<div class="container">