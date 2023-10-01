<%@ page import="ir.tsinco.DAO.SalaryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="ir.tsinco.DAO.ConnectionDAO" %>
<%@ page import="ir.tsinco.model.Salary" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ir.tsinco.service.validation" %>
<%--
  Created by IntelliJ IDEA.
  User: tsinco-pc19
  Date: 9/6/2023
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>لـیست حقـوق</title>
    <style>

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Ubuntu', sans-serif;
            background-color: #f1f1f1;
        }

        .toolbar {
            with: 100%;
            top: 0px;
            display: flex;
            position: relative;
        }


        .content {
            text-align: center;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }


        button {
            vertical-align: middle;
            width: 50%;
            height: auto;
        }

    </style>
</head>
<body>
<form method="post" action="/TestProjectInitializer_war_exploded/showSalaryList.jsp" id="frm10">
    <input type="hidden" name="tId" id="tId">
    <input type="hidden" name="sId" id="sId">
</form>


<%
    //    int totalCount = salaryList.size();
    int totalCount = 0;
    SalaryDAO sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());


    System.out.println(request.getMethod());
    List<Salary> salaryList = new ArrayList<>();
    int limit = 34;
    int offset = 0;

    if (request.getMethod().equals("GET")) {
        sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
//        limit = validation.parsInt(request.getParameter("limit"));
//        offset = validation.parsInt(request.getParameter("offset"));

        limit = 34;
        offset = 0;
        totalCount = SalaryDAO.getCountList();

        salaryList = sdao.getSalaryList(limit, offset);


    } else if (request.getMethod().equals("POST")) {
        sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
        String fn = request.getParameter("firstName");
        String ln = request.getParameter("lastName");
        String am = request.getParameter("amount");
        String ye = request.getParameter("year");
        String mo = request.getParameter("month");
        totalCount = SalaryDAO.getCountList();

        limit = validation.parsInt(request.getParameter("limit"), 34);
        offset = validation.parsInt(request.getParameter("offset"), 0);


        salaryList = sdao.getSalaryListByInput(
                fn,
                ln,
                validation.parsInt(am),
                validation.parsInt(ye),
                validation.parsInt(mo),
                validation.parsLong(request.getParameter("uid")),
                limit,
                offset
        );


        if (request.getParameter("sId") != null && request.getParameter("sId").equalsIgnoreCase("1")) {
            sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
            String tid = request.getParameter("tId");
            sdao.deleteSalary(validation.parsInt(tid));

        }


        if (request.getParameter("sId") != null && request.getParameter("sId").equalsIgnoreCase("2")) {
            Salary s = new Salary();
            sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
            String tid = request.getParameter("tId");
            s.setFirstName(String.valueOf(request.getParameter("first_name")));
            s.setLastName(String.valueOf(request.getParameter("last_name")));
            s.setAmount(Long.parseLong(request.getParameter("amount")));
            s.setYear(validation.parsInt(request.getParameter("year")));
            s.setMonth(validation.parsInt(request.getParameter("month")));
            s.setId(validation.parsInt(request.getParameter("employee_id")));
            String newSalary = request.getParameter("salary");

//            sdao.updateSalary("first_name", "last_name", amount, year, month, id);
            sdao.updateSalary(
                    s.getFirstName(),
                    s.getLastName(),
                    s.getAmount(),
                    s.getYear(),
                    s.getMonth(),
                    s.getId());


        }


    }


    int totalPages = (int) Math.ceil((double) totalCount / limit);
    int currentPage = offset / limit + 1;
    int previousPage = currentPage > 1 ? currentPage - 1 : 1;
    int nextPage = currentPage < totalPages ? currentPage + 1 : totalPages;

%>


<section class="content">

    <div>
        <img src="./img/logo.png" width="29" height="35">
        <h1>
            <%= "پرینت  فهـرست حقـوق " %>
        </h1>

        <div class="toolbar">
            <button onclick="window.history.back()"> <img src="./img/back-icon.svg" style="width: 30px; height: 30px;"></button>
            <button onclick="window.print()"><img src="./img/printer.png" style="width: 30px; height: 30px;"></button>
        </div>
    </div>

    <form method="POST"   id="frm1" url="showSalaryList" style="width: 100%; box-sizing: border-box;">

    </form>

    <hr>

    <div class="center-table" style="height: 21cm; width: 19cm">
        <table>

            <tr>
                <td>شناسه</td>
                <td>نام</td>
                <td>نام خانوادگی</td>
                <td>دریافتی</td>
                <td>سال</td>
                <td>ماه</td>
                <td></td>
            </tr>

            <% for (Salary s : salaryList) { %>
            <tr>
                <td><%= s.getId() %>
                </td>
                <td><%= s.getFirstName() %>
                </td>
                <td><%= s.getLastName() %>
                </td>
                <td><%= s.getAmount() %>
                </td>
                <td><%= s.getYear() %>
                </td>
                <td><%= s.getMonth() %>
                </td>
            </tr>
            <% } %>


        </table>
        <hr>
        <form action="index.jsp">
            <div class="pagination" style="display: inline">
                <ul style=" list-style-type: none;">
                    <div style="display: inline-flex">

                        <% if (currentPage > 1) { %>
                        <li><a href="?limit=<%= limit %>&offset=<%= (previousPage - 1) * limit %>">&laquo;</a></li>
                        <% } %>

                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <li style="margin: 0 .3rem" <% if (i == currentPage) { %> class="active" <% } %>><a
                                href="?limit=<%= limit %>&offset=<%= (i - 1) * limit %>"><%= i %>
                        </a></li>
                        <% } %>

                        <% if (currentPage < totalPages) { %>
                        <li><a href="?limit=<%= limit %>&offset=<%= (nextPage - 1) * limit %>">&raquo;</a></li>
                        <% } %>
                    </div>
                </ul>
            </div>
        </form>
        <hr>
    </div>

</section>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    $(document).ready(function () {
        // Submit the form when the pagination link is clicked
        $(".pagination a").on("click", function (event) {
            event.preventDefault();
            var url = $(this).attr("href");
            $("#frm1").attr("action", url);
            $("#frm1").submit();
        });
    });

</script>
</body>
</html>