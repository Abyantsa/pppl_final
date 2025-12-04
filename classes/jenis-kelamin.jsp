<%
class JenisKelaminObject{
	public int kode;
	public String nama;
}

class JenisKelamin {

	private Connection con;
	
	public JenisKelamin(Connection con) {
		this.con = con;
	}
	
	public List<JenisKelaminObject> list() throws Exception{
		String sql = "SELECT * FROM jenis_kelamin";
		
		ArrayList<JenisKelaminObject> daftar = new ArrayList<JenisKelaminObject>();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			JenisKelaminObject obj = new JenisKelaminObject();
			obj.kode = rs.getInt("kode");
			obj.nama = rs.getString("nama");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public void insert(JenisKelaminObject obj) throws Exception{
		String sql = "INSERT INTO jenis_kelamin (kode, nama) VALUES(?, ?);";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,obj.kode);
		ps.setString(2,obj.nama);
		
		ps.executeUpdate();
		
	}
	
	public void update(JenisKelaminObject obj) throws Exception{
		String sql = "UPDATE jenis_kelamin SET nama=? WHERE kode=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(2,obj.kode);
		ps.setString(1,obj.nama);
		
		ps.executeUpdate();
		
	}
	
	public JenisKelaminObject get(int kode) throws Exception{
		
		String sql = "SELECT nama FROM jenis_kelamin WHERE kode = ?;";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ResultSet rs = ps.executeQuery();
		
		JenisKelaminObject obj = new JenisKelaminObject();
		
		if (rs.next()){
			obj.kode = kode;
			obj.nama = rs.getString("nama");
		}
		return obj;
	}
	
	public void delete(int kode) throws Exception{
		String sql = "DELETE FROM jenis_kelamin WHERE kode = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,kode);
		
		ps.executeUpdate();
	}

}
%>