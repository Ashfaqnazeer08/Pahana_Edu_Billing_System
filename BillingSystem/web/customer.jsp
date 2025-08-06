<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }

    // Fetch customers from DB
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Map<String, String>> customerList = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_edu", "root", "");
        stmt = conn.prepareStatement("SELECT * FROM customers ORDER BY id DESC");
        rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> customer = new HashMap<>();
            customer.put("name", rs.getString("name"));
            customer.put("email", rs.getString("email"));
            customer.put("phone", rs.getString("phone"));
            customer.put("address", rs.getString("address"));
            customerList.add(customer);
        }
    } catch (Exception e) {
        out.println("Error loading customers: " + e.getMessage());
    } finally {
        if (conn != null) {
            conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Customer Management</title>
        <link rel="stylesheet" href="css/style.css">

        <!-- FontAwesome & Bootstrap -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    </head>
    <body>
        <%-- Sidebar --%>
        <jsp:include page="sidebar.jsp" />

        <div class="main-content">

            <div class="page-header">
                <h2>Customers</h2>
                <%
                    String success = request.getParameter("success");
                    if ("1".equals(success)) {
                %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong> Customer added successfully.!</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                } else if ("0".equals(success)) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Failed to add customer. Please try again.</strong> 
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>



                <button class="btn-add" data-bs-toggle="modal" data-bs-target="#addCustomerModal">+ Add Customer</button>
            </div>

            <%-- Success/Error message placeholder --%>
            <div class="message" id="messageBox"></div>

            <%-- Table --%>
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>Name</th><th>Email</th><th>Phone</th><th>Address</th><th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, String> c : customerList) {%>
                    <tr>
                        <td><%= c.get("name")%></td>
                        <td><%= c.get("email")%></td>
                        <td><%= c.get("phone")%></td>
                        <td><%= c.get("address")%></td>
                        <td>
                            <a href="EditCustomerServlet?id=<%= c.get("id")%>" class="text-warning me-2">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="DeleteCustomerServlet?id=<%= c.get("id")%>" class="text-danger" onclick="return confirm('Are you sure you want to delete this customer?')">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <!-- Add Customer Modal -->
        <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="AddCustomerServlet" method="post" onsubmit="return validateCustomerForm()">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addCustomerModalLabel">Add New Customer</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="text" name="name" class="form-control mb-3" placeholder="Full Name" required />
                            <input type="email" name="email" class="form-control mb-3" placeholder="Email Address" required />
                            <input type="text" name="phone" class="form-control mb-3" placeholder="Phone Number" maxlength="10" required />
                            <textarea name="address" class="form-control mb-3" placeholder="Address" required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Add Customer</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="js/script.js"></script>
    </body>
</html>
