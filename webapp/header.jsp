<%-- 
    Document   : header
    Created on : 23 Dec 2023, 2:07:40 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">-->
        <jsp:include page="bootstrap.jsp"/>
    </head>
    <body>
        <header>

            <!-- Background image -->
            <div
                class="p-5 text-center bg-image"
                style="
                background-color: #006666;
                height: 120px;
                "
                >
                <div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
                    <div class="d-flex justify-content-center align-items-center h-100">
                        <div class="text-white">
                            <h2 class="mb-3">Jernih Group Ent</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Background image -->
        </header>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
