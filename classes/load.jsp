<%@ page import="java.sql.*, java.util.*, java.io.*, java.nio.file.Path,java.net.URLEncoder,org.apache.commons.fileupload2.core.FileItem,org.apache.commons.fileupload2.core.DiskFileItemFactory,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload,org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletRequestContext, org.apache.commons.csv.*" %>

<%
// include file2 jsp di classes
%>

<%@ include file="config.jsp" %>
<%@ include file="db.jsp" %>
<%@ include file="var-util.jsp" %>
<%@ include file="jenis-kelamin.jsp" %>
<%@ include file="jenjang.jsp" %>
<%@ include file="role.jsp" %>
<%@ include file="user.jsp" %>
<%@ include file="prodi.jsp" %>
<%@ include file="mahasiswa.jsp" %>