<%-- 
    Document   : login
    Created on : 30 jun 2026, 19:41:45
    Author     : alexa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container d-flex flex-column justify-content-center align-items-center min-vh-100">

            <div class="p-5 bg-white rounded shadow-lg text-center" style="max-width: 500px; width: 100%;">
                <h2 class="fw-bold mb-3">Login</h2>
                <form action="LoginServlet" method="POST">
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="floatingInput" name="correo" placeholder="name@example.com"required>
                    <label for="floatingInput">Email address</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="floatingPassword" name="contrasena" placeholder="Password" required>
                    <label for="floatingPassword">Password</label>
                </div            
                    <div class="form-floating d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary w-100 my-3">Login</button>                  
                </form>
                
                <p class="text-center mb-0">¿No tienes una cuenta? <a href="registro.jsp">Registrate aquí</a></p>
            </div>
        </div>            
    </body>
</html>
