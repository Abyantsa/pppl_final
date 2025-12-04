<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin
if ( userLogin.kode_role != 1 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String message = null;

RoleObject obj = new RoleObject();

String actForm = "insert";

String act = request.getParameter("act");

if ( "edit".equals(act) ) {
	actForm = "update";
	
	int kode = varUtil.parseInt(request.getParameter("kode"));
	
	obj = role.get(kode);
}

else if("del".equals(act)){
	actForm = "delete";
	
	int kode = varUtil.parseInt(request.getParameter("kode"));
	
	obj = role.get(kode);
}

else if ( "update".equals(act) ) {
	try{
		
		RoleObject ro = new RoleObject();
		ro.kode = varUtil.parseInt(request.getParameter("kode"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		
		role.update(ro);
		
		response.sendRedirect("role.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if( "insert".equals(act) ){
	try{
		
		RoleObject ro = new RoleObject();
		ro.kode = varUtil.parseInt(request.getParameter("kode"));
		ro.nama = varUtil.parseString(request.getParameter("nama"));
		
		role.insert(ro);
		
		response.sendRedirect("role.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if("delete".equals(act)){
	try{

		int kode = varUtil.parseInt(request.getParameter("kode"));
	
		role.delete(kode);
		
		response.sendRedirect("role.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

%>
      <h1>Manajemen Role</h1>
      <% if(message != null){ %>
	    <div class="alert">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Warning!</strong> <%=message%>
		</div>
	  <% } %>
	  <form method="post" action="role.jsp">
		<input type="hidden" name="act" value="<%=actForm%>" />
		<fieldset>
			<legend><%=actForm.toUpperCase()%> Role</legend>
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
	  <a href="role.jsp">Tambah Role</a>
	  </div>
	  <table class="table">
		<caption>Daftar Role</caption>
		<thead>
			<tr>
				<th>Kode</th>
				<th>Nama</th>
				<th></th>
			</tr>
<%
List<RoleObject> daftar = role.list();
for(int i=0; i<daftar.size(); i++){
	RoleObject ro = daftar.get(i);
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