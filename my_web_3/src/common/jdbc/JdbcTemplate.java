package common.jdbc;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JdbcTemplate {

	public static Connection getConnection() {
		Connection conn = null;
		Properties prop = new Properties();
		
		try {
			String currentPath = JdbcTemplate.class.getResource("./").getPath(); // 이 클래스의 경로
			prop.load(new BufferedReader(new FileReader(currentPath+"driver.properties"))); 
													// (여기+properties파일 경로)
			
			Class.forName(prop.getProperty("db.driver"));
			conn = DriverManager.getConnection(prop.getProperty("db.url"),
												prop.getProperty("db.user"),
												prop.getProperty("db.pwd"));
			if(conn != null) {
				System.out.println("===== DB 연결 성공 =====");
			} else {
				System.out.println("===== DB 연결 실패 =====");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("===== ojdbc 드라이버 로딩 실패 =====");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("===== DB 연결 실패 =====");
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}
