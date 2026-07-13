<%-- 
    Document   : usuarioInicio
    Created on : 4 jul 2026, 21:39:31
    Author     : alexa
--%>
<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
 
        <title>Panel del Usuario - Torneo</title>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">
        <%
            Usuario usuario = (Usuario)session.getAttribute("usuario");
            if (usuario == null) { response.sendRedirect("login.jsp"); return; }
        %>

        <% if ("exito".equals(request.getParameter("mensaje"))) { %>
            <div class="flex-grow-1 d-flex justify-content-center align-items-center">
                <div class="card p-5 shadow-lg text-center" style="max-width: 400px;">
                    <h2 class="text-success fw-bold">¡Bienvenido!</h2>
                    <p class="text-muted">Tu cuenta ha sido creada exitosamente, <%=usuario.getNombreCompleto()%>.</p>
                    <a href="usuarioInicio.jsp" class="btn btn-primary w-100">Continuar al Torneo</a>
                </div>
            </div>
        <% } else { %>
        <nav class="navbar navbar-expand-lg" style="background-color: darkslategray;">
        <div class="container">
            <a class="navbar-brand fw-bold text-white" href="usuarioInicio.jsp">Torneo</a>
            <div class="collapse navbar-collapse" id="menuUser">
                <span class="navbar-text ms-auto">
                    <a class="btn btn-light btn-sm px-3" style="color: black;" href="LogoutServlet">Cerrar Sesión</a>
                </span>
            </div>
        </div>
        </nav>

            <div class="container mt-4 flex-grow-1">
                <div class="mb-4">
                    <h2 class="fw-bold text-dark">Bienvenido <%=usuario.getNombreCompleto()%></h2>
                    <p class="text-muted">Consulta aquí los resultados y el estado actual del torneo.</p>
                </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title text-primary fw-bold">Equipos Participantes</h5>
                        <p class="card-text small text-muted">Consulta la lista completa de equipos inscritos y aprobados.</p>
                        <a href="usuario/registrarEquipo.jsp" class="btn btn-primary btn-sm">Ver Equipos</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title text-success fw-bold">Cuadro del Torneo</h5>
                        <p class="card-text small text-muted">Visualiza las llaves, enfrentamientos y el avance por rondas.</p>
                        <a href="usuario/verLlaves.jsp" class="btn btn-success btn-sm">Ver Llaves</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title text-info fw-bold">Resultados y Marcadores</h5>
                        <p class="card-text small text-muted">Revisa los resultados finales de cada partido disputado.</p>
                        <a href="usuario/resultados.jsp" class="btn btn-info btn-sm text-white">Ver Resultados</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-md-6 mb-3">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title text-warning fw-bold">Estado Actual del Torneo</h5>
                        <p class="card-text small text-muted">¿En qué etapa estamos? Consulta la fase actual y equipos clasificados.</p>
                        <a href=" " class="btn btn-warning btn-sm text-white">Estado Actual</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title text-danger fw-bold">Campeón del Torneo</h5>
                        <p class="card-text small text-muted">Mira quién se coronó ganador al finalizar la competencia.</p>
                        <a href="usuario/campeon" class="btn btn-danger btn-sm text-white">Ver Campeón</a>
                    </div>
                </div>
            </div>
        </div>

    </div>                    
 <% } %>                   
</body>
</html>
