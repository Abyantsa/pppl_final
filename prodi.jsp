<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin
if ( userLogin.kode_role != 1 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String message = null;

ProdiObject obj = new ProdiObject();
JenjangObject jObj = new JenjangObject();

List<JenjangObject> daftarJenjang = jenjang.list();

String actForm = "insert";

String act = request.getParameter("act");

if ( "edit".equals(act) ) {
	actForm = "update";
	
	int kode = varUtil.parseInt(request.getParameter("kode"));
	
	obj = prodi.get(kode);
	jObj = jenjang.get(obj.kode_jenjang);

}

else if("del".equals(act)){
	actForm = "delete";
	
	int kode = varUtil.parseInt(request.getParameter("kode"));
	
	obj = prodi.get(kode);
	jObj = jenjang.get(obj.kode_jenjang);
}

else if ( "update".equals(act) ) {
	try{
		
		ProdiObject ro = new ProdiObject();
		ro.kode = varUtil.parseInt(request.getParameter("kode"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		ro.kode_jenjang = varUtil.parseInt(request.getParameter("kode_jenjang"));
		
		prodi.update(ro);
		
		response.sendRedirect("prodi.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if( "insert".equals(act) ){
	try{
		
		ProdiObject ro = new ProdiObject();
		ro.kode = varUtil.parseInt(request.getParameter("kode"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		ro.kode_jenjang = varUtil.parseInt(request.getParameter("kode_jenjang"));
		
		prodi.insert(ro);
		
		response.sendRedirect("prodi.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if("delete".equals(act)){
	try{

		int kode = varUtil.parseInt(request.getParameter("kode"));
	
		prodi.delete(kode);
		
		response.sendRedirect("prodi.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

%>
      <h1>Manajemen Prodi</h1>
      <% if(message != null){ %>
	    <div class="alert">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Warning!</strong> <%=message%>
		</div>
	  <% } %>
	  <form method="post" action="prodi.jsp">
		<input type="hidden" name="act" value="<%=actForm%>" />
		<fieldset>
			<legend><%=actForm.toUpperCase()%> Prodi</legend>
			<label>Kode</label>
			<% if ( "update".equals(actForm) || "delete".equals(actForm) ) {%>
			<input type="hidden" name="kode" value="<%=varUtil.show(obj.kode)%>" />
			<label><%=varUtil.show(obj.kode)%></label>
			<% }else{ %>
			<input type="text" name="kode" value="<%=varUtil.show(obj.kode)%>" />
			<% } %>
			<label>Nama</label>
			<% if("delete".equals(actForm)){ %>
			<label><%=varUtil.show(obj.nama)%></label>
			<% } else { %>
			<input type="text" name="nama" value="<%=varUtil.show(obj.nama)%>" />
			<% } %>
			<label>Jenjang</label>
			<% if("delete".equals(actForm)){ %>
			<input type="hidden" name="kode_jenjang" value="<%=obj.kode_jenjang%>" />
			<label><%=varUtil.show(jObj.nama)%></label>
			<% }else{ %>
			<select name="kode_jenjang">
			<% for(int i=0;i<daftarJenjang.size();i++){ 
				JenjangObject jo = daftarJenjang.get(i);
				String selected = "";
				
				if ( jo.kode == obj.kode_jenjang ) selected="selected='selected'";
			%>
				<option <%=selected%> value="<%=jo.kode%>"><%=jo.nama%></option>
			<% } %>
			</select>
			<% } %>
			<label></label>
			<input type="submit" value="<%=actForm%>" class="btn btn-primary" />
		</fieldset>
	  </form>
	  <div>
	  <a href="prodi.jsp">Tambah Prodi</a>
	  </div>
	  <table class="table">
		<caption>Daftar Prodi</caption>
		<thead>
			<tr>
				<th>Kode</th>
				<th>Nama</th>
				<th>Jenjang</th>
				<th></th>
			</tr>
<%
List<ProdiObject> daftar = prodi.list();
for(int i=0; i<daftar.size(); i++){
	ProdiObject ro = daftar.get(i);
	JenjangObject roo = jenjang.get(ro.kode_jenjang);
%>
			<tr>
				<td><%=varUtil.show(ro.kode)%></td>
				<td><%=varUtil.show(ro.nama)%></td>
				<td><%=varUtil.show(roo.nama)%></td>
				<td><a href="?act=edit&kode=<%=ro.kode%>">edit</a> | <a href="?act=del&kode=<%=ro.kode%>">hapus</a></td>
			</tr>
<%
}
%>
		</thead>
		<tbody>
		</tbody>
	  </table>

<%@ include file="part/footer.jsp" %>