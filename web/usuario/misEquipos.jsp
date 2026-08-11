<%-- 
    Document   : misequipo
    Created on : Jul 9, 2026, 12:34:11 AM
    Author     : aguer
--%>

<%@page import="modelo.Usuario"%>
<%@page import="modelo.Equipo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
        <title>Mis Equipos - Torneo</title>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <%
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            List<Equipo> misEquipos = (List<Equipo>) request.getAttribute("misEquipos");
        %>

        <nav class="navbar navbar-expand-lg" style="background-color: darkslategray;">
            <div class="container">
                <a class="navbar-brand fw-bold text-white" href="<%= request.getContextPath() %>/usuarioInicio.jsp">Torneo</a>
                <span class="navbar-text ms-auto">
                    <a class="btn btn-light btn-sm px-3" style="color: black;" href="<%= request.getContextPath() %>/LogoutServlet">Cerrar Sesión</a>
                </span>
            </div>
        </nav>

        <div class="container mt-4 flex-grow-1">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold text-dark">Mis Equipos</h2>
                    <p class="text-muted small mb-0">Aquí puedes ver el estado de aprobación de los equipos que registraste.</p>
                </div>
                <a href="<%= request.getContextPath() %>/usuario/registrarEquipo.jsp" class="btn btn-primary btn-sm">+ Nuevo Equipo</a>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body">

                    <% if (misEquipos == null || misEquipos.isEmpty()) { %>

                        <p class="text-muted text-center mb-0">Todavía no has registrado ningún equipo.</p>

                    <% } else { %>

                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Teléfono</th>
                                    <th>Estado</th>
                                    <th>Fecha aprobación</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Equipo equipo : misEquipos) { %>
                                    <tr>
                                        <td><%= equipo.getNombreEquipo() %></td>
                                        <td><%= equipo.getTelefono() %></td>
                                        <td>
                                            <%
                                                String estado = equipo.getEstado();
                                                String claseBadge = "secondary";
                                                if ("APROBADO".equals(estado)) {
                                                    claseBadge = "success";
                                                } else if ("RECHAZADO".equals(estado)) {
                                                    claseBadge = "danger";
                                                } else if ("PENDIENTE".equals(estado)) {
                                                    claseBadge = "warning";
                                                }
                                            %>
                                            <span class="badge bg-<%= claseBadge %>"><%= estado %></span>
                                        </td>
                                        <td>
                                            <% if (equipo.getFechaAprobacion() != null) { %>
                                                <%= equipo.getFechaAprobacion() %>
                                            <% } else { %>
                                                -
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>

                    <% } %>

                </div>
            </div>
        </div>
    </body>
</html>
