<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    </head>
    <body>
        <div class="sidebar">
            <div class="logo">
                <img src="images/logo.jpg" alt="Logo">
            </div>
            <ul class="menu">
                <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                <li class="has-submenu">
                    <a href="#"><i class="fas fa-user"></i> Customers <i class="fas fa-chevron-down toggle-icon"></i></a>
                    <ul class="submenu">
                        <li><a href="#">Add Customer</a></li>
                        <li><a href="#">Manage Customers</a></li>
                    </ul>
                </li>
                <li class="has-submenu">
                    <a href="#"><i class="fas fa-box"></i> Items <i class="fas fa-chevron-down toggle-icon"></i></a>
                    <ul class="submenu">
                        <li><a href="#">Add Item</a></li>
                        <li><a href="#">View Items</a></li>
                    </ul>
                </li>
                <li><a href="#"><i class="fas fa-file-invoice"></i> Billing</a></li>
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <h1>Welcome, <%= username%>!</h1>

            <div class="cards">
                <div class="card">
                    <h2 id="billCount">0</h2>
                    <p>Total Bills</p>
                </div>
                <div class="card">
                    <h2 id="customerCount">0</h2>
                    <p>Total Customers</p>
                </div>
                <div class="card">
                    <h2 id="itemCount">0</h2>
                    <p>Total Items</p>
                </div>
            </div>

            <div class="description">
                <h3>About Our Shop</h3>
                <p>
                    Pahana Edu is a trusted educational and stationery shop that caters to the diverse needs of students, teachers, and schools. With a strong commitment to quality and affordability, the shop offers a wide range of educational materials, textbooks, stationery items, and classroom supplies all under one roof.
                </p>
                <p>
                    Known for its reliable customer service and well-organized stock, Pahana Edu has become a go-to destination for parents and institutions seeking essential academic resources. Whether it's school book lists, exam materials, or everyday stationery, Pahana Edu ensures that customers receive the right products at the right time, contributing positively to the learning journey of thousands.
                        </p>
            </div>
        </div>

        <script src="js/script.js"></script>
    </body>
</html>
