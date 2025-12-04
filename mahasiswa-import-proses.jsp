<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin, dosen, tendik
if ( userLogin.kode_role > 3 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

if ( request.getParameter("file") == null ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

%>
      <h1>Import Data Mahasiswa</h1>
	  <a href="mahasiswa.jsp">Kembali</a>
	  <table class="table">
		<caption>Rekap Hasil Import</caption>
		<thead>
			<tr>
				<th>Baris</th>
				<th>Status</th>
				<th>Pesan Error</th>
			</tr>
		</thead>
		<tbody>
		<%
		String[] header = new MahasiswaObject().header();
		
		String file = (Config.getTempDir()+File.separator+request.getParameter("file"));
		
		File f = new File(file);
		
		BufferedReader reader = new BufferedReader(new FileReader(f));
		String line;
		int baris = 0;
		boolean ready = true;
		while ( (line = reader.readLine()) != null ){
			baris++;
			CSVParser parser = CSVParser.parse(line, CSVFormat.DEFAULT);
			List<CSVRecord> daftarRecord = parser.getRecords();
			CSVRecord record = daftarRecord.get(0);
			
			if ( baris == 1 ) {
				for ( int i=0; i<header.length; i++ ) {
					if ( !header[i].equals(record.get(i)) ) {
						ready = false;
						break;
					}
					
				}
				continue;
			}
			
			if ( !ready ) {
				break;
			}
			
			String status = "OK";
			String pesanError = "";
			
			try{
				MahasiswaObject mo = new MahasiswaObject();
				mo.nim = varUtil.parseString(record.get(0));
				mo.nama = varUtil.parseString(record.get(1));
				mo.kode_jenis_kelamin = varUtil.parseInt(record.get(2));
				mo.kode_prodi = varUtil.parseInt(record.get(3));
				mo.username = varUtil.parseString(record.get(4));
				
				mahasiswa.upsert(mo);
				
			}catch(Exception e){
				
				status = "ERROR";
				pesanError = e.toString();
			}
%>
			<tr>
				<td><%=varUtil.show(baris)%></td>
				<td><%=varUtil.show(status)%></td>
				<td><%=varUtil.show(pesanError)%></td>
			</tr>
<%
		}
		
		reader.close();
		
		f.delete();
		f = null;
		
		
		%>
		</tbody>
	  </table>
<%@ include file="part/footer.jsp" %>