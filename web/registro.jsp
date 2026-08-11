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
    <body class="bg-light container d-flex flex-column justify-content-center align-items-center min-vh-100">

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        String error = (String) request.getAttribute("error");
    %>

    <% if (mensaje != null) { %>

    <div class="p-5 bg-white rounded shadow-lg text-center" style="max-width:500px; width:100%;">
        <h2 class="text-success mb-3">¡Registro exitoso!</h2>

        <p class="mb-4">
            <%= mensaje %>
        </p>

        <a href="login.jsp" class="btn btn-primary w-100">
            Ir a iniciar sesión
        </a>
    </div>

    <% } else { %>

    <div class="p-5 bg-white rounded shadow-lg" style="max-width:500px; width:100%;">
        <h2 class="fw-bold mb-3 text-center">Crear cuenta</h2>

        <% if (error != null) { %>
            <div class="alert alert-danger text-center">
                <%= error %>
            </div>
        <% } %>

        <form action="RegistroServlet" method="POST">

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="nombre" name="nombre_completo" placeholder="Nombre completo" required>
                <label for="nombre">Nombre Completo</label>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="correo" name="correo" placeholder="Correo" required>
                <label for="correo">Correo</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                <label for="contrasena">Contraseña</label>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-3">Registrarse</button>

        </form>

        <p class="text-center mb-0">¿Ya tienes una cuenta?<a href="login.jsp">Inicia sesión aquí</a></p>
    </div>

    <% } %>

    </body>
</html>
