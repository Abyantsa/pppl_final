<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="part/cek-session.jsp" %>
<%@ include file="classes/load.jsp" %>
<%
String fileName = "data_mahasiswa.csv";
String delimiter = ",";

Db db = new Db();
Connection con = db.createConnection();

response.setContentType("application/force-download");
response.setContentLength(-1);
response.setHeader("Content-Transfer-Encoding", "binary");
response.setHeader("Content-Disposition","attachment; filename=\""+fileName+"\"");

MahasiswaObject mo = new MahasiswaObject();

String[] header = mo.header();

for(int i=0;i<header.length;i++){
	out.print(header[i]);
	if ( i != header.length -1 ) out.print(delimiter);
}
out.println();

Mahasiswa m = new Mahasiswa(con);
List<MahasiswaObject> daftar = m.list();

for(int i=0;i<daftar.size();i++){
	MahasiswaObject mObj = daftar.get(i);
	out.print(mObj.nim+delimiter+mObj.nama+delimiter+mObj.kode_jenis_kelamin+delimiter+mObj.kode_prodi+delimiter+mObj.username);
	out.println();
}

con.close();
%>

