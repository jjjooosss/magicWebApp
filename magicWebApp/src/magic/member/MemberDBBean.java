package magic.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//회원정보 처리 빈 객체
public class MemberDBBean {
//	jsp 소스에서 편하기 쓰기위해 빈객체 생성, 참조 변수 미리 생성
	private static MemberDBBean instance = new MemberDBBean();
	
//	1) MemberDBBean 객체 레퍼런스를 리턴하는 메소드
	public static MemberDBBean getInstatnce() {
		return instance;
	}
	
//	데이터베이스를 쉽게 처리하기 위해 메소드 생성
//	2)쿼리작업에 사용할 커넥션 객체를 리턴하는 메소드(dbcp 기법)
	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
//	3) 전달인자로 받은 member를 memberT 테이블에 삽입하는 메소드 (회원추가)
	public int insertMember(MemberBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
//		매개변수로 받은 member 객체를 ? 인 쿼리 파라미터에 매핑
		String sql="INSERT INTO MEMBERT VALUES(?,?,?,?,?)";
		int re=-1;//초기값 -1, insert 정상적으로 실행되면 1;
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(sql); //쿼리담음
			pstmt.setString(1, member.getMem_uid()); //0번이 아닌 1번부터 시작
			pstmt.setString(2, member.getMem_pwd()); 
			pstmt.setString(3, member.getMem_name()); 
			pstmt.setString(4, member.getMem_email()); 
			pstmt.setString(5, member.getMem_address());
			
//			INSERT 문은 executeUpdate 메소드 호출함
			pstmt.executeUpdate();
			re=1;
			
			//finally에서도 가능하지만 try문 안에서도 close 가능
			pstmt.close();
			conn.close();
			System.out.println("추가 성공");
		} catch (Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		}
		return re;
	}
	
//	4) 회원 가입 시 아이디 중복 확인할 때 사용하는 메소드
	public int confirmID(String id) { //select쿼리 사용
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		매개변수로 받은 id 객체를 ? 인 쿼리 파라미터에 매핑
		String sql="SELECT Mem_uid FROM MEMBERT WHERE Mem_uid=?"; //?가 Mem_uid 매핑 시켜야 함.
		int re=-1;//초기값 -1, 아이디가 중복되면 1  
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(sql); //쿼리담음
			pstmt.setString(1, id);
//			SELECT문은 executeQuery 메소드 호출
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				re=1;
			}else { //해당 아이디가 존재하지 않음
				re=-1;
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	
//	//5) 사용자 인증시 사용하는 메소드
	public int userCheck(String id, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		매개변수로 받은 id를 ?인 쿼리파라미터에 매핑
		String sql="SELECT mem_pwd FROM MEMBERT WHERE mem_uid=?";
		int re=-1;//초기값 -1, 비밀번호 일치 1, 불일치 0
		String db_mem_pw="";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				db_mem_pw = rs.getString("mem_pwd");
				if (db_mem_pw.equals(pwd)) {//패스워드도 일치
					re=1;
				}else {//패스워드는 불일치
					re=0;
				}
			}else { //해당 아이디가 존재하지 않음
				re=-1;
			}
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	//6) 아이디가 일치하는 멤버의 정보를 얻어오는 메소드
	public MemberBean getMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="SELECT mem_uid, mem_pwd, mem_name, mem_email, mem_address"
				+ " FROM MEMBERT WHERE mem_uid=?";
//		member :쿼리 결과에 해당하는 회원정보를 담는 객체
		MemberBean member=null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				member = new MemberBean();
				member.setMem_uid(rs.getString("mem_uid"));
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_address(rs.getString("mem_address"));
			}else{
			rs.close();
			pstmt.close();
			conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	   return member;
	}
	public int updateMember(MemberBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql="UPDATE MEMBERT SET mem_pwd=?, mem_email=?, mem_address=? WHERE mem_uid=?";
		int re=-1;//초기값 -1, 변경된 행 갯수 1
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql); 
			System.out.println("@# getMem_pwd ===>"+member.getMem_pwd());
			System.out.println("@# getMem_email ===>"+member.getMem_email());
			System.out.println("@# getMem_address ===>"+member.getMem_address());
			System.out.println("@# getMem_uid ===>"+member.getMem_uid());
			
			pstmt.setString(1, member.getMem_pwd());
			pstmt.setString(2, member.getMem_email());
			pstmt.setString(3, member.getMem_address());
			pstmt.setString(4, member.getMem_uid());
			re = pstmt.executeUpdate();
			
//			System.out.println("변경 성공"); 오류가 나도 출력됨
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("변경 실패");
		}
		return re;
	}
}
