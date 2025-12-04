<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*, java.util.*, java.io.*, java.nio.file.Path,java.net.URLEncoder,org.apache.commons.fileupload2.core.FileItem,org.apache.commons.fileupload2.core.DiskFileItemFactory,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletRequestContext, org.apache.commons.csv.*" %>
<%@ include file="../classes/config.jsp" %>
<%@ include file="test-util.jsp" %>
<%@ include file="../classes/db.jsp" %>
<%@ include file="../classes/var-util.jsp" %>
<%@ include file="../classes/jenis-kelamin.jsp" %>
<%
int pass = 0;
int total = 8;
String msg = "";
String sql = "";
PreparedStatement ps = null;
ResultSet rs = null;

//Cek Objek
try{
	JenisKelaminObject obj = new JenisKelaminObject();
	obj.kode = 1;
	obj.nama = "radit";
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}

// cek method list 
TestUtil.resetDb();

Connection con = new Db().createConnection();

String sqlJml = "SELECT count(*) AS jml FROM jenis_kelamin";
PreparedStatement psJml = con.prepareStatement(sqlJml);
ResultSet rsJml = psJml.executeQuery();
rsJml.next();

try{
	JenisKelamin obj = new JenisKelamin(con);
	
	List<JenisKelaminObject> list = obj.list();
	
	if ( list.size() != rsJml.getInt("jml") )  throw new Exception("Jumlah List tidak 2");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}
con.close();


// cek method get
TestUtil.resetDb();
con = new Db().createConnection();
String sqlGet1 = "SELECT * FROM jenis_kelamin WHERE kode = 1";
PreparedStatement psGet1 = con.prepareStatement(sqlGet1);
ResultSet rsGet1 = psGet1.executeQuery();
if (rsGet1.next()){

	try{
		JenisKelamin obj = new JenisKelamin(con);
		
		JenisKelaminObject data = obj.get(1);
		
		if ( data.kode != 1 || ! rsGet1.getString("nama").equals(data.nama) )  throw new Exception("Data tidak sesuai untuk id 1");
		
		pass++;
	}catch(Exception e){
		msg += e.toString() + ";";
	}
	
}
con.close();

// cek method insert normal
TestUtil.resetDb();
con = new Db().createConnection();
try{
	
	JenisKelaminObject jko = new JenisKelaminObject();
	jko.kode = 3;
	jko.nama = "coba2";
	
	JenisKelamin obj = new JenisKelamin(con);
	
	obj.insert(jko);
	

	List<JenisKelaminObject> daftar = obj.list();
	
	if ( daftar.size() != 3 ) throw new Exception("Gagal Proses Insert");
	
	pass++;
}catch(Exception e){
	msg += e.toString() + ";";
}
con.close();

// cek method insert gagal
TestUtil.resetDb();
con = new Db().createConnection();
try{
	
	JenisKelaminObject jko = new JenisKelaminObject();
	jko.kode = 2;
	jko.nama = "coba2";
	
	JenisKelamin obj = new JenisKelamin(con);
	
	obj.insert(jko);
	
	msg +="gagal method insert,seharusnya gagal malah berhasil;";
	
	
}catch(Exception e){
	
	pass++;
	
}
con.close();

// cek method update normal
TestUtil.resetDb();
con = new Db().createConnection();
try{
	
	JenisKelaminObject jko = new JenisKelaminObject();
	jko.kode = 2;
	jko.nama = "coba2";
	
	JenisKelamin obj = new JenisKelamin(con);
	
	obj.update(jko);
	
	sql = "SELECT * FROM jenis_kelamin WHERE kode = ?";
	ps = con.prepareStatement(sql);
	ps.setInt(1,jko.kode);
	rs = ps.executeQuery();
	
	if(rs.next()){
		if ( !rs.getString("nama").equals(jko.nama) ) throw new Exception("cek method update normal gagal");
	}else{
		throw new Exception("cek method update normal gagal");
	}
	
	pass++;
	
}catch(Exception e){
	msg += e.toString() + ";";
	
	
}
con.close();

// cek method update gagal
TestUtil.resetDb();
con = new Db().createConnection();
try{
	
	JenisKelaminObject jko = new JenisKelaminObject();
	jko.kode = 20;
	jko.nama = "coba2";
	
	JenisKelamin obj = new JenisKelamin(con);
	
	obj.update(jko);
	
	sql = "SELECT * FROM jenis_kelamin WHERE kode = ?";
	ps = con.prepareStatement(sql);
	ps.setInt(1,jko.kode);
	rs = ps.executeQuery();
	
	if(rs.next()){
		if ( !rs.getString("nama").equals(jko.nama) ) throw new Exception("ini berarti benar");
	}else{
		throw new Exception("ini berarti benar");
	}
	
	msg +="gagal method update,seharusnya gagal malah berhasil;";
	
	
}catch(Exception e){
	
	pass++;
	
}
con.close();

// cek method delete 
TestUtil.resetDb();
con = new Db().createConnection();
try{
	
		
	JenisKelamin obj = new JenisKelamin(con);
	
	obj.delete(1);
	
	sql = "SELECT * FROM jenis_kelamin WHERE kode = ?";
	ps = con.prepareStatement(sql);
	ps.setInt(1,1);
	rs = ps.executeQuery();
	
	if(!rs.next()){
		throw new Exception("ini berarti benar");
	}
	
	msg +="gagal method delete,seharusnya gagal malah berhasil;";
	
	
}catch(Exception e){
	
	pass++;
	
}
con.close();

// reset db kembali seperti semula

TestUtil.resetDb();

out.println("ResultTest:|"+pass+"|"+total+"|"+msg);
%>