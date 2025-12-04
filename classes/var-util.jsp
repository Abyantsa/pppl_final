<%
class VarUtil{

	public String show(String val) throws Exception{
		if (val == null ) val = "";
		return val;
	}
	
	public String show(int val) throws Exception {
		if (val == 0 ) return "";
		return ""+val;
	}
	
	public String parseString(String prm) throws Exception { 
		String result = prm;
		if ( prm != null && "".equals(prm.trim()) ) result = null;
		
		return result;
	}
	
	public int parseInt(String prm) throws Exception{
		int result = 0;
		try{
			result = Integer.parseInt(prm);
		}catch(Exception e){}
		
		return result;
	}		

}
%>