//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package edu.ncsu.csc326.coffeemaker.db;

import edu.ncsu.csc326.coffeemaker.Inventory;
import edu.ncsu.csc326.coffeemaker.Recipe;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InventoryDB {
    public InventoryDB() {
    }

    public static boolean addInventory(Inventory i, int coffee, int milk, int sugar, int chocolate) {
        DBConnection db = new DBConnection();
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean inventoryAdded = false;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement("UPDATE inventory SET coffee=?, milk=?, sugar=?, chocolate=?");
            stmt.setInt(1, i.getCoffee() + coffee);
            stmt.setInt(2, i.getMilk() + milk);
            stmt.setInt(3, i.getSugar() + sugar);
            stmt.setInt(4, i.getChocolate() + chocolate);
            stmt.executeUpdate();
            inventoryAdded = true;
        } catch (SQLException var11) {
            var11.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn, stmt);
        }

        return inventoryAdded;
    }

    public static boolean useInventory(Inventory i, int coffee, int milk, int sugar, int chocolate) {
        DBConnection db = new DBConnection();
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean inventoryUsed = false;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement("UPDATE inventory SET coffee=?, milk=?, sugar=?, chocolate=?");
            stmt.setInt(1, i.getCoffee() - coffee);
            stmt.setInt(2, i.getMilk() - milk);
            stmt.setInt(3, i.getSugar() - sugar);
            stmt.setInt(4, i.getChocolate() - chocolate);
            stmt.executeUpdate();
            inventoryUsed = true;
        } catch (SQLException var11) {
            var11.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn, stmt);
        }

        return inventoryUsed;
    }

    public static Inventory checkInventory() {
        DBConnection db = new DBConnection();
        Connection conn = null;
        PreparedStatement stmt = null;
        Inventory i = null;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM inventory);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                i = new Inventory();
                i.setCoffee(rs.get("coffee"));
                i.setMilk(rs.get("milk"));
                i.setSugar(rs.get("sugar"));
                i.addChocolate(rs.get("chocolate"));
            }
        } catch (SQLException var9) {
            var9.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn, stmt);
        }

        return r;
        }

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement("");
            stmt.setInt(1, i.getCoffee() + coffee);
            stmt.setInt(2, i.getMilk() + milk);
            stmt.setInt(3, i.getSugar() + sugar);
            stmt.setInt(4, i.getChocolate() + chocolate);
            stmt.executeUpdate();
            inventoryAdded = true;
        } catch (SQLException var11) {
            var11.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn, stmt);
        }

        return inventoryAdded;
    }
}
