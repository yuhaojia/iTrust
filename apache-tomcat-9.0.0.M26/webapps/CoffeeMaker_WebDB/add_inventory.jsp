<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="edu.ncsu.csc326.coffeemaker.*, edu.ncsu.csc326.coffeemaker.exceptions.*" %>
<%@ page import="edu.ncsu.csc326.coffeemaker.db.InventoryDB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>CoffeeMaker - Add Inventory</title>
    <%@include file="head.jsp" %>
</head>
<body>
<div align=center class="font1">
    <h1>CoffeeMaker</h1>
    <h3>Add a Inventory</h3>
    <%
        String coffee = request.getParameter("amtCoffee");
        String milk = request.getParameter("amtMilk");
        String sugar = request.getParameter("amtSugar");
        String chocolate = request.getParameter("amtChocolate");

        CoffeeMaker cm = (CoffeeMaker)session.getAttribute("cm");

        if (coffee != null && !"null".equals(coffee)) {
                int amtCoffee = Integer.parseInt(coffee);
                int amtMilk = Integer.parseInt(milk);
                int amtSugar = Integer.parseInt(sugar);
                int amtChocolate = Integer.parseInt(chocolate);
                if (amtCoffee >= 0 && amtMilk >= 0 && amtSugar >= 0 && amtChocolate >= 0) {
                    InventoryDB.addInventory(amtCoffee, amtMilk, amtSugar, amtChocolate);
                    %>
                    <span class="font_success"><%=  "Successfully added." %> </span><br>
                    <%
                }
                else {
                    out.println("<span class=\"font_failure\">" + "Could not be added.</span><br>");
                }
        }
     %>
    <br>
    <form method="post" action="add_inventory.jsp">
        <table>
            <tr>
                <td><input type="text" name="amtCoffee"></td><td><span class="font1">Units Coffee</span></td>
            </tr>
            <tr>
                <td><input type="text" name="amtMilk"></td><td><span class="font1">Units Milk</span></td>
            </tr>
            <tr>
                <td><input type="text" name="amtSugar"></td><td><span class="font1">Units Sugar</span></td>
            </tr>
            <tr>
                <td><input type="text" name="amtChocolate"></td><td><span class="font1">Units Chocolate</span></td>
            </tr>
        </table>
        <input type="submit" name="submit" value="Add Inventory!">
    </form>
    <br>
    <br>
    <a href="index.jsp"><span class="font1">Back to CoffeeMaker Menu</span></a>
</div>
</body>
</html>
