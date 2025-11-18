package com.DAO;

import com.entity.EndUser;
import com.entity.User;

public interface UserDAO {
	public boolean userRegister(User us);
	
	public User userLogin(long empn, String password);
	
	public User getUserByEmpn(long empn);
	
	public boolean updatePassword(long empn, String newPassword);
	
	public boolean enduserLogin(long empn, String password);
	

	public EndUser endUserDetail(long empn);

}
