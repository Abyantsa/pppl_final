<%
class ProdiObject{
	public int kode;
	public String nama;
	public int kode_jenjang;
}

class Prodi{
	
	private Connection con;
	
	public Prodi(Connection con){
		this.con = con;
	}
	
	public List<ProdiObject> list() throws Exception{
		String sql = "SELECT * FROM prodi";
		
		ArrayList<ProdiObject> daftar = new ArrayList<ProdiObject>();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			ProdiObject obj = new ProdiObject();
			obj.kode = rs.getInt("kode");
			obj.nama = rs.getString("nama");
			obj.kode_jenjang = rs.getInt("kode_jenjang");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public void insert(ProdiObject obj) throws Exception{
		String sql = "INSERT INTO prodi (kode, nama, kode_jenjang) VALUES(?, ?, ?);";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,obj.kode);
		ps.setString(2,obj.nama);
		ps.setInt(3,obj.kode_jenjang);
		
		ps.executeUpdate();
		
	}
	
	public void update(ProdiObject obj) throws Exception{
		String sql = "UPDATE prodi SET nama=?,kode_jenjang=? WHERE kode=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,obj.nama);
		ps.setInt(2,obj.kode_jenjang);
		ps.setInt(3,obj.kode);
		
		ps.executeUpdate();
		
	}
	
	
	public ProdiObject get(int kode) throws Exception{
		
		String sql = "SELECT * FROM prodi WHERE kode = ?;";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ResultSet rs = ps.executeQuery();
		
		ProdiObject obj = new ProdiObject();
		
		if (rs.next()){
			obj.kode = kode;
			obj.nama = rs.getString("nama");
			obj.kode_jenjang = rs.getInt("kode_jenjang");
		}
		return obj;
	}
	
	public void delete(int kode) throws Exception{
		String sql = "DELETE FROM prodi WHERE kode = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ps.executeUpdate();
	}
}
%>