package magic.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

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
//		ResultSet rs = null;
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
			
			
			sql = "INSERT INTO boardt(b_id, b_name, b_email, b_title, b_content, b_date, b_hit, b_pwd)"
//					+ " VALUES(?,?,?,?,?)";
					+ " VALUES((SELECT nvl(max(b_id),0)+1 FROM boardt),?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, num);
			pstmt.setString(1, board.getB_name());
			pstmt.setString(2, board.getB_email());
			pstmt.setString(3, board.getB_title());
			pstmt.setString(4, board.getB_content());
			pstmt.setTimestamp(5, board.getB_date());
			pstmt.setInt(6, 0);
			pstmt.setString(7, board.getB_pwd());
			re = pstmt.executeUpdate();
//			re=1;
			
//			rs.close();
			pstmt.close();
			conn.close();
			
			System.out.println("추가 성공");
		} catch (Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		}
		return re;
	}
	
	public ArrayList<BoardBean> listBoard() {
		
		Connection conn=null;
//		PreparedStatement pstmt =null;
		Statement stmt =null;
		ResultSet rs = null;
		
		String sql ="";
		
		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		
		try {
			sql ="SELECT b_id, b_name, b_email, b_title, b_content, b_date, b_hit, b_pwd"
					+ " FROM BOARDT ORDER BY B_ID DESC";
			
			conn= getConnection();
//			pstmt = conn.prepareStatement(sql);
			stmt = conn.createStatement();
//			rs = pstmt.executeQuery();
			rs = stmt.executeQuery(sql);
			
			
			while (rs.next()) {
				BoardBean board = new BoardBean();
				
//				쿼리 결과를 BoardBean 객체에 담아서 ArratList 에 저장
				board.setB_id(rs.getInt("b_id"));
				board.setB_name(rs.getString("b_name"));
				board.setB_email(rs.getString("b_email"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_hit(rs.getInt(7));
				board.setB_pwd(rs.getString(8));
				//여기까지가 1행을 가져와서 저장
				
//				행의 데이터를 ArrayList에 저장
				list.add(board);
			}
			stmt.close();
			conn.close();
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public BoardBean getBoard(int num) {

		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		String sql ="";
		BoardBean board = null;
		
		
		try {
			conn= getConnection();
//			조회수 1 증가 sql
			sql = "update boardt set B_hit =(b_hit+1) where b_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
//			글 내용 보기
			sql ="SELECT b_id, b_name, b_email, b_title, b_content, b_date, b_hit, b_pwd"
					+ " FROM BOARDT WHERE b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				board = new BoardBean();
				
				board.setB_id(rs.getInt("b_id"));
				board.setB_name(rs.getString("b_name"));
				board.setB_email(rs.getString("b_email"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_hit(rs.getInt("b_hit"));
				board.setB_pwd(rs.getString("b_pwd"));
			}
			pstmt.close();
			conn.close();
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	public int deleteBoard(int num, String pwd) {
		
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		int re=-1;
		
		String sql ="";
		String b_pwd ="";
		
		try {
			
			conn= getConnection();
			sql = "select b_pwd from boardt where b_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				b_pwd = rs.getString("b_pwd");
				if (pwd.equals(b_pwd)) {
					sql= "delete from boardt where b_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					re=1;
				} else {
					re = 0;//비번 불일치
				}
			}
//			pstmt.close();
//			conn.close();
//			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}

}
