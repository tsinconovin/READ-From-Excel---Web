package ir.tsinco.DAO;

import ir.tsinco.model.Salary;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SalaryDAO {

    private Connection connection;

    public SalaryDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Salary> getTotalList() {
        List<Salary> totalSalaiesList = new ArrayList<>();
        ConnectionDAO.ConnectionDB();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT * FROM salery ";
            ps = ConnectionDAO.con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getLong("id"));
                s.setFirstName(rs.getString("first_name"));
                s.setAmount(rs.getLong("amount"));
                s.setLastName(rs.getString("last_name"));
                s.setYear(rs.getInt("Year"));
                s.setMonth(rs.getInt("month"));
                totalSalaiesList.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                System.out.println(e.getStackTrace());
            }

        }

        return totalSalaiesList;
    }


    public List<Salary> getSalaryList(int limit, int offset) {
        List<Salary> salaryList = new ArrayList<>();
        ConnectionDAO.ConnectionDB();
        try {
            String query = "SELECT * FROM salery LIMIT ? OFFSET ?";

            PreparedStatement ps = ConnectionDAO.con.prepareStatement(query);
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getLong("id"));
                s.setFirstName(rs.getString("first_name"));
                s.setAmount(rs.getLong("amount"));
                s.setLastName(rs.getString("last_name"));
                s.setYear(rs.getInt("Year"));
                s.setMonth(rs.getInt("month"));

                salaryList.add(s);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return salaryList;
    }


    public List<Salary> getSalaryListByInput(String firstName, String lastName, int amount, int year, int month, long id, int limit, int offset) {
        List<Salary> salaryList = new ArrayList<>();
        PreparedStatement ps = null;
        try {
            String query = "SELECT * FROM salery";
            int i = 0;
            List<String> svm = new ArrayList<String>();

            if ((firstName != null && !firstName.isEmpty()) ||
                    (lastName != null && !lastName.isEmpty()) ||
                    (amount != -1) ||
                    (year != -1) ||
                    (month != -1) ||
                    (id != -1)) {

                query += " WHERE ";
            }
            if (firstName != null && !firstName.isEmpty()) {
                query += " first_name LIKE ?";
                svm.add("firstName");
//                    hasFilter = true;
                i++;

            }
            if (lastName != null && !lastName.isEmpty()) {
                if (i > 0) {
                    query += " AND ";
                }
                query += " last_name LIKE ?";
                svm.add("lastName");
                i++;
//                    hasFilter = true;
            }
            if (amount != -1) {
                if (i > 0) {
                    query += " AND ";
                }
                query += " amount = ?";
                svm.add("amount");
                i++;
//                    hasFilter = true;
            }
            if (year != -1) {
                if (i > 0) {
                    query += " AND ";
                }
                query += " year = ?";
                svm.add("year");
                i++;
//                    hasFilter = true;
            }
            if (month != -1) {
                if (i > 0) {
                    query += " AND ";
                }
                query += " month = ?";
                svm.add("month");
                i++;

//                    hasFilter = true;
            }
            if (id != -1) {
                if (i > 0) {
                    query += " AND ";
                }
                query += " id = ?";
                svm.add("id");
                i++;

//                    hasFilter = true;
            }

            // Add LIMIT and OFFSET to the query
            query += " LIMIT ? OFFSET ?";


            ps = ConnectionDAO.con.prepareStatement(query);
            int count = 1;

            if (firstName != null && !firstName.isEmpty()) {
                ps.setString(count, "%" + firstName + "%");
                ++count;
            }
            if (lastName != null && !lastName.isEmpty()) {
                ps.setString(count, "%" + lastName + "%");
                ++count;
//                    hasFilter = true;
            }
            if (amount != -1) {
                ps.setInt(count, amount);
                ++count;
//                    hasFilter = true;
            }
            if (year != -1) {
                ps.setInt(count, year);
                ++count;
//                    hasFilter = true;
            }
            if (month != -1) {
                ps.setInt(count, month);
                ++count;
//                    hasFilter = true;
            }
            if (id != -1) {
                ps.setLong(count, id);
                ++count;

            }
            int parameterIndex = 1;

            // Set the LIMIT and OFFSET values in the prepared statement
            ps.setInt(count, limit);
            ++count;
            ps.setInt(count, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getLong("id"));
                s.setFirstName(rs.getString("first_name"));
                s.setAmount(rs.getLong("amount"));
                s.setLastName(rs.getString("last_name"));
                s.setYear(rs.getInt("Year"));
                s.setMonth(rs.getInt("month"));

                salaryList.add(s);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return salaryList;
    }


    public void insertIntoSalaryList(Salary newSalary) {
        ConnectionDAO.ConnectionDB();
        try {

            String insertQuery = "INSERT INTO salery (amount) VALUES (?)";
            PreparedStatement insertStatement = ConnectionDAO.con.prepareStatement(insertQuery);
            ResultSet rs = insertStatement.executeQuery();
//            insertStatement.setDouble(1, Salary);
            insertStatement.executeUpdate();
            insertStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public void deleteSalary(int salaryToDelete) {
        ConnectionDAO.ConnectionDB();
        try {
            String deleteQuery = "DELETE FROM salery WHERE id = ?";
            PreparedStatement deleteStatement = ConnectionDAO.con.prepareStatement(deleteQuery);
//            ResultSet rs = deleteStatement.executeQuery();
            deleteStatement.setInt(1, salaryToDelete);
            deleteStatement.executeUpdate();
            deleteStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void updateSalary(String first_name, String last_name, Long amount, int year, int month, Long id) {
        ConnectionDAO.ConnectionDB();
        try {
            String updateQuery = "UPDATE salery SET first_name = ?, last_name = ?, amount = ?, year = ?, month = ? WHERE id = ?";
            PreparedStatement updateStatement = ConnectionDAO.con.prepareStatement(updateQuery);
            updateStatement.setString(1, first_name);
            updateStatement.setString(2, last_name);
            updateStatement.setLong(3, amount);
            updateStatement.setInt(4, year);
            updateStatement.setInt(5, month);
            updateStatement.setLong(6, id);
            updateStatement.executeUpdate();
            updateStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static int getCountList() {
        ConnectionDAO.ConnectionDB();
        int count = 0;
        try {
            String query = "SELECT COUNT(*) c FROM salery";

            PreparedStatement ps = ConnectionDAO.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("c");
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

//    public User getUserById(int userId) {
//        ConnectionDAO.ConnectionDB();
//        try {
//            String query = "SELECT * FROM salery WHERE id = ?";
//
//            PreparedStatement ps = ConnectionDAO.con.prepareStatement(query);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//
//            }
//
//            rs.close();
//            ps.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return ;
//    }
}





