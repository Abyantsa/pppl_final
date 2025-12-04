<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin
if ( userLogin.kode_role != 1 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String message = null;

UserObject obj = new UserObject();
RoleObject rObj = new RoleObject();

List<RoleObject> daftarRole = role.list();

String actForm = "insert";

String act = request.getParameter("act");

if ( "editPass".equals(act) ) {
	actForm = "updatePass";
	
	String usernameInput = varUtil.parseString(request.getParameter("username"));
	
	obj = user.get(usernameInput);
	rObj = role.get(obj.kode_role);

}

else if("editRole".equals(act) ) {
	actForm = "updateKodeRole";
	
	String usernameInput = varUtil.parseString(request.getParameter("username"));
	
	obj = user.get(usernameInput);
	rObj = role.get(obj.kode_role);
	
}

else if("del".equals(act)){
	actForm = "delete";
	
	String usernameInput = varUtil.parseString(request.getParameter("username"));
	
	obj = user.get(usernameInput);
	rObj = role.get(obj.kode_role);
	
}

else if ( "updatePass".equals(act) ) {
	try{
		
		UserObject ro = new UserObject();
		ro.username = varUtil.parseString(request.getParameter("username"));
		ro.password = varUtil.parseString(request.getParameter("password"));
		
		user.updatePassword(ro.username,ro.password);
		
		response.sendRedirect("user.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if ( "updateKodeRole".equals(act) ) {
	try{
		
		UserObject ro = new UserObject();
		ro.username = varUtil.parseString(request.getParameter("username"));
		ro.kode_role = varUtil.parseInt(request.getParameter("kode_role"));
		
		user.updateKodeRole(ro.username,ro.kode_role);
		
		response.sendRedirect("user.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if( "insert".equals(act) ){
	try{
		
		UserObject ro = new UserObject();
		ro.username = varUtil.parseString(request.getParameter("username"));
		ro.password = varUtil.parseString(request.getParameter("password"));
		ro.kode_role = varUtil.parseInt(request.getParameter("kode_role"));
		
		user.insert(ro);
		
		response.sendRedirect("user.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

else if("delete".equals(act)){
	try{

		String usernameInput = varUtil.parseString(request.getParameter("username"));
		
		user.delete(usernameInput);
		
		response.sendRedirect("user.jsp?");
		return;
		
	}catch(Exception e){
		message = e.toString();
	}
}

%>
      <h1>Manajemen User</h1>
      <% if(message != null){ %>
	    <div class="alert">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Warning!</strong> <%=message%>
		</div>
	  <% } %>
	  <form method="post" action="user.jsp">
		<input type="hidden" name="act" value="<%=actForm%>" />
		<fieldset>
			<legend><%=actForm.toUpperCase()%> User</legend>
			<label>Username</label>
			<% if (( "updatePass".equals(actForm) || "delete".equals(actForm) ) || "updateKodeRole".equals(actForm) ) {%>
			<input type="hidden" name="username" value="<%=varUtil.show(obj.username)%>" />
			<label><%=varUtil.show(obj.username)%></label>
			<% }else{ %>
			<input type="text" name="username" value="<%=varUtil.show(obj.username)%>" />
			<% } %>
			<% if("updatePass".equals(actForm) || "insert".equals(actForm)){ %>
			<label>Password</label>
			<input type="text" name="password" value="" />
			<% } %>
			<% if("updateKodeRole".equals(actForm) || "insert".equals(actForm)){ %>
			<label>Role</label>
			<select name="kode_role">
			<% for(int i=0;i<daftarRole.size();i++){ 
				RoleObject jo = daftarRole.get(i);
				String selected = "";
				
				if ( jo.kode == obj.kode_role ) selected="selected='selected'";
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
	  <a href="user.jsp">Tambah User</a>
	  </div>
	  <table class="table">
		<caption>Daftar User</caption>
		<thead>
			<tr>
				<th>Username</th>
				<th>Role</th>
				<th></th>
			</tr>
<%
List<UserObject> daftar = user.list();
for(int i=0; i<daftar.size(); i++){
	UserObject ro = daftar.get(i);
	RoleObject roo = role.get(ro.kode_role);
%>
			<tr>
				<td><%=varUtil.show(ro.username)%></td>
				<td><%=varUtil.show(roo.nama)%></td>
				<td><a href="?act=editPass&username=<%=ro.username%>">ganti password</a> | <a href="?act=editRole&username=<%=ro.username%>">ganti role</a> | <a href="?act=del&username=<%=ro.username%>">hapus</a></td>
			</tr>
<%
}
%>
		</thead>
		<tbody>
		</tbody>
	  </table>

<%@ include file="part/footer.jsp" %>