<%
class UserObject {
	public String username;
	public String password;
	public int kode_role;
}

class UserLogin {
	public String username;
	public String password;
}

class User {
	private Connection con;
	
	public User(Connection con){
		this.con = con;
	}

	public boolean login(UserLogin uo) throws Exception{
		
		boolean result = false;
		
		String sql = "SELECT count(*) AS jml FROM user WHERE username=? AND password=md5(?)";
		
		PreparedStatement ps =  con.prepareStatement(sql);
		ps.setString(1,uo.username);
		ps.setString(2,uo.password);
		
		ResultSet rs = ps.executeQuery();
		
		if ( rs.next() ) {
			if ( rs.getInt(1) == 1 ) result = true;
		}
		
		ps.close();
		
		return result;
	}
	
	public List<UserObject> list() throws Exception{
		String sql = "SELECT * FROM user";
		
		ArrayList<UserObject> daftar = new ArrayList<UserObject>();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			UserObject obj = new UserObject();
			obj.username = rs.getString("username");
			obj.password = rs.getString("password");
			obj.kode_role = rs.getInt("kode_role");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public List<UserObject> listByKodeRole(int kode_role) throws Exception{
		String sql = "SELECT * FROM user WHERE kode_role = ?";
		
		ArrayList<UserObject> daftar = new ArrayList<UserObject>();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode_role);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			UserObject obj = new UserObject();
			obj.username = rs.getString("username");
			obj.password = rs.getString("password");
			obj.kode_role = rs.getInt("kode_role");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public void insert(UserObject obj) throws Exception{
		String sql = "INSERT INTO user (username, password, kode_role) VALUES(?, md5(?), ?);";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,obj.username);
		ps.setString(2,obj.password);
		ps.setInt(3,obj.kode_role);
		
		ps.executeUpdate();
		
	}
	
	public void updatePassword(String username,String password) throws Exception{
		String sql = "UPDATE user SET password=md5(?) WHERE username=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,password);
		ps.setString(2,username);
		
		ps.executeUpdate();
		
	}
	
	public void updateKodeRole(String username,int kode_role) throws Exception{
		String sql = "UPDATE user SET kode_role=? WHERE username=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode_role);
		ps.setString(2,username);
		
		ps.executeUpdate();
		
	}
	
	public UserObject get(String username) throws Exception{
		
		String sql = "SELECT * FROM user WHERE username = ?;";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,username);
		
		ResultSet rs = ps.executeQuery();
		
		UserObject obj = new UserObject();
		
		if (rs.next()){
			obj.username = username;
			obj.password = rs.getString("password");
			obj.kode_role = rs.getInt("kode_role");
		}
		return obj;
	}
	
	public void delete(String username) throws Exception{
		String sql = "DELETE FROM user WHERE username = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,username);
		
		ps.executeUpdate();
	}

}
%>