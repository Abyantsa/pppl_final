<%
class JenjangObject{

	public int kode;
	public String nama;

}

class Jenjang {

	private Connection con;
	
	public Jenjang(Connection con) {
		this.con = con;
	}
	
	public List<JenjangObject> list() throws Exception{
		String sql = "SELECT * FROM jenjang";
		
		ArrayList<JenjangObject> daftar = new ArrayList<JenjangObject>();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			JenjangObject obj = new JenjangObject();
			obj.kode = rs.getInt("kode");
			obj.nama = rs.getString("nama");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public void insert(JenjangObject obj) throws Exception{
		String sql = "INSERT INTO jenjang (kode, nama) VALUES(?, ?);";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,obj.kode);
		ps.setString(2,obj.nama);
		
		ps.executeUpdate();
		
	}
	
	public void update(JenjangObject obj) throws Exception{
		String sql = "UPDATE jenjang SET nama=? WHERE kode=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(2,obj.kode);
		ps.setString(1,obj.nama);
		
		ps.executeUpdate();
		
	}
	
	public JenjangObject get(int kode) throws Exception{
		
		String sql = "SELECT nama FROM jenjang WHERE kode = ?;";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ResultSet rs = ps.executeQuery();
		
		JenjangObject obj = new JenjangObject();
		
		if (rs.next()){
			obj.kode = kode;
			obj.nama = rs.getString("nama");
		}
		return obj;
	}
	
	public void delete(int kode) throws Exception{
		String sql = "DELETE FROM jenjang WHERE kode = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ps.executeUpdate();
	}

}
%>