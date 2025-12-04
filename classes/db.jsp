<%

class Db{
	
	public Connection createConnection() throws Exception{
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		
		String url = "jdbc:mysql://"+Config.getDatabaseHost()+"/"+Config.getDatabaseName();
		return DriverManager.getConnection(url, Config.getDatabaseUser(), Config.getDatabasePass());
	}
	
}

%>