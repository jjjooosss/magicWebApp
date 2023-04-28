package magic.copy;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class copyDBBean {
	//이 클래스의 인스턴스를 오직 하나만 생성하고, 여러곳에서 참조할 수 있게 함
	//한 번만 생성해도 여러곳에서 참조가능  = static 
	//외부 접근을 막음=>private
	//=> 이게 바로 싱글톤 디자인패턴
	private static copyDBBean instance = new copyDBBean();
	
	//외부 접근을 막았으므로,이 클래스의 instance를 사용하려면 public 메소드가 필요함.
	public static copyDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	
}
