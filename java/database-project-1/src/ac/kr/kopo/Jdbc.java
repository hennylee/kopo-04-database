package ac.kr.kopo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;

public class Jdbc extends HttpServlet {

	public List<Customer> results() {
		// connection 객체
		Connection conn = null;
		
		// 연결에 필요한 문자열
		String url = "jdbc:oracle:thin:@192.168.119.119:1521:dink";
		String id = "scott";
		String pw = "tiger";
		
		// 쿼리 결과
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		// 시각화할 결과
		List<Customer> customList = new ArrayList<Customer>();
		
		// oracle 연결
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
			
			System.out.println("접속중....");
			
			
			// 쿼리 전송
			try {

				String sql = "SELECT city, gender, \r\n"
						+ "CASE\r\n"
						+ "    WHEN age BETWEEN 10 AND 19 THEN '10대'\r\n"
						+ "    WHEN age BETWEEN 20 AND 29 THEN '20대'\r\n"
						+ "    WHEN age BETWEEN 30 AND 39 THEN '30대'\r\n"
						+ "    WHEN age BETWEEN 40 AND 49 THEN '40대'\r\n"
						+ "    WHEN age BETWEEN 50 AND 59 THEN '50대'\r\n"
						+ "    WHEN age BETWEEN 60 AND 69 THEN '60대'\r\n"
						+ "    WHEN age BETWEEN 70 AND 79 THEN '70대'\r\n"
						+ "    ELSE '기타'\r\n"
						+ "END as age_range, count(*) as count \r\n"
						+ "FROM (SELECT substr(address1, 1,2) as city, gender,\r\n"
						+ "             trunc((sysdate - birth_dt) / 365) as age\r\n"
						+ "      FROM customer)\r\n"
						+ "GROUP BY city, age, gender\r\n"
						+ "ORDER BY age, city, gender";
				
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				System.out.println("쿼리 전송 성공");
				
				while(rs.next()) {
					
					
					Customer customer = new Customer();
					
					customer.setCustom_region(rs.getString(1));
					customer.setCustom_gender(rs.getString(2));
					customer.setAge_range(rs.getString(3));
					customer.setTotal(rs.getInt(4));
					
					customList.add(customer);
				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
				System.out.println("쿼리 전송 실패");
			}
			
			// oracle 연결 해제
			conn.close();
			System.out.println(conn.isClosed()? "접속종료" : "접속중...");
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		
		return customList;
	}
	
	public static void main(String[] args) {
		
//		Jdbc jdbc = new Jdbc();
//		jdbc.results();
		
	}

}
