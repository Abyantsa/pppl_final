<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin, dosen, tendik
if ( userLogin.kode_role > 3 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String message = null;

MahasiswaObject obj = new MahasiswaObject();
UserObject uObj = new UserObject();
JenisKelaminObject jkObj = new JenisKelaminObject();
ProdiObject pObj = new ProdiObject();

List<JenisKelaminObject> daftarJenisKelamin = jenisKelamin.list();
// user mahasiswa saja
List<UserObject> daftarUser = user.listByKodeRole(4);
List<ProdiObject> daftarProdi = prodi.list(); 

String actForm = "insert";

String act = request.getParameter("act");

if ( "edit".equals(act) ) {
	actForm = "update";
	
	String nim = varUtil.parseString(request.getParameter("nim"));
	
	obj = mahasiswa.get(nim);
	uObj = user.get(obj.username);
	jkObj = jenisKelamin.get(obj.kode_jenis_kelamin);
	pObj = prodi.get(obj.kode_prodi);

}

else if("csv".equals(act)){
	actForm = "import";
}

else if("del".equals(act)){
	actForm = "delete";
	
	String nim = varUtil.parseString(request.getParameter("nim"));
	
	obj = mahasiswa.get(nim);
	uObj = user.get(obj.username);
	jkObj = jenisKelamin.get(obj.kode_jenis_kelamin);
	pObj = prodi.get(obj.kode_prodi);
	
}

else if ( "update".equals(act) ) {
	try{
		
		MahasiswaObject ro = new MahasiswaObject();
		ro.nim = varUtil.parseString(request.getParameter("nim"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		ro.kode_jenis_kelamin = varUtil.parseInt(request.getParameter("kode_jenis_kelamin"));
		ro.kode_prodi = varUtil.parseInt(request.getParameter("kode_prodi"));
		ro.username = varUtil.parseString(request.getParameter("username"));
		
		mahasiswa.update(ro);
		
		response.sendRedirect("mahasiswa.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}


else if( "insert".equals(act) ){
	try{
		
		MahasiswaObject ro = new MahasiswaObject();
		ro.nim = varUtil.parseString(request.getParameter("nim"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		ro.kode_jenis_kelamin = varUtil.parseInt(request.getParameter("kode_jenis_kelamin"));
		ro.kode_prodi = varUtil.parseInt(request.getParameter("kode_prodi"));
		ro.username = varUtil.parseString(request.getParameter("username"));
		
		mahasiswa.insert(ro);
		
		response.sendRedirect("mahasiswa.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if("delete".equals(act)){
	try{

		String nim = varUtil.parseString(request.getParameter("nim"));
		
		mahasiswa.delete(nim);
		
		response.sendRedirect("mahasiswa.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

%>
      <h1>Manajemen Mahasiswa</h1>
	  <div>
		  <a href="mahasiswa.jsp">Tambah Mahasiswa</a> |
		  <a href="mahasiswa-export.jsp" target="_blank">Export Data Mahasiswa</a> |
		  <a href="mahasiswa-import-dialog.jsp">Import Data Mahasiswa</a> |
	  </div>
      <% if(message != null){ %>
	    <div class="alert">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Warning!</strong> <%=message%>
		</div>
	  <% } %>
	  <form method="post" action="mahasiswa.jsp">
		<input type="hidden" name="act" value="<%=actForm%>" />
		<fieldset>
			<legend><%=actForm.toUpperCase()%> User</legend>
			
			<label>Nim</label>
			<% if ( "update".equals(actForm) || "delete".equals(actForm) ) {%>
			<input type="hidden" name="nim" value="<%=varUtil.show(obj.nim)%>" />
			<label><%=varUtil.show(obj.nim)%></label>
			<% }else{ %>
			<input type="text" name="nim" value="<%=varUtil.show(obj.nim)%>" />
			<% } %>
			
			<label>Nama</label>
			<% if ( "delete".equals(actForm) ) {%>
			<input type="hidden" name="nama" value="<%=varUtil.show(obj.nama)%>" />
			<label><%=varUtil.show(obj.nama)%></label>
			<% }else{ %>
			<input type="text" name="nama" value="<%=varUtil.show(obj.nama)%>" />
			<% } %>
			
			<label>Jenis Kelamin</label>
			<% if ( "delete".equals(actForm) ) {%>
			<input type="hidden" name="kode_jenis_kelamin" value="<%=varUtil.show(obj.kode_jenis_kelamin)%>" />
			<label><%=varUtil.show(jkObj.nama)%></label>
			<% }else{ %>
			<select name="kode_jenis_kelamin">
				<% for(int i=0;i<daftarJenisKelamin.size();i++){ 
					JenisKelaminObject jkO = daftarJenisKelamin.get(i);
					String selected = "";
					
					if (obj.kode_jenis_kelamin == jkO.kode) selected = "selected='selected'";
				%>
				<option value="<%=varUtil.show(jkO.kode)%>"><%=varUtil.show(jkO.nama)%></option>
				<% } %>
			</select>
			<% } %>
			
			<label>Jenis Prodi</label>
			<% if ( "delete".equals(actForm) ) {%>
			<input type="hidden" name="kode_prodi" value="<%=varUtil.show(obj.kode_prodi)%>" />
			<label><%=varUtil.show(pObj.nama)%></label>
			<% }else{ %>
			<select name="kode_prodi">
				<% for(int i=0;i<daftarProdi.size();i++){ 
					ProdiObject pO = daftarProdi.get(i);
					String selected = "";
					
					if (obj.kode_prodi == pO.kode) selected = "selected='selected'";
				%>
				<option value="<%=varUtil.show(pO.kode)%>"><%=varUtil.show(pO.nama)%></option>
				<% } %>
			</select>
			<% } %>
			
			<label>Username</label>
			<% if ( "delete".equals(actForm) ) {%>
			<input type="hidden" name="username" value="<%=varUtil.show(obj.username)%>" />
			<label><%=varUtil.show(uObj.username)%></label>
			<% }else{ %>
			<select name="username">
				<% for(int i=0;i<daftarUser.size();i++){ 
					UserObject uO = daftarUser.get(i);
					String selected = "";
					
					if (uO.username.equals(obj.username)) selected = "selected='selected'";
				%>
				<option value="<%=varUtil.show(uO.username)%>"><%=varUtil.show(uO.username)%></option>
				<% } %>
			</select>
			<% } %>
			
			<label></label>
			<input type="submit" value="<%=actForm%>" class="btn btn-primary" />
		</fieldset>
	  </form>
	  
	  <table class="table">
		<caption>Daftar Mahasiswa</caption>
		<thead>
			<tr>
				<th>Nim</th>
				<th>Nama</th>
				<th>Jenis Kelamin</th>
				<th>Prodi</th>
				<th>Username</th>
				<th></th>
			</tr>
<%
List<MahasiswaObject> daftar = mahasiswa.list();
for(int i=0; i<daftar.size(); i++){
	MahasiswaObject ro = daftar.get(i);
	UserObject uO = user.get(ro.username);
	JenisKelaminObject jkO = jenisKelamin.get(ro.kode_jenis_kelamin);
	ProdiObject pO = prodi.get(ro.kode_prodi);
%>
			<tr>
				<td><%=varUtil.show(ro.nim)%></td>
				<td><%=varUtil.show(ro.nama)%></td>
				<td><%=varUtil.show(jkO.nama)%></td>
				<td><%=varUtil.show(pO.nama)%></td>
				<td><%=varUtil.show(uO.username)%></td>
				<td><a href="?act=edit&nim=<%=ro.nim%>">edit</a> | <a href="?act=del&nim=<%=ro.nim%>">hapus</a></td>
			</tr>
<%
}
%>
		</thead>
		<tbody>
		</tbody>
	  </table>

<%@ include file="part/footer.jsp" %>