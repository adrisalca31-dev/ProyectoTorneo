<%-- 
    Document   : adminInicio
    Created on : 4 jul 2026, 21:39:16
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
        <title>Panel Administrador Torneo</title>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">
        <nav class="navbar navbar-expand-lg" style="background-color: darkslategray;">
            <div class="container">
                <a class="navbar-brand fw-bold text-white" href="adminInicio.jsp">Torneo </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuAdmin">
                <span class="navbar-toggler-icon"></span>
                </button>

                <span class="navbar-text">
                    <a class="btn btn-light btn-sm px-3" style="color: black;" href="LogoutServlet">Cerrar Sesión</a>
                </span>
                </div>
            </div>
        </nav>

        <div class="container mt-4 flex-grow-1">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="mb-0 fw-bold text-dark">Panel de Administración</h2>
                    <p class="text-muted small mb-0">Gestión de la base de datos: Torneo eliminatorio</p>
                </div>
            </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                    <div class="card border-0 text-dark h-100" style="background-color: lightblue;">
                    <div class="card-body">
                    <h5 class="card-title fw-bold">Gestión de Equipos</h5>
                    <p class="card-text opacity-75">Validación y aprobación de equipos participantes.</p>
                    <a href="<%= request.getContextPath() %>/AprobacionEquipoServlet" class="btn btn-light btn-sm">Ver Equipos</a>
                </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                    <div class="card border-0 text-dark h-100" style="background-color: lightgray;">
                    <div class="card-body">
                    <h5 class="card-title fw-bold">Configuración de Torneo</h5>
                    <p class="card-text opacity-75">Define parámetros, premios y lanza la competición.</p>
                    <a href="admin/crearTorneo.jsp" class="btn btn-light btn-sm">Crear Torneo</a>
                </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                    <div class="card border-0 text-dark h-100" style="background-color: lightseagreen;">
                    <div class="card-body">
                    <h5 class="card-title fw-bold">Estado del Torneo</h5>
                    <p class="card-text opacity-75">Consulta cronogramas, rondas y detalles operativos.</p>
                    <a href="admin/verTorneo.jsp" class="btn btn-light btn-sm">Ver Torneo</a>
                </div>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-md-4 mb-3">
                    <div class="card border-0 text-dark h-100" style="background-color: lightsalmon;">
                    <div class="card-body">
                    <h5 class="card-title fw-bold">Cuadro Eliminatorio</h5>
                    <p class="card-text opacity-75">Visualización de las llaves y enfrentamientos.</p>
                    <a href="admin/verLlaves.jsp" class="btn btn-light btn-sm">Ver Llaves</a>
                </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                    <div class="card border-0 text-dark h-100" style="background-color: lightsteelblue;">
                    <div class="card-body">
                    <h5 class="card-title fw-bold">Registro de Resultados</h5>
                    <p class="card-text opacity-75">Ingreso de marcadores y avance automático.</p>
                    <a href="admin/registrarResultados.jsp" class="btn btn-light btn-sm">Registrar</a>
                </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                    <div class="card border-0 text-dark h-100" style="background-color: lightcoral;">
                    <div class="card-body">
                    <h5 class="card-title fw-bold">Campeón</h5>
                    <p class="card-text opacity-75">Visualización y gestión del ganador final.</p>
                    <a href="admin/campeon.jsp" class="btn btn-light btn-sm">Ver Campeón</a>
                </div>
                </div>
            </div>
        </div>

        </div>
    </body>
    </html>
