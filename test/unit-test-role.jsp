<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.nio.file.Path,java.net.URLEncoder,org.apache.commons.fileupload2.core.FileItem,org.apache.commons.fileupload2.core.DiskFileItemFactory,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletRequestContext, org.apache.commons.csv.*" %>
<%@ include file="../classes/config.jsp" %>
<%@ include file="../classes/db.jsp" %>
<%@ include file="../classes/var-util.jsp" %>
<%@ include file="../classes/role.jsp" %>
<%
int pass = 0;
int total = 3;
String msg = "";

Connection con = new Db().createConnection();

try{
	RoleObject obj = new RoleObject();
	obj.kode = 1;
	obj.nama = "radit";
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	Role obj = new Role(con);
	
	List<RoleObject> list = obj.list();
	
	if ( list.size() != 4 )  throw new Exception("Jumlah List tidak 4");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	Role obj = new Role(con);
	
	RoleObject data = obj.get(1);
	
	if ( data.kode != 1 || ! "ADMIN".equals(data.nama) )  throw new Exception("Data tidak sesuai untuk id 1");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

con.close();

out.println("ResultTest:|"+pass+"|"+total+"|"+msg);
%>