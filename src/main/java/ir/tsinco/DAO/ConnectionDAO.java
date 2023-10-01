package ir.tsinco.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDAO {

    private static final String host = "192.168.10.13";
    private static final String dbName = "excel";
    private static final String username = "intern";
    private static final String password = "123456789";
    private static final int port = 3306;
    public  static Connection con = null;



    public static Connection ConnectionDB() {
        try {
            Class.forName("com.mysql.jdbc.Driver") ;
            if (con == null || con.isClosed()) {
                con = DriverManager.getConnection("jdbc:mysql://" + host + ":" + port + "/" + dbName, username, password);
            }

            return con;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
