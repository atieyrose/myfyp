<%-- 
    Document   : footer
    Created on : 24 Dec 2023, 2:20:57 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Footer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">-->
    <jsp:include page="bootstrap.jsp"/>

    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        main {
            flex: 1;
        }

        footer {
            /* Remove fixed-bottom class */
            /* The footer will be part of the scrollable content */
            background-color: #006666;
            color: white;
            text-align: center;
            padding: 10px;
        }
    </style>
</head>
<body>
    <main>
        <!-- Your page content goes here -->
    </main>

    <footer>
        <!-- The footer will be part of the scrollable content -->
        <!-- Background image -->
        <div class="p-5 text-center bg-image" style="height: 80px;">
            <div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
                <div class="d-flex justify-content-center align-items-center h-100">
                    <div class="text-white">
                        <p>&copy; 2023 Jernih Group Ent. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Background image -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
