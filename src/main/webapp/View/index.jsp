<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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

    h1 {
      font-family: 'Scheherazade', serif;
      font-size: 24px;
      font-weight: bold;
    }
    img {
      vertical-align: middle;
    }

    button {
      vertical-align: middle;
      width: 50%;
      height: auto;
    }


  </style>


<%--  <img src  = "../java/ir.tsinco.img/logo.png">--%>
  <title>سامانه حقوق تدبیر سیستم</title>
</head>
<body>



<br/>

<section>
  <img src="./img/logo.png" width="29" height="35">
  <h1><%= "به سامانه حقوق تدبیر سیستم خوش آمدید" %></h1>

  <form method="get" action="/TestProjectInitializer_war_exploded/showSalaryList.jsp" onclick="">
    <input name="username" placeholder="نام کاربری">
<%--    <img src="./img/list.png" width="25" height="25">--%>
  </form>
  <br>
  <form method="get" action="/TestProjectInitializer_war_exploded/showSalaryList.jsp" onclick="">
    <input name="password" placeholder="رمز">
<%--    <img src="./img/list.png" width="25" height="25">--%>
  </form>
  <br>
  <form method="get" action="/TestProjectInitializer_war_exploded/showSalaryList.jsp" onclick="">
    <button class="pretty-button-add" type="submit" >ورود</button>
  </form>



</section>

</body>
</html>


