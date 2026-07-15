<%-- 
    Document   : registrarEquipo
    Created on : Jul 9, 2026, 12:36:06 AM
    Author     : aguer
--%>

<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
        <title>Registrar Equipo - Torneo</title>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <%
            Usuario usuario = (Usuario) session.getAttribute("usuario");
        %>

        <nav class="navbar navbar-expand-lg" style="background-color: darkslategray;">
            <div class="container">
                <a class="navbar-brand fw-bold text-white" href="<%= request.getContextPath() %>/usuarioInicio.jsp">Torneo</a>
                <span class="navbar-text ms-auto">
                    <a class="btn btn-light btn-sm px-3" style="color: black;" href="<%= request.getContextPath() %>/LogoutServlet">Cerrar Sesión</a>
                </span>
            </div>
        </nav>

        <div class="container mt-4 flex-grow-1 d-flex flex-column align-items-center">

            <div class="p-5 bg-white rounded shadow-lg" style="max-width: 500px; width: 100%;">

                <h2 class="fw-bold mb-3 text-center">Registrar Equipo</h2>
                <p class="text-muted text-center small">Completa los datos de tu equipo, quedará en estado <strong>PENDIENTE</strong> hasta que un administrador lo apruebe.</p>

                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                        <div class="alert alert-danger"><%= error %></div>
                <%
                    }
                %>

                <form action="<%= request.getContextPath() %>/EquipoServlet" method="POST">

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="nombreEquipo" name="nombre_equipo" placeholder="Nombre del equipo" required>
                        <label for="nombreEquipo">Nombre del equipo</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="escudo" name="escudo" placeholder="URL del escudo">
                        <label for="escudo">URL del escudo (opcional)</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono de contacto" required>
                        <label for="telefono">Teléfono de contacto</label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Registrar Equipo</button>
                </form>

                <p class="text-center mt-3 mb-0"><a href="<%= request.getContextPath() %>/EquipoServlet">Ver mis equipos registrados</a></p>
            </div>
        </div>
    </body>
</html>

