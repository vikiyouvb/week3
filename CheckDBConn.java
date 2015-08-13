import java.util.*;
import java.sql.*;

public class CheckDBConn
{
	public enum Fields
	{
		ID("id"),NAME("name");
		private String fname;
		private Fields(String name)
		{
			this.fname=name;
		}
		public String getName()
		{
			return this.fname;
		}
	}
	public static void main(String args[])
	{
		/*try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
			PreparedStatement stmt=conn.prepareStatement("SELECT * FROM users WHERE users.user_id=?");
			//String s="SELECT * FROM users LIMIT 1";
			stmt.setInt(1,1);
			ResultSet rs=stmt.executeQuery();
			while(rs.next())
			{
				System.out.println(rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3));
			}
		}
		catch(ClassNotFoundException ex)
		{
			System.out.println(ex.getMessage());
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}*/
			Fields f[]=new Fields[2];
		f[0]=Fields.ID;
		f[1]=Fields.NAME;
		System.out.println(f[0]+" "+f[1]);
	}
}