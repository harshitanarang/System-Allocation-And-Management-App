<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("username") == null) {
        response.sendRedirect("index.html");
        return;
    }

    String username = (String) sess.getAttribute("username");

    // Variables to hold system details
    String systemNumber = null, ram = null, accessories = null, processor = null;
    int employeeId = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/systemallocation", "root", "Harshi15@2003");

        PreparedStatement ps = con.prepareStatement(
            "SELECT id, system_number, ram, processor, accessories " +
            "FROM employee_allocation WHERE LOWER(employee_name)=LOWER(?)");
        ps.setString(1, username.trim());

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            employeeId = rs.getInt("id");
            systemNumber = rs.getString("system_number");
            ram = rs.getString("ram");
            processor = rs.getString("processor");
            accessories = rs.getString("accessories");
        }

        // Save values into session
        sess.setAttribute("employeeId", employeeId);
        sess.setAttribute("systemNumber", systemNumber);

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
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
            max-width: 1200px;
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
            animation: fadeInDown 0.8s ease-out;
        }

        .header h2 {
            color: #2c3e50;
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 15px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .user-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #764ba2, #667eea);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            box-shadow: 0 5px 20px rgba(255, 107, 107, 0.3);
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #ee5a24, #ff6b6b);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
        }

        .section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInUp 0.8s ease-out;
        }

        .section h3 {
            color: #2c3e50;
            font-size: 1.8rem;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
        }

        .section h3 i {
            color: #667eea;
            font-size: 1.5rem;
        }

        .system-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .detail-card {
            background: rgba(102, 126, 234, 0.05);
            border-left: 5px solid #667eea;
            padding: 20px;
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .detail-card:hover {
            transform: translateX(10px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .detail-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }

        .detail-value {
            font-size: 1.1rem;
            color: #555;
            font-weight: 500;
        }

        .no-allocation {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.1rem;
            background: rgba(255, 193, 7, 0.1);
            border: 2px dashed #ffc107;
            border-radius: 15px;
        }

        .no-allocation i {
            font-size: 3rem;
            color: #ffc107;
            margin-bottom: 15px;
            display: block;
        }

        .form-container {
            animation: fadeIn 0.5s ease-in-out;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
        }

        .form-control:read-only {
            background: rgba(102, 126, 234, 0.05);
            color: #666;
        }

        .radio-group {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 8px;
        }

        .radio-item {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .radio-item input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #667eea;
        }

        .radio-item label {
            margin-bottom: 0 !important;
            cursor: pointer;
            font-weight: 500;
        }

        .submit-btn {
            background: linear-gradient(135deg, #28a745, #20c997);
            padding: 15px 30px;
            font-size: 1.1rem;
            border-radius: 30px;
            box-shadow: 0 5px 20px rgba(40, 167, 69, 0.3);
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #20c997, #28a745);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
        }

        .hidden {
            display: none;
        }

        .error-message {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin: 15px 0;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .header {
                padding: 25px;
            }

            .header h2 {
                font-size: 1.8rem;
            }

            .section {
                padding: 25px 20px;
            }

            .system-details {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                justify-content: center;
                max-width: 300px;
            }

            .radio-group {
                flex-direction: column;
                gap: 15px;
            }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
    <script>
        function showComplaintForm() {
            document.getElementById("complaintForm").classList.remove("hidden");
            document.getElementById("allocationDetails").classList.add("hidden");
            
            // Smooth scroll to form
            document.getElementById("complaintForm").scrollIntoView({ 
                behavior: 'smooth', 
                block: 'start' 
            });
        }

        function showAllocationDetails() {
            document.getElementById("allocationDetails").classList.remove("hidden");
            document.getElementById("complaintForm").classList.add("hidden");
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="user-info">
                <div class="user-avatar">
                    <%= username.substring(0, 1).toUpperCase() %>
                </div>
                <div>
                    <h2><i class="fas fa-user-circle"></i> Welcome, <%= username %>!</h2>
                  
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="btn" onclick="showAllocationDetails()">
                    <i class="fas fa-desktop"></i> View System Details
                </button>
                <button class="btn" onclick="showComplaintForm()">
                    <i class="fas fa-exclamation-triangle"></i> Register Complaint
                </button>
                <a href="logout.jsp" class="btn btn-danger">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <!-- System Allocation Details -->
        <div id="allocationDetails" class="section">
            <h3><i class="fas fa-computer"></i> Your Allocated System Details</h3>
            <%
                if (systemNumber != null) {
            %>
                <div class="system-details">
                    <div class="detail-card">
                        <div class="detail-label">System Number</div>
                        <div class="detail-value"><%= systemNumber %></div>
                    </div>
                    <div class="detail-card">
                        <div class="detail-label">RAM Configuration</div>
                        <div class="detail-value"><%= ram != null ? ram : "Not specified" %></div>
                    </div>
                    <div class="detail-card">
                        <div class="detail-label">Processor</div>
                        <div class="detail-value"><%= processor != null ? processor : "Not specified" %></div>
                    </div>
                    <div class="detail-card">
                        <div class="detail-label">Accessories</div>
                        <div class="detail-value"><%= accessories != null ? accessories : "None assigned" %></div>
                    </div>
                   
                    
                </div>
            <%
                } else {
            %>
                <div class="no-allocation">
                    <i class="fas fa-exclamation-circle"></i>
                    <h4>No System Allocated</h4>
                    <p>No system has been allocated to you yet. Please contact your administrator.</p>
                </div>
            <%
                }
            %>
        </div>

        <!-- Complaint Form Section -->
        <div id="complaintForm" class="section hidden">
            <h3><i class="fas fa-bug"></i> System Complaint Form</h3>
            <div class="form-container">
                <form action="ComplaintServlet" method="post">
                    <!-- Hidden Employee ID from Session -->
                    <input type="hidden" name="employeeId" value="<%= session.getAttribute("employeeId") %>">

                    <div class="form-group">
                        <label for="systemNumber"><i class="fas fa-desktop"></i> System Number</label>
                        <input type="text" id="systemNumber" name="systemNumber" class="form-control"
                               value="<%= session.getAttribute("systemNumber") %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="problemType"><i class="fas fa-tags"></i> Problem Type</label>
                        <select id="problemType" name="problemType" class="form-control" required>
                            <option value="">-- Select Problem Type --</option>
                            <option value="Hardware">🔧 Hardware Issue</option>
                            <option value="Software">💻 Software Issue</option>
                            <option value="Network">🌐 Network Issue</option>
                            <option value="Other">❓ Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="description"><i class="fas fa-edit"></i> Problem Description</label>
                        <textarea id="description" name="description" class="form-control" rows="5"
                                  placeholder="Please describe the issue in detail..." required></textarea>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-exclamation"></i> Urgency Level</label>
                        <div class="radio-group">
                            <div class="radio-item">
                                <input type="radio" id="low" name="urgency" value="Low" required>
                                <label for="low">Low - Can wait a few days</label>
                            </div>
                            <div class="radio-item">
                                <input type="radio" id="medium" name="urgency" value="Medium">
                                <label for="medium">Medium - Needed within 24 hours</label>
                            </div>
                            <div class="radio-item">
                                <input type="radio" id="high" name="urgency" value="High">
                                <label for="high">High - Urgent, blocking work</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn submit-btn">
                            <i class="fas fa-paper-plane"></i> Submit Complaint
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
