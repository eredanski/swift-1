<%@page import="citizens.Citizen"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    static final String DB_CONN_STRING = "jdbc:mysql://192.168.164.3:3306/citizen_registrations";
    static final String DB_USERNAME = "root";
    static final String DB_PASSWORD = "swift12345";
%>
<%
    //Class.forName("com.mysql.jdbc.Driver");
    try (Connection conn = DriverManager.getConnection(DB_CONN_STRING, DB_USERNAME, DB_PASSWORD);
            PreparedStatement statement = conn.prepareStatement("SELECT first_name, last_name, birth_date, height "
                    + "FROM citizens WHERE id = ?")) {
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <%
            String strId = request.getParameter("citizenId");
            if (strId != null && !strId.isEmpty() && strId.matches("^\\d+$")) {

                statement.setInt(1, Integer.parseInt(strId));

                Citizen citizen;
                try (ResultSet rs = statement.executeQuery()) {
                    rs.next();
                    citizen = new Citizen(
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getDate("birth_date").toLocalDate(),
                            rs.getInt("height"));
                }
        %>
        <table>
            <tr>
                <td>First name:</td>
                <td><%=citizen.firstName%></td>
            </tr>
            <tr>
                <td>Last name:</td>
                <td><%=citizen.lastName%></td>
            </tr>
            <tr>
                <td>Date of birth:</td>
                <td><%=citizen.dateOfBirth%></td>
            </tr>
            <tr>
                <td>Height</td>
                <td><%=citizen.height%></td>
            </tr>
        </table>
        <%}
            }%>
    </body>
</html>
