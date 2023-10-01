<%@ page import="ir.tsinco.DAO.SalaryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="ir.tsinco.DAO.ConnectionDAO" %>
<%@ page import="ir.tsinco.model.Salary" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: tsinco-pc19
  Date: 9/6/2023
  Time: 9:34 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>افزودن به لیست حقوق</title>

    <style>

        .toolbar {
            with: 100%;
            top: -250px;
            display: flex;
            position: relative;
        }


    </style>


</head>
<body>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        double newSalary = Double.parseDouble(request.getParameter("salary"));

        SalaryDAO sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
        sdao.insertIntoSalaryList(newSalary);
    }


%>

<section class="toolbar">
    <form method="get" action="/TestProjectInitializer_war_exploded/index.jsp" onclick="">
        <button width="120" height="120" class="pretty-button-add" type="submit"
                style="display: flex; justify-content: center; align-items: center;">
            <img src="./img/back-icon.svg" width="20" height="10">
        </button>
    </form>
</section>


<form method="post">
    <label for="salary">Enter Salary:</label>
    <input type="text" id="salary" name="salary" required>
    <input type="submit" value="Add Salary">
</form>
</body>
</html>