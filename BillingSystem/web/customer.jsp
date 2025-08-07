<%@ page session="true" %> 
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<% if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }

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
            customer.put("id", rs.getString("id"));
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

<!DOCTYPE html><html>
    <head>
        <title>Customer Management</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" /><div class="main-content">
            <div class="page-header">
                <h2>Customers</h2>
                <%                String success = request.getParameter("success");
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

            <div class="message" id="messageBox"></div>

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
                            <a href="#" class="text-warning me-2" onclick="toggleEdit('<%= c.get("id")%>')">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="DeleteCustomerServlet?id=<%= c.get("id")%>" class="text-danger" onclick="return confirm('Are you sure you want to delete this customer?')">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                    <tr id="editRow-<%= c.get("id")%>" style="display: none;">
                        <td colspan="5">
                            <form action="EditCustomerServlet" method="post" class="edit-form">
                                <input type="hidden" name="id" value="<%= c.get("id")%>" />
                                <div class="row g-2">
                                    <div class="col-md-3"><input type="text" name="name" value="<%= c.get("name")%>" required class="form-control" /></div>
                                    <div class="col-md-3"><input type="email" name="email" value="<%= c.get("email")%>" required class="form-control" /></div>
                                    <div class="col-md-2"><input type="text" name="phone" value="<%= c.get("phone")%>" maxlength="10" required class="form-control" /></div>
                                    <div class="col-md-3"><input type="text" name="address" value="<%= c.get("address")%>" required class="form-control" /></div>
                                    <div class="col-md-1">
                                        <button type="submit" class="btn btn-success btn-sm">Update</button>
                                    </div>
                                </div>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

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

        <script>
            function toggleEdit(id) {
                const row = document.getElementById('editRow-' + id);
                row.style.display = row.style.display === 'none' ? '' : 'none';
            }

            function validateCustomerForm() {
                const phone = document.querySelector('input[name="phone"]').value;
                const email = document.querySelector('input[name="email"]').value;
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                if (!/^[0-9]{10}$/.test(phone)) {
                    alert("Phone number must be 10 digits.");
                    return false;
                }
                if (!emailPattern.test(email)) {
                    alert("Invalid email address.");
                    return false;
                }
                return true;
            }
        </script>
    </body>

</html>