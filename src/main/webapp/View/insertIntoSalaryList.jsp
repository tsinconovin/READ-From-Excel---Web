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
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Ubuntu', sans-serif;
            background-color: #f1f1f1;
        }

        section {
            text-align: center;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .input-section {
            margin-bottom: 10px;
        }


        .toolbar {
            with: 100%;
            top: -250px;
            display: flex;
            position: relative;
        }


    </style>


    <title>افزودن به لیست حقوق</title>
</head>
<body>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        Salary s = new Salary();
        double newSalary = Double.parseDouble(request.getParameter("salary"));
        s.setLastName(String.valueOf(request.getParameter("first_name")));
        s.setLastName(String.valueOf(request.getParameter("last_name")));
        s.setAmount(Long.parseLong(request.getParameter("amount")));
        s.setYear(Integer.parseInt(request.getParameter("year")));
        s.setMonth(Integer.parseInt(request.getParameter("month")));

        SalaryDAO sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
//    sdao.insertIntoSalaryList(newSalary);
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

<section>
    <form method="post">
        <label for="salary">Enter Salary:</label>
        <input type="text" id="salary" name="salary">
        <input type="first_name" value="نام" required>
        <input type="last_name" value="نام خانوادگی" required>
        <input type="amount" value="دریافتی" required>
        <input type="year" value="سال" required>
        <input type="" value="ماه" required>
        <button type="submit" formaction="">افزودن</button>
    </form>
</section>
</body>
</html>