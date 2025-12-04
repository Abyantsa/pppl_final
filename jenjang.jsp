<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin
if ( userLogin.kode_role != 1 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String message = null;

JenjangObject obj = new JenjangObject();

String actForm = "insert";

String act = request.getParameter("act");

if ( "edit".equals(act) ) {
	actForm = "update";
	
	int kode = varUtil.parseInt(request.getParameter("kode"));
	
	obj = jenjang.get(kode);
}

else if("del".equals(act)){
	actForm = "delete";
	
	int kode = varUtil.parseInt(request.getParameter("kode"));
	
	obj = jenjang.get(kode);
}

else if ( "update".equals(act) ) {
	try{
		
		JenjangObject ro = new JenjangObject();
		ro.kode = varUtil.parseInt(request.getParameter("kode"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		
		jenjang.update(ro);
		
		response.sendRedirect("jenjang.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if( "insert".equals(act) ){
	try{
		
		JenjangObject ro = new JenjangObject();
		ro.kode = varUtil.parseInt(request.getParameter("kode"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		
		jenjang.insert(ro);
		
		response.sendRedirect("jenjang.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if("delete".equals(act)){
	try{

		int kode = varUtil.parseInt(request.getParameter("kode"));
	
		jenjang.delete(kode);
		
		response.sendRedirect("jenjang.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

%>
      <h1>Manajemen Jenjang</h1>
      <% if(message != null){ %>
	    <div class="alert">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Warning!</strong> <%=message%>
		</div>
	  <% } %>
	  <form method="post" action="jenjang.jsp">
		<input type="hidden" name="act" value="<%=actForm%>" />
		<fieldset>
			<legend><%=actForm.toUpperCase()%> Jenjang</legend>
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
			<label></label>
			<input type="submit" value="<%=actForm%>" class="btn btn-primary" />
		</fieldset>
	  </form>
	  <div>
	  <a href="jenjang.jsp">Tambah Jenjang</a>
	  </div>
	  <table class="table">
		<caption>Daftar Jenjang</caption>
		<thead>
			<tr>
				<th>Kode</th>
				<th>Nama</th>
				<th></th>
			</tr>
<%
List<JenjangObject> daftar = jenjang.list();
for(int i=0; i<daftar.size(); i++){
	JenjangObject ro = daftar.get(i);
%>
			<tr>
				<td><%=varUtil.show(ro.kode)%></td>
				<td><%=varUtil.show(ro.nama)%></td>
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