<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.nio.file.Path,java.net.URLEncoder,org.apache.commons.fileupload2.core.FileItem,org.apache.commons.fileupload2.core.DiskFileItemFactory,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletRequestContext, org.apache.commons.csv.*" %>
<%@ include file="../classes/config.jsp" %>
<%@ include file="../classes/db.jsp" %>
<%@ include file="../classes/var-util.jsp" %>
<%@ include file="../classes/prodi.jsp" %>
<%
int pass = 0;
int total = 3;
String msg = "";

Connection con = new Db().createConnection();

try{
	ProdiObject obj = new ProdiObject();
	obj.kode = 1;
	obj.nama = "radit";
	obj.kode_jenjang = 1;
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	Prodi obj = new Prodi(con);
	
	List<ProdiObject> list = obj.list();
	
	if ( list.size() != 1 )  throw new Exception("Jumlah List tidak 1");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	Prodi obj = new Prodi(con);
	
	ProdiObject data = obj.get(1);
	
	if (( data.kode != 1 || ! "Sistem Informasi".equals(data.nama) ) || data.kode_jenjang != 1)  throw new Exception("Data tidak sesuai untuk id 1");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

con.close();

out.println("ResultTest:|"+pass+"|"+total+"|"+msg);
%>