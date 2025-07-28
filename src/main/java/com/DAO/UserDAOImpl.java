package com.DAO;

import java.sql.Connection;

import com.entity.User;

public class UserDAOImpl implements UserDAO{
	
	private Connection conn;

	public UserDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	
	public boolean userRegister(User us) {
		
		try {
			String query = "insert into usermaster(empn,username,qtrno,email,phone,password,usercreationdate,status,role) values(?,?,?,?,?,?,SYSDATE,'A','NU')";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, us.getEmpn());
			pstmt.setString(2, us.getUsername());
			pstmt.setString(3, us.getQtrno());
			pstmt.setString(4, us.getEmail());
			pstmt.setString(5, us.getPhone());
			pstmt.setString(6, us.getPassword());

			int i = pstmt.executeUpdate();

			if (i == 1) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return false;
	}


	@Override
	public User userLogin(long empn, String password) {
	

		User us = null;
		try {
			String query = "select * from usermaster where empn=? and password=?";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, empn);
			pstmt.setString(2, password);

			java.sql.ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				us = new User();  
				us.setEmpn(rs.getLong("empn"));
				us.setUsername(rs.getString("username"));
				us.setQtrno(rs.getString("qtrno"));
				us.setEmail(rs.getString("email"));
				us.setPhone(rs.getString("phone"));
				us.setPassword(rs.getString("password"));
				us.setStatus(rs.getString("status"));
				us.setUsercreationdate(rs.getString("usercreationdate"));
				us.setRole(rs.getString("role")); // Assuming you have a role field in User entity
				
				// You can set other fields if needed
				// For example, if you have a field for user creation date or status
				
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return us;
	}
	
	@Override
	public User getUserByEmpn(long empn) {

		User us = null;
		try {
			String query = "select * from usermaster where empn=?";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, empn);

			java.sql.ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				us = new User();
				us.setEmpn(rs.getLong("empn"));
				us.setUsername(rs.getString("username"));
				us.setQtrno(rs.getString("qtrno"));
				us.setEmail(rs.getString("email"));
				us.setPhone(rs.getString("phone"));
				us.setPassword(rs.getString("password"));
				us.setStatus(rs.getString("status"));
				
				us.setUsercreationdate(rs.getString("usercreationdate"));
				us.setRole(rs.getString("role")); // Assuming you have a role field in User entity
				// You can set other fields if needed
				// For example, if you have a field for user creation date or status

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return us;
	}
	
	@Override
	public boolean updatePassword(long empn, String newPassword) {
		try {
			String query = "update usermaster set password=? where empn=?";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newPassword);
			pstmt.setLong(2, empn);

			int i = pstmt.executeUpdate();

			if (i == 1) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
	
	

}
