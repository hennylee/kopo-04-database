

## 자바 

### 프로젝트 개요

![image](https://user-images.githubusercontent.com/77392444/117547988-678ab700-b06d-11eb-9dbe-24dea425ebd8.png)

- 필요 라이브러리 : gson-2.8.6.jar (json으로 변환) , ojdbc8.jar (Oracle DBMS 와 연결)

- 서버 : TomcatApache


### JDBC 데이터 연결

#### Customer.java : Oracle ResultSet을 받을 객체

```java
package ac.kr.kopo;

public class Customer {
	
	private String custom_region;
	private String custom_gender;
	private int total;
	private String age_range;
	
	
	public String getAge_range() {
		return age_range;
	}
	public void setAge_range(String age_range) {
		this.age_range = age_range;
	}
	public String getCustom_region() {
		return custom_region;
	}
	public void setCustom_region(String custom_region) {
		this.custom_region = custom_region;
	}
	public String getCustom_gender() {
		return custom_gender;
	}
	public void setCustom_gender(String custom_gender) {
		this.custom_gender = custom_gender;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
}
```


#### Jdbc.java : Oracle과 OJDBC Connection 연결하고 ResultSet 받기

```
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
		
//		
//		Jdbc jdbc = new Jdbc();
//		jdbc.results();
		
	}

}
```


#### CustomerServlet.servlet : 데이터를 JSON 형식으로 전송하는 서블릿

```java
package ac.kr.kopo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ac.kr.kopo.*;

@WebServlet("/chart")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CustomerServlet() {
    	
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Jdbc jdbc = new Jdbc();
		Gson gson = new Gson();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(gson.toJson(jdbc.results()));
	
	}

}
```



#### index.html : JSON 데이터 Ajax로 받아서, GoogleChartAPI를 활용한 시각화

```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript">
  
    $(document).ready(function(){
    	$.ajax({
    		url : "chart",
    		dataType : "JSON",
    		success : function(result) {
    			//alert(result);
    			google.charts.load('current', {packages: ['corechart']});
    			google.charts.setOnLoadCallback(function(){
    				drawChart(result);
    			});
    			   
    			function drawChart(result){
	    			var data = new google.visualization.DataTable();
	                data.addColumn('string', 'custom_region');
	                //data.addColumn('string', 'custom_gender');
	                data.addColumn('number', 'total');
	                //data.addColumn('string', 'age_range');
	               
	                var dataArray = [];
	                
	                $.each(result, function (i, obj) {
	                	dataArray.push([ obj.custom_region, 
	                		obj.total ]);
	                });
	                data.addRows(dataArray);
	                
	                var options = {
	                        title: "지역별 고객 수",
	                        width: 600,
	                        height: 400,
	                        bar: {groupWidth: "95%"},
	                        legend: { position: "none" },
	                };
    			
	                var barchart = new google.visualization.BarChart(document.getElementById('barchart_div'));
	                barchart.draw(data, options);
    			}
    	
    		}
    	})
    
    });
    </script>
  </head>
  <body>
    <div id="barchart_div"></div>
  </body>
</html>
```


#### 결과 : http://localhost:8080/database-project-1/index.jsp

![image](https://user-images.githubusercontent.com/77392444/117551119-0075fe00-b07f-11eb-9726-b22bf503795b.png)

