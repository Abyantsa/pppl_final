<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin, dosen, tendik
if ( userLogin.kode_role > 3 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String file = request.getParameter("file");

if ( file == null ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

%>
      <h1>Import Data Mahasiswa</h1>
	  <div>
		<img src="img/loading.gif" />
	  </div>
	<meta http-equiv="refresh" content="5; url=mahasiswa-import-proses.jsp?file=<%=file%>" />	
<%@ include file="part/footer.jsp" %>