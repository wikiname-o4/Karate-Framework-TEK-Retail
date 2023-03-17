package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class DataBaseUtility {
	private static final String db_url = "jdbc:mysql://tek-database-server.mysql.database.azure.com:3306/tek_insurance_app?useSSL=true&requireSSL=false";
	private static final String db_userName = "tek_student_user";
	private static final String db_password = "MAY_2022";

	// step 1 we need to establish the connection with DB
	private static Connection getConnection() {
		try {
			System.out.println("Making Connection to DataBase");
			return DriverManager.getConnection(db_url, db_userName, db_password);
		} catch (SQLException e) {
			throw new RuntimeException("Error Connecting to Database");
		}
	}

	private static Statement getConnectionStatement() {
		try {
			return getConnection().createStatement();
		} catch (SQLException e) {
			throw new RuntimeException("Error Creating Statement");
		}
	}

	public static ResultSet executeQuery(String query) {
		Statement statement;
		statement = getConnectionStatement();
		try {
			return statement.executeQuery(query);
		} catch (SQLException e) {
			throw new RuntimeException("Error executing query");
		}
	}

	public static List<Map<String, Object>> queryResult(String query) {
		Statement statement = null;
		try {
			List<Map<String, Object>> list = new LinkedList<>();
			ResultSet resultSet = executeQuery(query);
			statement = resultSet.getStatement();
			ResultSetMetaData metadata = resultSet.getMetaData();
			int columns = metadata.getColumnCount();
			while (resultSet.next()) {
				Map<String, Object> map = new HashMap<>();
				for (int i = 1; i <= columns; i++) {
					map.put(metadata.getColumnName(i), resultSet.getObject(i));
				}
				list.add(map);
			}
			return list;
		} catch (SQLException e) {
			throw new RuntimeException("Error executing query");
		} finally {
			if (statement != null) {
				try {
					statement.getConnection().close();
					statement.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public static String result(String query, String columnName) {
		List<Map<String, Object>> result = queryResult(query);
		return result.get(0).get(columnName).toString();
	}
}