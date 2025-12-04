<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.nio.file.Path,java.net.URLEncoder,org.apache.commons.fileupload2.core.FileItem,org.apache.commons.fileupload2.core.DiskFileItemFactory,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletRequestContext, org.apache.commons.csv.*" %>
<%@ include file="../classes/config.jsp" %>
<%@ include file="../classes/db.jsp" %>
<%@ include file="../classes/var-util.jsp" %>
<%@ include file="../classes/mahasiswa.jsp" %>
<%
int pass = 0;
int total = 4;
String msg = "";

Connection con = new Db().createConnection();

try{
	MahasiswaObject obj = new MahasiswaObject();
	obj.nim = "1";
	obj.nama = "radit";
	obj.kode_jenis_kelamin = 1;
	obj.kode_prodi = 1;
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	MahasiswaImportError obj = new MahasiswaImportError();
	obj.baris = 1;
	obj.nim = "radit";
	obj.message = "radit";
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	Mahasiswa obj = new Mahasiswa(con);
	
	List<MahasiswaObject> list = obj.list();
	
	if ( list.size() != 2 )  throw new Exception("Jumlah List tidak 2");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

try{
	Mahasiswa obj = new Mahasiswa(con);
	
	MahasiswaObject data = obj.get("NIM-MHS-1");
	
	if (
	
		! "NIM-MHS-1".equals(data.nim) 
		|| 
		! "ubah1".equals(data.nama) 
		|| 
		data.kode_jenis_kelamin != 1 || data.kode_prodi != 1
		||
		! "mhs1".equals(data.username)
	)  throw new Exception("Data tidak sesuai untuk nim NIM-MHS-1");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

con.close();

out.println("ResultTest:|"+pass+"|"+total+"|"+msg);
%>