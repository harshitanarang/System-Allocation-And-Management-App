<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/systemallocation";
    String user = "root";
    String pass = "Harshi15@2003"; 
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header h1 {
            color: #2c3e50;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: #666;
            font-size: 1.1rem;
        }

        .section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .section:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .section h2 {
            color: #2c3e50;
            font-size: 1.8rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
        }

        .section h2 i {
            color: #667eea;
            font-size: 1.5rem;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            font-size: 0.95rem;
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 18px 15px;
            font-weight: 600;
            text-align: left;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
            transition: background-color 0.2s ease;
        }

        tr:hover td {
            background-color: #f8f9ff;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #764ba2, #667eea);
        }

        .btn:active {
            transform: translateY(0);
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .urgency-high {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
        }

        .urgency-medium {
            background: linear-gradient(135deg, #ffa726, #fb8c00);
            color: white;
        }

        .urgency-low {
            background: linear-gradient(135deg, #66bb6a, #43a047);
            color: white;
        }

        .role-badge {
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .role-admin {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .role-employee {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #666;
            font-size: 1rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .error-message {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin: 10px 0;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .section {
                padding: 20px;
            }

            .section h2 {
                font-size: 1.5rem;
            }

            th, td {
                padding: 12px 10px;
                font-size: 0.85rem;
            }

            .btn {
                padding: 8px 15px;
                font-size: 0.8rem;
            }
        }

        .fade-in {
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header fade-in">
            <h1><i class="fas fa-cogs"></i> System Allocation Dashboard</h1>
            <p>Comprehensive management system for user registration, system allocation, and complaint tracking</p>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-grid fade-in">
            <div class="stat-card">
                <div class="stat-number">
                    <%
                        int userCount = 0;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(url, user, pass);
                            st = con.createStatement();
                            rs = st.executeQuery("SELECT COUNT(*) as count FROM users");
                            if(rs.next()) {
                                userCount = rs.getInt("count");
                            }
                            rs.close();
                        } catch(Exception e) {
                            userCount = 0;
                        }
                    %>
                    <%= userCount %>
                </div>
                <div class="stat-label">Total Users</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-number">
                    <%
                        int allocationCount = 0;
                        try {
                            st = con.createStatement();
                            rs = st.executeQuery("SELECT COUNT(*) as count FROM employee_allocation");
                            if(rs.next()) {
                                allocationCount = rs.getInt("count");
                            }
                            rs.close();
                        } catch(Exception e) {
                            allocationCount = 0;
                        }
                    %>
                    <%= allocationCount %>
                </div>
                <div class="stat-label">System Allocations</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-number">
                    <%
                        int complaintCount = 0;
                        try {
                            st = con.createStatement();
                            rs = st.executeQuery("SELECT COUNT(*) as count FROM complaints");
                            if(rs.next()) {
                                complaintCount = rs.getInt("count");
                            }
                            rs.close();
                        } catch(Exception e) {
                            complaintCount = 0;
                        }
                    %>
                    <%= complaintCount %>
                </div>
                <div class="stat-label">Active Complaints</div>
            </div>
        </div>

        <!-- Registered Users Section -->
        <div class="section fade-in">
            <h2><i class="fas fa-users"></i> Registered Users</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Role</th>
                            <th>Designation</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                st = con.createStatement();
                                rs = st.executeQuery("SELECT * FROM users");
                                while(rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("password") %></td>
                            <td>
                                <span class="role-badge <%= rs.getString("role").equals("admin") ? "role-admin" : "role-employee" %>">
                                    <%= rs.getString("role") %>
                                </span>
                            </td>
                            <td><%= rs.getString("designation") %></td>
                            <td>
                                <form action="admin.html" method="get" style="margin:0;">
                                    <input type="hidden" name="userid" value="<%= rs.getInt("id") %>">
                                    <input type="submit" value="Add Allocation" class="btn">
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                            } catch(Exception e) {
                        %>
                        <tr>
                            <td colspan="6" class="error-message">Error fetching users: <%= e.getMessage() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Allocated Systems Section -->
        <div class="section fade-in">
            <h2><i class="fas fa-desktop"></i> Allocated Systems</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Employee Name</th>
                            <th>Designation</th>
                            <th>System Number</th>
                            <th>RAM</th>
                            <th>Processor</th>
                            <th>Accessories</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                st = con.createStatement();
                                rs = st.executeQuery("SELECT * FROM employee_allocation");
                                while(rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("employee_name") %></td>
                            <td><%= rs.getString("designation") %></td>
                            <td><strong><%= rs.getString("system_number") %></strong></td>
                            <td><%= rs.getString("ram") %></td>
                            <td><%= rs.getString("processor") %></td>
                            <td><%= rs.getString("accessories") %></td>
                        </tr>
                        <%
                                }
                                rs.close();
                            } catch(Exception e) {
                        %>
                        <tr>
                            <td colspan="7" class="error-message">Error fetching allocations: <%= e.getMessage() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Complaints Section -->
        <div class="section fade-in">
            <h2><i class="fas fa-exclamation-triangle"></i> System Complaints</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Complaint ID</th>
                            <th>Employee ID</th>
                            <th>System Number</th>
                            <th>Problem Type</th>
                            <th>Description</th>
                            <th>Urgency</th>
                            <th>Created At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                st = con.createStatement();
                                rs = st.executeQuery("SELECT * FROM complaints ORDER BY created_at DESC");
                                while(rs.next()) {
                                    String urgency = rs.getString("urgency").toLowerCase();
                                    String urgencyClass = "urgency-" + urgency;
                        %>
                        <tr>
                            <td><%= rs.getInt("complaint_id") %></td>
                            <td><%= rs.getInt("employee_id") %></td>
                            <td><strong><%= rs.getString("system_number") %></strong></td>
                            <td><%= rs.getString("problem_type") %></td>
                            <td><%= rs.getString("description") %></td>
                            <td>
                                <span class="status-badge <%= urgencyClass %>">
                                    <%= rs.getString("urgency") %>
                                </span>
                            </td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                        </tr>
                        <%
                                }
                                rs.close();
                                con.close();
                            } catch(Exception e) {
                        %>
                        <tr>
                            <td colspan="7" class="error-message">Error fetching complaints: <%= e.getMessage() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
