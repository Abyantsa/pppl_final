<%
class MahasiswaObject{
	public String nim;
	public String nama;
	public int kode_jenis_kelamin;
	public int kode_prodi;
	public String username;
	
	public String[] header(){
		String[] h = {"nim","nama","kode_jenis_kelamin","kode_prodi","username"};
		
		return h;
	}
}

class MahasiswaImportError{
	public int baris;
	public String nim;
	public String message;
}

class Mahasiswa{
	
	private Connection con;
	
	public Mahasiswa(Connection con){
		this.con = con;
		
	}
	
	public List<MahasiswaObject> list() throws Exception{
		
		String sql = "SELECT * FROM mahasiswa";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		ArrayList<MahasiswaObject> daftar = new ArrayList<MahasiswaObject>();
		
		while(rs.next()){
			MahasiswaObject obj = new MahasiswaObject();
			obj.nim = rs.getString("nim");
			obj.nama = rs.getString("nama");
			obj.kode_jenis_kelamin = rs.getInt("kode_jenis_kelamin");
			obj.kode_prodi = rs.getInt("kode_prodi");
			obj.username = rs.getString("username");
			
			daftar.add(obj);
		}
		
		return daftar;
	}
	
	public void insert(MahasiswaObject obj) throws Exception{
		
		String sql = "INSERT INTO mahasiswa (nim, nama, kode_jenis_kelamin, kode_prodi, username) VALUES(?, ?, ?, ?, ?);";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1,obj.nim);
		ps.setString(2,obj.nama);
		ps.setInt(3,obj.kode_jenis_kelamin);
		ps.setInt(4,obj.kode_prodi);
		ps.setString(5,obj.username);
		
		ps.executeUpdate();
	}
	
	public void update(MahasiswaObject obj) throws Exception{
		
		String sql = "UPDATE mahasiswa SET nama=?, kode_jenis_kelamin=?, kode_prodi=?, username=? WHERE nim=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(5,obj.nim);
		ps.setString(1,obj.nama);
		ps.setInt(2,obj.kode_jenis_kelamin);
		ps.setInt(3,obj.kode_prodi);
		ps.setString(4,obj.username);
		
		ps.executeUpdate();
	}
	
	public MahasiswaObject get(String nim) throws Exception{
		String sql = "SELECT * FROM mahasiswa WHERE nim=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,nim);
		ResultSet rs = ps.executeQuery();
		
		MahasiswaObject obj = new MahasiswaObject();
		if (rs.next()){
			obj.nim = rs.getString("nim");
			obj.nama = rs.getString("nama");
			obj.kode_jenis_kelamin = rs.getInt("kode_jenis_kelamin");
			obj.kode_prodi = rs.getInt("kode_prodi");
			obj.username = rs.getString("username");
		}
		return obj;
	}
	
	public void delete(String nim) throws Exception{
		String sql = "DELETE FROM mahasiswa WHERE nim=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,nim);
		ps.executeUpdate();
	}
	
	public void upsert(MahasiswaObject obj) throws Exception{
		MahasiswaObject mOGet = this.get(obj.nim);
		
		if ( mOGet.nim != null ) {
			this.update(obj);
		}else{
			this.insert(obj);
		}
	}
}
%>