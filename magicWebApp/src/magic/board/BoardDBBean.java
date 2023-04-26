package magic.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BoardDBBean {
	
	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	//dbcp사용 위한 메소드
	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertBoard(BoardBean board) {
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		String sql = "";
		int re=-1;//초기값 -1, insert 정상적으로 실행되면 1
		int num;
		try {
			conn = getConnection();
//			글번호 최대값+1 을 구함 : null일때 1 아니면 +1
//			String selectSql = "SELECT MAX(b_id) FROM boardt";
//			pstmt = conn.prepareStatement(selectSql);
//			rs = pstmt.executeQuery();
//			
//			if (rs.next()) {
//				num = rs.getInt(1) + 1;
//			}else {
//				num =1;
//			}
			
			
			sql = "INSERT INTO boardt(b_id, b_name, b_email, b_title, b_content)"
//					+ " VALUES(?,?,?,?,?)";
					+ " VALUES((SELECT nvl(max(b_id),0)+1 FROM boardt),?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, num);
			pstmt.setString(1, board.getB_name());
			pstmt.setString(2, board.getB_email());
			pstmt.setString(3, board.getB_title());
			pstmt.setString(4, board.getB_content());
			re = pstmt.executeUpdate();
//			re=1;
			
			pstmt.close();
			conn.close();
			rs.close();
			
			System.out.println("추가 성공");
		} catch (Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		}
		return re;
	}
}
