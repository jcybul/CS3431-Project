

import java.sql.*;
import java.util.Scanner;
import java.util.concurrent.Callable;

import static java.lang.System.exit;

public class pf37 {


    public static void main(String[] args) {

        String username = "";
        String password = "";


        if (args.length < 2 ) {
            System.out.println(" Must provide username and password");
        }

        if (args.length == 2) {

            System.out.println("1 - Report Patient Information");
            System.out.println("2 - Report Primary Care Physician Information");
            System.out.println("3 - Report Operation Information");
            System.out.println("4 - Update Patient Blood Type ");
            System.out.println("5 - Exit Program");

        }

        if (args.length == 3) {
            username = args[0];

            password = args[1];


            System.out.println("-------Oracle JDBC COnnection Testing ---------");
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");

            } catch (ClassNotFoundException e) {
                System.out.println("Where is your Oracle JDBC Driver?");
                e.printStackTrace();
                return;
            }


            int option = Integer.parseInt(args[2]);

            if (option > 0 && option < 6) {

                Scanner scan = new Scanner(System.in);
                Connection connection = null;
                try {
                    connection = DriverManager.getConnection(
                            "jdbc:oracle:thin:@csorcl.cs.wpi.edu:1521:orcl", username, password);
                } catch (SQLException e) {
                    System.out.println("Connection Failed! Check output console");
                    e.printStackTrace();
                    return;
                }

                switch (option) {

                    case 1:
                        System.out.println("Enter Patient's Healthcare ID: ");

                        int healthcareid = scan.nextInt();

                        try {

                            String query1 = "SELECT * FROM PATIENT where HEALTHCAREID = ? ";
                            PreparedStatement stmt = connection.prepareStatement(query1);
                            stmt.setInt(1, healthcareid);

                            ResultSet rset = stmt.executeQuery();

                            int ID = 0;
                            String name = "";
                            String lastname = "";
                            String city = "";
                            String state = "";
                            String bdate = "";
                            String btype = "";


                            while (rset.next()) {
                                ID = rset.getInt("healthcareid");
                                name = rset.getString("firstname");
                                lastname = rset.getString("lastname");
                                state = rset.getString("state");
                                city = rset.getString("city");
                                bdate = rset.getDate("birthdate").toString();
                                btype = rset.getString("bloodtype");

                                System.out.print("Patient Information:\n" +
                                        "Healthcare ID: " + ID + "\n" +
                                        "First Name: " + name + "\n" +
                                        "Last Name: " + lastname + "\n" +
                                        "City: " + city + "\n" +
                                        "State: " + state + "\n" +
                                        "Birth Date: " + bdate + "\n" +
                                        "Blood Type: " + btype);
                            }

                            rset.close();
                            stmt.close();

                        } catch (SQLException e) {
                            System.out.println("Get Data Failed! Check output console");
                            e.printStackTrace();
                            return;
                        }


                        break;


                    case 2:

                        System.out.println("Enter Primary Care Physician ID: ");

                        int phiscianID = scan.nextInt();



                        try {

                            String query1 = "SELECT * FROM PCP join DOCTOR D on PCP.PHYSICIANID = D.PHYSICIANID where D.PHYSICIANID = ? ";
                            PreparedStatement stmt = connection.prepareStatement(query1);
                            stmt.setInt(1, phiscianID);

                            ResultSet rset = stmt.executeQuery();

                            int pID = 0;
                            String name = "";
                            String lastname = "";
                            String specialty = "";
                            String medf = "";

                            while (rset.next()) {
                                pID = rset.getInt("physicianID");
                                name = rset.getString("firstname");
                                lastname = rset.getString("lastname");
                                specialty = rset.getString("specialty");
                                medf = rset.getString("medicalfacility");

                                System.out.print("Patient Information:\n" +
                                        "Full Name: " + name + " " + lastname + "\n" +
                                        "Physician ID : " + pID + "\n" +
                                        "Specialty: " + specialty + "\n" +
                                        "Medical Facility: " + medf);
                            }

                            rset.close();
                            stmt.close();
                        } catch (SQLException e) {
                            System.out.println("Get Data Failed! Check output console");
                            e.printStackTrace();
                            return;
                        }

                        break;


                    case 3:

                        System.out.println("Enter Operation Invoice Number: ");

                        int opnum = scan.nextInt();

                        int iNum = 0;
                        String oDate = "";
                        String SurgeonName = "";
                        String Certified = "";
                        String Pname = "";
                        String btype = "";
                        String city = "";
                        String state = "";



                        /// get info on patient and operation
                        try {

                            String query1 = "SELECT * FROM SURGEON join OPERATION O on SURGEON.PHYSICIANID = O.PHYSICIANID join DOCTOR D on SURGEON.PHYSICIANID = D.PHYSICIANID and SURGEON.ROLE = D.ROLE where O.INVOICENUMBER = ? ";
                            PreparedStatement stmt = connection.prepareStatement(query1);
                            stmt.setInt(1, opnum);

                            ResultSet rset = stmt.executeQuery();



                            while (rset.next()) {
                                SurgeonName = rset.getString("firstname") + " " + rset.getString("lastname");
                                Certified  =  rset.getString("boardcertified");
                            }

                            rset.close();
                            stmt.close();
                        } catch (SQLException e) {
                            System.out.println("Get Data Failed! Check output console");
                            e.printStackTrace();
                            return;
                        }

                        try {

                            String query1 = "SELECT * FROM OPERATION join PATIENT P on OPERATION.HEALTHCAREID = P.HEALTHCAREID where OPERATION.INVOICENUMBER = ? ";
                            PreparedStatement stmt = connection.prepareStatement(query1);
                            stmt.setInt(1, opnum);

                            ResultSet rset = stmt.executeQuery();



                            while (rset.next()) {
                                iNum = rset.getInt("invoiceNumber");
                                oDate = rset.getDate("operationdate").toString();
                                Pname = rset.getString("firstname") + " " + rset.getString("lastname");
                                state = rset.getString("state");
                                city = rset.getString("city");
                                btype = rset.getString("bloodtype");
                            }

                            rset.close();
                            stmt.close();
                        } catch (SQLException e) {
                            System.out.println("Get Data Failed! Check output console");
                            e.printStackTrace();
                            return;
                        }

                        System.out.print("Patient Information:\n" +
                                "Invoice Number: " + iNum + "\n" +
                                "Operation Date: " + oDate + "\n" +
                                "Surgeon Full Name: " + SurgeonName + "\n" +
                                "Board Certified?: " + Certified + "\n" +
                                "Patient Full Name: " + Pname + "\n" +
                                "Blood Type: " + btype + "\n" +
                                "City: " + city + "\n" +
                                "State: " + state);

                        break;



                    case 4:

                        System.out.println("Enter Patient's Healthcare ID: ");

                        int hid = scan.nextInt();

                        System.out.println("Enter the Updated Blood Type: ");

                        String bloodtype = scan.next();


                        try {

                            String query1 = "UPDATE PATIENT set BLOODTYPE = ? where PHYSICIANID= ? ";
                            PreparedStatement stmt = connection.prepareStatement(query1);
                            stmt.setInt(2, hid);
                            stmt.setString(1, bloodtype);
                            stmt.executeUpdate();

                        } catch (SQLException e) {
                            System.out.println("Get Data Failed! Check output console");
                            e.printStackTrace();
                            return;
                        }

                        break;


                    case 5:

                        exit(0);

                        break;

                }
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
            else{

                System.out.println(" Invalid option, run with with only username and password to view options.");
            }

        }



    }


}
