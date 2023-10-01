<%@ page import="ir.tsinco.DAO.SalaryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="ir.tsinco.DAO.ConnectionDAO" %>
<%@ page import="ir.tsinco.model.Salary" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ir.tsinco.service.validation" %>
<%@ page import="ir.tsinco.service.export" %>

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
            top: -250px;
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

        .pagination li.selected a {
            color: #99B2FF;
            font-weight: 700;
        }

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
            text-align: center;
        }

        .modal-content.center {
            background-color: #fefefe;
            border: 3px solid #6e6e6e;
            border-radius: 10px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            max-width: 500px; /* Set a maximum width for the modal content */
            padding: 20px; /* Add padding to create space around the content */
        }

        .center {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: auto; /* Change height to auto for dynamic content */
            margin-bottom: 10px;
        }

        .center label {
            margin-bottom: 10px; /* Add margin-bottom to create space below the label */
            display: inline-block;
            width: 80px; /* Adjust the width according to your preference */
            text-align: left;
            margin-right: 10px; /* Add margin-right to create space between the label and input */
        }

        .input-wrapper {
            display: flex;
            align-items: center;
            margin-bottom: 10px; /* Add margin-bottom to create space between the input wrappers */
        }

        .close {
            color: #aaaaaa;
            position: absolute;
            top: 10px;
            right: 10px; /* Change position to the top right corner */
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
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
    List<Salary> totalSalaiesList = new ArrayList<>();
    int limit = 10;
    int offset = 0;


    if (request.getMethod().equals("GET")) {
        sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
//        limit = validation.parsInt(request.getParameter("limit"));
//        offset = validation.parsInt(request.getParameter("offset"));

        limit = 10;
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

        limit = validation.parsInt(request.getParameter("limit"), 10);
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


        if (request.getParameter("sId") != null && request.getParameter("sId").equalsIgnoreCase("3")) {
            sdao = new SalaryDAO(ConnectionDAO.ConnectionDB());
//          String tid = request.getParameter("tId");
            totalSalaiesList = sdao.getTotalList();
            String filePath = "C:/Users/tsinco-pc10/Downloads/file.xlsx";
            export.exportToExcel(totalSalaiesList, filePath);

        }


    }


    int
            totalPages
            =
            (
                    int
                    )
                    Math
                            .
                            ceil
                                    (
                                            (
                                                    double
                                                    )
                                                    totalCount
                                                    /
                                                    limit
                                    );
    int
            currentPage
            =
            offset
                    /
                    limit
                    +
                    1;
    int
            previousPage
            =
            currentPage
                    >
                    1
                    ?
                    currentPage
                            -
                            1
                    :
                    1;
    int
            nextPage
            =
            currentPage
                    <
                    totalPages
                    ?
                    currentPage
                            +
                            1
                    :
                    totalPages;

%>


<section class="content">

    <div>
        <img src="./img/logo.png" width="29" height="35">
        <h1><%= "مشـاهده فهـرست حقـوق " %>
        </h1>
    </div>


    <form method="POST" id="frm1" url="showSalaryList">

        <tr>
            <input id="1" type="number" placeholder="شناسه" name="uid">
            <input id="2" name="firstName" type="text" placeholder="نام">
            <input id="3" name="lastName" type="text" placeholder="نام خانوادگی">
            <input id="4" name="amount" type="number" placeholder="دریافتی">
            <input id="5" name="year" type="number" placeholder="سال">
            <input id="6" name="month" type="number" placeholder="ماه">
        </tr>

        <div style="display: flex; justify-content: center; margin-top: 10px;">
            <button class="pretty-button-add" type="submit">
                <img src="./img/search.png" style="width: 30px; height: 30px;">
            </button>
        </div>
        <hr>
        <br>
        <div style="display: flex; justify-content: center;">

            <%--            <form method="get" action="/TestProjectInitializer_war_exploded/index.jsp" title=" بازگشت11 "  style="display: flex;">--%>
            <%--                <button class="pretty-button-add" type="submit"  title="بازگشت 1"--%>
            <%--                        style="display: flex; justify-content: center; align-items: center; margin-right: 10px; width: 40px; height: 40px;">--%>
            <%--                    <img src="./img/back-icon.svg" style="width: 30px; height: 30px;">--%>
            <%--                </button>--%>
            <%--            </form>--%>


            <form title="بازگشت " style="display: flex;">
                <button class="pretty-button-add" type="submit" title="بازگشت" onclick="window.history.back()"
                        style="display: flex; justify-content: center; align-items: center; margin-right: 10px; width: 40px; height: 40px;">
                    <img src="./img/back-icon.svg" style="width: 30px; height: 30px;">
                </button>
            </form>

            <%--            <form method="get" action="" onclick="" style="display: flex;">--%>
            <%--                <button class="pretty-button-add" type="submit" title=" .xlsx خروجی "--%>
            <%--                        style="display: flex; justify-content: center; align-items: center; margin-right: 10px; width: 40px; height: 40px;">--%>
            <%--                    <img src="./img/excel.png" style="width: 40px; height: 40px;">--%>
            <%--                </button>--%>
            <%--            </form>--%>


            <form method="get" action="" onsubmit="exportToExcel(event)" style="display: flex;">
                <button class="pretty-button-add" type="submit" title=".xlsx   فقط همین صفحه |  خروجی"
                        style="display: flex; justify-content: center; align-items: center; margin-right: 10px; width: 40px; height: 40px;">
                    <img src="./img/excel.png" style="width: 40px; height: 40px;">
                </button>
            </form>


            <button type="button" class="pretty-button-add" title=".xlsx   هـمــه |  خروجی"
                    onclick="exportToEXcelFunc()"
                    style="display: flex; justify-content: center; align-items: center; margin-right: 10px; width: 40px; height: 40px;">
                <img src="./img/excel_total.png" style="width: 30px; height: 30px;">
            </button>


            <form method="get" action="/TestProjectInitializer_war_exploded/print.jsp" onclick=""
                  style="display: flex;">
                <button class="pretty-button-add" type="submit" title=" پرینت"
                        style="display: flex; justify-content: center; align-items: center; margin-right: 10px; width: 40px; height: 40px;">
                    <img src="./img/printer.png" style="width: 30px; height: 30px;">
                </button>
            </form>
        </div>
    </form>

    <hr>

    <div class="center-table">
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

            <% for
            (
                    Salary
                            s
                    :
                    salaryList
            ) { %>
            <tr>
                <td><%= s
                        .
                        getId
                                (
                                ) %>
                </td>
                <td><%= s
                        .
                        getFirstName
                                (
                                ) %>
                </td>
                <td><%= s
                        .
                        getLastName
                                (
                                ) %>
                </td>
                <td><%= s
                        .
                        getAmount
                                (
                                ) %>
                </td>
                <td><%= s
                        .
                        getYear
                                (
                                ) %>
                </td>
                <td><%= s
                        .
                        getMonth
                                (
                                ) %>
                </td>
                <td>
                    <button id="inputBtn" type="button" onclick="editRow(<%=s.getId()%>, '<%= s.getFirstName() %>',
                            '<%= s.getLastName() %>', <%= s.getAmount() %>, '<%= s.getYear() %>', <%= s.getMonth() %>)">
                        <img src="img/edit.png" width="20" height="20">
                    </button>
                </td>
                <td>
                    <button type="button" onclick="deleteRow(<%=s.getId()%>)">
                        <img src="img/delete.png" width="20" height="20">
                    </button>
                </td>
            </tr>
            <% } %>


        </table>
        <hr>
        <form action="index.jsp">
            <div class="pagination" style="display: inline">
                <ul style=" list-style-type: none;">
                    <div style="display: inline-flex">

                        <% if
                        (
                                currentPage
                                        >
                                        1
                        ) { %>
                        <li><a href="?limit=<%= limit %>&offset=<%= (previousPage - 1) * limit %>">&laquo;</a></li>
                        <% } %>

                        <% for
                        (
                                int
                                i
                                =
                                1
                                ;
                                i
                                        <=
                                        totalPages
                                ;
                                i
                                        ++
                        ) { %>
                        <li style="margin: 0 .3rem" <% if
                        (
                                i
                                        ==
                                        currentPage
                        ) { %> class="active" <% } %>><a
                                href="?limit=<%= limit %>&offset=<%= (i - 1) * limit %>"><%= i %>
                        </a></li>
                        <% } %>

                        <% if
                        (
                                currentPage
                                        <
                                        totalPages
                        ) { %>
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
    function deleteRow(id) {
        // alert(id);
        if (confirm("آیا از حذف شناسه " + id + " اطمینان دارید؟")) {
            document.getElementById("tId").value = id;
            document.getElementById("sId").value = 1;
            document.getElementById("frm10").submit();
        }
    }


    function editRow(id, first_name, last_name, amount, year, month) {
        document.getElementById("employee_id").value = id;
        document.getElementById("modalSId").value = 2;
        document.getElementById("first_name").value = first_name;
        document.getElementById("last_name").value = last_name;
        document.getElementById("amount").value = amount;
        document.getElementById("year").value = year;
        document.getElementById("month").value = month;

        // Display the modal window
        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];
        modal.style.display = "block";

        // Close the modal when the user clicks on the close button
        span.onclick = function () {
            modal.style.display = "none";
        };

        // Close the modal when the user clicks outside of it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        };
    }

    function exportToEXcelFunc() {

        document.getElementById("sId").value = 3;
        document.getElementById("frm10").submit();

    }


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
</script>

