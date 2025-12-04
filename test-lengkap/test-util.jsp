<%
class TestUtil{
	public static String myRootPass(){
		return "rahasia";
	}
	
	public static String myDbHost(){
		return "127.0.0.1";
	}
	
	public static String myCliDir(){
		return "C:\\Users\\radit\\AppData\\Roaming\\DBeaverData\\drivers\\clients\\mysql\\win";
	}
	
	public static String webInfDir(){
		return "C:\\apache-tomcat\\webapps\\latihan1-jsp\\WEB-INF";
	}
	
	public static String myCli(){
		return TestUtil.myCliDir()+"\\mysql.exe";
	}
	
	public static String sqlFile(){
		return TestUtil.webInfDir()+"\\dump-latihan1jsp-202511062206.sql";
	}
	
	public static void resetDb() throws Exception {
		
		String[] cmdHapusDb = {
			TestUtil.myCli(), 
			"-h", TestUtil.myDbHost(),
			"-u", "root", 
			"-p"+TestUtil.myRootPass(), 
			"-e", "DROP DATABASE "+Config.getDatabaseName()
		};
		
		Process p1 = Runtime.getRuntime().exec(cmdHapusDb);
		
		int exitCode1 = p1.waitFor(); 
		if (exitCode1 != 0) {
			System.out.println("Gagal Drop Database. Exit code: " + exitCode1);
		}
		
		String[] cmdCreateDb = {
			TestUtil.myCli(), 
			"-h", TestUtil.myDbHost(),
			"-u", "root", 
			"-p"+TestUtil.myRootPass(), 
			"-e", "CREATE DATABASE "+Config.getDatabaseName()
		};
		
		Process p2 = Runtime.getRuntime().exec(cmdCreateDb);

		
		int exitCode2 = p2.waitFor();
		if (exitCode2 != 0) {
			System.out.println("Gagal Create Database. Exit code: " + exitCode2);
		}
		
		String[] cmdPopulateDb = {
			TestUtil.myCli(), 
			"-h", TestUtil.myDbHost(),
			"-u", "root", 
			"-p" + TestUtil.myRootPass(), 
			"-D", Config.getDatabaseName() 
		};

		Process p3 = Runtime.getRuntime().exec(cmdPopulateDb);


		
		try (OutputStream stdin = p3.getOutputStream();
			 FileInputStream fileInputStream = new FileInputStream(TestUtil.sqlFile())) {
			
			
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = fileInputStream.read(buffer)) != -1) {
				stdin.write(buffer, 0, bytesRead);
			}
			stdin.flush();
		} // Otomatis close stream di sini

		int exitCode3 = p3.waitFor();
		

		
		if (exitCode3 != 0) {
			
			System.out.println("Gagal Populate Database. Exit code: " + exitCode3);
			
			// error dari mysql client
			java.io.BufferedReader errorReader = new java.io.BufferedReader(
				new java.io.InputStreamReader(p3.getErrorStream())
			);
			String line;
			System.out.println("--- ERROR LOG DARI MYSQL ---");
			while ((line = errorReader.readLine()) != null) {
				System.out.println(line);
			}
		} 
	} 
}
%>