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
