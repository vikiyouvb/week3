import java.util.*;
import java.sql.*;
import java.io.*;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class PhoneDirectoryJDBC
{
	private Connection conn;
	public enum Fields{
		NAME("name"),ADDRESS("address"),MOBILE("mobile"),WORK("work"),HOME("home");
		private String fname;
		private Fields(String fname)
		{
			this.fname=fname;
		}
		public String getName()
		{
			return this.fname;
		}
	}
	public PhoneDirectoryJDBC(String dbname,String username,String password) throws SQLException,ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost/"+dbname,username,password);
	}
	public void insertRecord(String vals[]) throws SQLException
	{
		PreparedStatement stmt=conn.prepareStatement("INSERT INTO phone_directory (name,address,mobile,home,work) VALUES (?,?,?,?,?)");
		stmt.setString(1,vals[0]);
		stmt.setString(2,vals[1]);
		stmt.setString(3,vals[2]);
		stmt.setString(4,vals[3]);
		stmt.setString(5,vals[4]);
		stmt.executeUpdate();
	}
	private ResultSet filterByName(String name) throws SQLException
	{
		PreparedStatement stmt=conn.prepareStatement("SELECT id,name,address,mobile,work,home FROM phone_directory WHERE name LIKE ?");
		stmt.setString(1,"%"+name+"%");
		ResultSet rs=stmt.executeQuery();
		return rs;
	}
	private ResultSet filterByNumber(String number) throws SQLException
	{
		PreparedStatement stmt=conn.prepareStatement("SELECT id,name,address,mobile,work,home FROM phone_directory WHERE ? IN (mobile,home,work)");
		stmt.setString(1,number);
		ResultSet rs=stmt.executeQuery();
		return rs;
	}
	private void display(Fields f[],ResultSet rs) throws SQLException
	{
		while(rs.next())
		{
			
			for(int i=0;i<f.length;i++)
			{
				System.out.print(rs.getString(f[i].getName())+"\t");
			}
			System.out.println();
		}
	}
	private void display(ResultSet rs) throws SQLException
	{
			while(rs.next())
			{
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getString(3)+" "+rs.getString(4)+" "+rs.getString(5)+" "+rs.getString(6));
			}
	}
	public boolean getByName(String name,Fields... f) throws SQLException
	{
		ResultSet rs=filterByName(name);
		boolean retVal=rs.next();
		rs.beforeFirst();
		if(f.length==0)
		{
			display(rs);
		}
		else
		{
			display(f,rs);
		}
		return retVal;
	}
	public boolean getByNumber(String num,Fields... f) throws SQLException
	{
		ResultSet rs=filterByNumber(num);
		boolean retVal=rs.next();
		rs.beforeFirst();
		if(f.length==0)
		{
			display(rs);
		}
		else
		{
			display(f,rs);
		}
		return retVal;
	}
	public void updateDetails(long id,String val[],Fields... f) throws SQLException
	{
		StringBuilder br=new StringBuilder("UPDATE phone_directory SET ");
		int i;
		for(i=0;i<f.length-1;i++)
		{
			br.append(f[i].getName()+"=?,");
		}
		br.append(f[i].getName()+"? ");
		br.append("WHERE id=?");
		PreparedStatement stmt=conn.prepareStatement(br.toString());
		for(i=0;i<val.length;i++)
		{
			stmt.setString(i+1,val[i]);
		}
		stmt.setLong(i+1,id);
		stmt.executeUpdate();
	}
	public void processJSON(String fname) throws IOException,ParseException,SQLException
	{
		JSONParser parser=new JSONParser();
		JSONArray contacts=(JSONArray)parser.parse(new FileReader(fname));
		for(int i=0;i<contacts.size();i++)
		{
			JSONObject contact=(JSONObject)contacts.get(i);
			String vals[]=new String[5];
			vals[0]=(String)contact.get("name");
			vals[1]=(String)contact.get("address");
			vals[2]=(String)contact.get("mobile");
			vals[3]=(String)contact.get("home");
			vals[4]=(String)contact.get("work");
			insertRecord(vals);
		}
	}
	public static void main(String args[]) throws Exception
	{
		BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
		int ch;
		System.out.println("Enter the JSON file name");
		String fname=br.readLine();
		try
		{
			PhoneDirectoryJDBC pd=new PhoneDirectoryJDBC("week3","root","");
			pd.processJSON(fname);
			while(true)
			{
				System.out.println("Enter your choice");
				System.out.println("1.Find by name\n2.Find by number\n3.Any other number to quit");
				ch=Integer.parseInt(br.readLine());
				if(ch==1)
				{
					System.out.println("Enter the name");
					pd.getByName(br.readLine());
				}
				else if(ch==2)
				{
					System.out.println("Enter the number");
					pd.getByNumber(br.readLine());
				}
				else
				{
					break;
				}
			}
		}
		catch(IOException ex)
		{
			System.out.println(ex.getMessage());
		}
		catch(ParseException ex)
		{
			System.out.println(ex.getMessage());
		}
		catch(SQLException ex)
		{
			System.out.println(ex.getMessage());
		}
	}
}