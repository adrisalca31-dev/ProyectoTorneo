<%-- 
    Document   : registro
    Created on : 30 jun 2026, 19:42:05
    Author     : alexa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
        <title>Registro nuevo usuario</title>
    </head>
    <body class="container d-flex flex-column justify-content-center align-items-center min-vh-100">

        <div class="p-5 bg-white rounded shadow-lg text-center" style="max-width: 500px; width: 100%;">
                        <h2 class="fw-bold mb-3">Crear cuenta</h2>
                <form action="RegistroServlet" method="POST ">   
                <div class="form-floating mb-3">
                  <label for="nombre" class="form-label">Nombre Completo</label>
                  <input type="text" class="form-control" id="nombre" name=nombre_completo" required>
                </div>
                <div class="form-floating mb-3">
                  <label for="correo" class="form-label">Correo</label>
                  <input type="email" class="form-control" id="correo" name=correo" required>
                </div>
                <div class="form-floating mb-3">
                  <label for="contrasena" class="form-label">Contrasena</label>
                  <input type="password" class="form-control" id="contrasena" name=contrasena" required>
                </div>
                
                <button type="button" class="btn btn-primary w-100 mb-3">Registrarse</button>
                
                </form >  
                <p class="text-center mb-0">¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
            </div
        </div 
       
                
    </body>
</html>
