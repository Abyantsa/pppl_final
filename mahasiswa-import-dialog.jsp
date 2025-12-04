<%@ include file="part/header.jsp" %>
<%
// cek jika bukan admin, dosen, tendik
if ( userLogin.kode_role > 3 ) {
	response.sendRedirect("error-hak-akses.jsp");
	return;
}

String message = null;

String actForm = "import";

String act = request.getParameter("act");

if ( "import".equals(act) ) {
	String newRandomName = null; 
	FileItem uploadedFileItem = null; // Untuk menyimpan 'FileItem' dari file
	
	
	boolean isMultipart = JakartaServletFileUpload.isMultipartContent(request);

	if (isMultipart) {
		try {
			
			DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
			
			
			JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);

			List<FileItem> items = upload.parseRequest(new JakartaServletRequestContext(request));

			for (FileItem item : items) {
				if (!item.isFormField() && "file".equals(item.getFieldName())) {
					uploadedFileItem = item;
					break; 
				}
			}
			
			if (uploadedFileItem != null && uploadedFileItem.getName() != null && !uploadedFileItem.getName().isEmpty()) {
				
				String uploadPath = Config.getTempDir();
				
				// Ambil nama file asli (dan bersihkan path-nya jika ada)
				String originalFileName = new File(uploadedFileItem.getName()).getName();

				
				String extension = "";
				int i = originalFileName.lastIndexOf('.');
				if (i > 0) {
					extension = originalFileName.substring(i);
				}
				newRandomName = UUID.randomUUID().toString() + extension;

				
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) uploadDir.mkdirs();
				Path finalFilePath = new File(uploadPath, newRandomName).toPath();

				
				uploadedFileItem.write(finalFilePath);

				
				response.sendRedirect("mahasiswa-import-waiting.jsp?file=" + newRandomName);
				return; // PENTING: Hentikan eksekusi

			} else {
				message = "Anda tidak memilih file untuk di-upload.";
			}

		} catch (Exception e) {
			message = "Upload Gagal";
			e.printStackTrace(); // Penting untuk debugging di log tomcat
		}
	} else {
		message = "Form tidak valid (bukan multipart/form-data).";
	}

}


%>
      <h1>Import Data Mahasiswa</h1>
	  <div>
		  <a href="mahasiswa.jsp">Kembali</a> |
		  <a href="mahasiswa-template.csv" target="_blank">Download Template</a> |
	  </div>
      <% if(message != null){ %>
	    <div class="alert">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Warning!</strong> <%=message%>
		</div>
	  <% } %>
	  <form method="post" action="mahasiswa-import-dialog.jsp?act=<%=actForm%>" enctype = "multipart/form-data">
		<fieldset>
			<legend><%=actForm.toUpperCase()%> User</legend>
			
			<label>File</label>
			<input type="file" name="file" />
			
			<label></label>
			<input type="submit" value="<%=actForm%>" class="btn btn-primary" />
		</fieldset>
	  </form>

<%@ include file="part/footer.jsp" %>