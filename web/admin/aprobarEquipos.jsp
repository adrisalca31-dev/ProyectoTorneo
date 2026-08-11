<%-- 
    Document   : aprobarEquipos1
    Created on : Jul 9, 2026, 12:38:45 AM
    Author     : aguer
--%>

<%@page import="modelo.Equipo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
        <title>Aprobar Equipos - Torneo</title>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <%
            List<Equipo> pendientes = (List<Equipo>) request.getAttribute("pendientes");
        %>

        <nav class="navbar navbar-expand-lg" style="background-color: darkslategray;">
            <div class="container">
                <a class="navbar-brand fw-bold text-white" href="<%= request.getContextPath() %>/adminInicio.jsp">Torneo</a>
                <span class="navbar-text ms-auto">
                    <a class="btn btn-light btn-sm px-3" style="color: black;" href="<%= request.getContextPath() %>/LogoutServlet">Cerrar Sesión</a>
                </span>
            </div>
        </nav>

        <div class="container mt-4 flex-grow-1">

            <div class="mb-4">
                <h2 class="fw-bold text-dark">Aprobación de Equipos</h2>
                <p class="text-muted small mb-0">Equipos que están en espera de revisión.</p>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body">

                    <% if (pendientes == null || pendientes.isEmpty()) { %>

                        <p class="text-muted text-center mb-0">No hay equipos pendientes por aprobar.</p>

                    <% } else { %>

                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Teléfono</th>
                                    <th>Estado</th>
                                    <th class="text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Equipo equipo : pendientes) { %>
                                    <tr>
                                        <td><%= equipo.getNombreEquipo() %></td>
                                        <td><%= equipo.getTelefono() %></td>
                                        <td><span class="badge bg-warning"><%= equipo.getEstado() %></span></td>
                                        <td class="text-end">
                                            <form action="<%= request.getContextPath() %>/AprobacionEquipoServlet" method="POST" class="d-inline">
                                                <input type="hidden" name="id_equipo" value="<%= equipo.getIdEquipo() %>">
                                                <input type="hidden" name="accion" value="aprobar">
                                                <button type="submit" class="btn btn-success btn-sm">Aprobar</button>
                                            </form>
                                            <form action="<%= request.getContextPath() %>/AprobacionEquipoServlet" method="POST" class="d-inline">
                                                <input type="hidden" name="id_equipo" value="<%= equipo.getIdEquipo() %>">
                                                <input type="hidden" name="accion" value="rechazar">
                                                <button type="submit" class="btn btn-danger btn-sm">Rechazar</button>
                                            </form>
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