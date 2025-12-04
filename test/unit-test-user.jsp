<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.nio.file.Path,java.net.URLEncoder,org.apache.commons.fileupload2.core.FileItem,org.apache.commons.fileupload2.core.DiskFileItemFactory,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletRequestContext, org.apache.commons.csv.*" %>
<%@ include file="../classes/config.jsp" %>
<%@ include file="../classes/db.jsp" %>
<%@ include file="../classes/var-util.jsp" %>
<%@ include file="../classes/user.jsp" %>
<%
int pass = 0;
int total = 4;
String msg = "";

Connection con = new Db().createConnection();

try{
	UserObject obj = new UserObject();
	obj.username = "1";
	obj.password = "radit";
	obj.kode_role = 1;
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	UserLogin obj = new UserLogin();
	obj.username = "1";
	obj.password = "radit";
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	User obj = new User(con);
	
	List<UserObject> list = obj.list();
	
	if ( list.size() != 3 )  throw new Exception("Jumlah List tidak 3");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	User obj = new User(con);
	
	UserObject data = obj.get("radit");
	
	if (! "radit".equals(data.username))  throw new Exception("Data tidak sesuai untuk username radit");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

con.close();

out.println("ResultTest:|"+pass+"|"+total+"|"+msg);
%>