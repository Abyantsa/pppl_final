<%
class RoleObject{
	public int kode;
	public String nama;
}

class Role{
	private Connection con;
	
	public Role(Connection con){
		this.con = con;
	}
	
	public List<RoleObject> list() throws Exception{
		String sql = "SELECT * FROM role";
		
		ArrayList<RoleObject> daftar = new ArrayList<RoleObject>();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			RoleObject obj = new RoleObject();
			obj.kode = rs.getInt("kode");
			obj.nama = rs.getString("nama");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public void insert(RoleObject obj) throws Exception{
		String sql = "INSERT INTO role (kode, nama) VALUES(?, ?);";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,obj.kode);
		ps.setString(2,obj.nama);
		
		ps.executeUpdate();
		
	}
	
	public void update(RoleObject obj) throws Exception{
		String sql = "UPDATE role SET nama=? WHERE kode=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(2,obj.kode);
		ps.setString(1,obj.nama);
		
		ps.executeUpdate();
		
	}
	
	public RoleObject get(int kode) throws Exception{
		
		String sql = "SELECT nama FROM role WHERE kode = ?;";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ResultSet rs = ps.executeQuery();
		
		RoleObject obj = new RoleObject();
		
		if (rs.next()){
			obj.kode = kode;
			obj.nama = rs.getString("nama");
		}
		return obj;
	}
	
	public void delete(int kode) throws Exception{
		String sql = "DELETE FROM role WHERE kode = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ps.executeUpdate();
	}
}
%>