package himedia.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GuestBookDaoOracleImpl implements GuestBookDao {
	private String dbuser;
	private String dbpass;
	private String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	
	public GuestBookDaoOracleImpl(String dbuser, String dbpass) {
		this.dbuser = dbuser;
		this.dbpass = dbpass;
	}
	
	private Connection getConnection() throws SQLException {
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            return DriverManager.getConnection(dburl, dbuser, dbpass);
        } catch (ClassNotFoundException e) {
            throw new SQLException("드라이버 로드 실패", e);
        }
    }
	
	@Override
	public List<GuestVo> getList() {
        List<GuestVo> list = new ArrayList<>();
        String sql = "SELECT no, name, password, content, reg_date FROM guestbook";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                long no = rs.getLong("no");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String content = rs.getString("content");
                Date regDate = rs.getDate("reg_date");
                GuestVo vo = new GuestVo(no, name, password, content, regDate);
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public boolean insert(GuestVo vo) {
        String sql = "INSERT INTO guestbook (no, name, password, content, reg_date) VALUES (seq_guestbook_no.nextval, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, vo.getName());
            pstmt.setString(2, vo.getPassword());
            pstmt.setString(3, vo.getContent());
            pstmt.setDate(4, new java.sql.Date(vo.getRegDate().getTime()));
            int count = pstmt.executeUpdate();
            return count == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

	@Override
    public boolean delete(Long no) {
        String sql = "DELETE FROM guestbook WHERE no = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, no);
            int count = pstmt.executeUpdate();
            return count == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
}