<div id="myModal" class="modal" title="ویرایش اطلاعات">
    <div class="modal-content center">
        <span class="close">&times;</span>
        <!-- Modal content here -->
        <form id="modalForm" method="post" action="/TestProjectInitializer_war_exploded/showSalaryList.jsp">
            <input type="hidden" name="tId" id="modalTId">
            <input type="hidden" name="sId" id="modalSId">
            <div>
                <img src="./img/logo.png" width="29" height="35">
                <hr>
                <strong>ویرایش</strong>
                <hr>
            </div>
            <div class="center">
                <hr>
                <div class="input-wrapper">
                    <div class="input-label">
                        <label>شناسه</label>
                    </div>
                    <div class="input-field">
                        <input type="text" id="employee_id" name="employee_id" readonly="true">
                    </div>
                </div>
                <div class="input-wrapper">
                    <div class="input-label">
                        <label for="first_name">نام</label>
                    </div>
                    <div class="input-field">
                        <input type="text" id="first_name" name="first_name" required>
                    </div>
                </div>
                <div class="input-wrapper">
                    <div class="input-label">
                        <label for="last_name">نام خانوادگی</label>
                    </div>
                    <div class="input-field">
                        <input type="text" id="last_name" name="last_name" required>
                    </div>
                </div>
                <div class="input-wrapper">
                    <div class="input-label">
                        <label for="amount">دریافتی</label>
                    </div>
                    <div class="input-field">
                        <input type="text" id="amount" name="amount" required>
                    </div>
                </div>
                <div class="input-wrapper">
                    <div class="input-label">
                        <label for="year">سال</label>
                    </div>
                    <div class="input-field">
                        <input type="text" id="year" name="year" required>
                    </div>
                </div>
                <div class="input-wrapper">
                    <div class="input-label">
                        <label for="month">ماه</label>
                    </div>
                    <div class="input-field">
                        <input type="text" id="month" name="month" required>
                    </div>
                </div>
                <hr>
                <button class="pretty-button-add" type="submit" form="modalForm" name="submitEdit">
                    <img src="img/save.png" width="20" height="20">
                    <br>
                    ثـبـت
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
<script>
    function exportToExcel(event) {
        event.preventDefault(); // Prevent the form submission

        // Get the table element
        const table = document.querySelector('table');

        // Create a new workbook
        const workbook = XLSX.utils.book_new();

        // Convert the table to a worksheet
        const worksheet = XLSX.utils.table_to_sheet(table);

        // Add the worksheet to the workbook
        XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

        // Export the workbook to an Excel file
        XLSX.writeFile(workbook, 'exported_data.xlsx');
    }
</script>


</body>
</html>