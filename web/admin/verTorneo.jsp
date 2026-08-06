<%@ page import="java.util.List" %>
<%@ page import="modelo.Torneo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Administrar torneos</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
            color: #222;
        }

        .barra-superior {
            background-color: #182433;
            color: white;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .barra-superior h2 {
            margin: 0;
        }

        .barra-superior a {
            color: white;
            text-decoration: none;
            padding: 9px 14px;
            border: 1px solid white;
            border-radius: 6px;
        }

        .barra-superior a:hover {
            background-color: white;
            color: #182433;
        }

        .contenedor {
            width: 92%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .encabezado {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
            gap: 15px;
        }

        .encabezado h1 {
            margin: 0;
            font-size: 30px;
        }

        .boton-crear {
            background-color: #1f7a4d;
            color: white;
            text-decoration: none;
            padding: 12px 18px;
            border-radius: 7px;
            font-weight: bold;
        }

        .boton-crear:hover {
            background-color: #185f3c;
        }

        .tabla-contenedor {
            background-color: white;
            border-radius: 10px;
            overflow-x: auto;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.10);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th {
            background-color: #26384c;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e2e2e2;
        }

        tr:hover {
            background-color: #f8f9fb;
        }

        .imagen-torneo {
            width: 65px;
            height: 50px;
            object-fit: cover;
            border-radius: 6px;
            background-color: #dddddd;
        }

        .estado {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .pendiente {
            background-color: #fff2c7;
            color: #7c5d00;
        }

        .activo {
            background-color: #d5f4e3;
            color: #17653c;
        }

        .finalizado {
            background-color: #e2e4e8;
            color: #444;
        }

        .acciones {
            display: flex;
            gap: 7px;
            flex-wrap: wrap;
        }

        .boton {
            display: inline-block;
            text-decoration: none;
            color: white;
            padding: 8px 11px;
            border-radius: 5px;
            font-size: 13px;
        }

        .boton-equipos {
            background-color: #2868b2;
        }

        .boton-llaves {
            background-color: #7c4bb4;
        }

        .boton-resultados {
            background-color: #d5771c;
        }

        .boton-campeon {
            background-color: #b29716;
        }

        .vacio {
            text-align: center;
            padding: 35px;
            color: #666;
        }

        @media (max-width: 700px) {
            .barra-superior,
            .encabezado {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>

<div class="barra-superior">

    <h2>Sistema de torneos</h2>

    <a href="<%= request.getContextPath() %>/adminInicio.jsp">
        Volver al inicio
    </a>

</div>

<div class="contenedor">

    <div class="encabezado">

        <div>
            <h1>Administración de torneos</h1>
            <p>Consulta y administra los torneos registrados.</p>
        </div>

        <a class="boton-crear"
           href="<%= request.getContextPath() %>/admin/crearTorneo.jsp">
            + Crear torneo
        </a>

    </div>

    <%
        List<Torneo> torneos =
                (List<Torneo>) request.getAttribute("torneos");
    %>

    <div class="tabla-contenedor">

        <table>

            <thead>
                <tr>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Fecha de inicio</th>
                    <th>Fecha final</th>
                    <th>Premio</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>

            <%
                if (torneos != null && !torneos.isEmpty()) {

                    for (Torneo torneo : torneos) {

                        String claseEstado = "pendiente";

                        if ("ACTIVO".equalsIgnoreCase(torneo.getEstado())) {
                            claseEstado = "activo";
                        }

                        if ("FINALIZADO".equalsIgnoreCase(torneo.getEstado())) {
                            claseEstado = "finalizado";
                        }
            %>

                <tr>

                    <td>
                        <%
                            if (torneo.getImagen() != null
                                    && !torneo.getImagen().isBlank()) {
                        %>

                            <img class="imagen-torneo"
                                 src="<%= request.getContextPath() %>/imagenes/<%= torneo.getImagen() %>"
                                 alt="Imagen del torneo">

                        <%
                            } else {
                        %>

                            Sin imagen

                        <%
                            }
                        %>
                    </td>

                    <td>
                        <strong><%= torneo.getNombre() %></strong>
                    </td>

                    <td>
                        <%= torneo.getFechaInicio() %>
                    </td>

                    <td>
                        <%= torneo.getFechaFin() %>
                    </td>

                    <td>
                        ₡<%= String.format("%.2f", torneo.getPremio()) %>
                    </td>

                    <td>
                        <span class="estado <%= claseEstado %>">
                            <%= torneo.getEstado() %>
                        </span>
                    </td>

                    <td>

                        <div class="acciones">

                            <a class="boton boton-equipos"
   href="<%= request.getContextPath() %>/TorneoServlet?accion=equipos&idTorneo=<%= torneo.getIdTorneo() %>">
    Equipos
</a>

<a class="boton boton-llaves"
   href="<%= request.getContextPath() %>/GenerarLlavesServlet?idTorneo=<%= torneo.getIdTorneo() %>">
    Llaves
</a>

                            <a class="boton boton-resultados"
                               href="<%= request.getContextPath() %>/ResultadoServlet?accion=listar&idTorneo=<%= torneo.getIdTorneo() %>">
                                Resultados
                            </a>

                            <a class="boton boton-campeon"
                               href="<%= request.getContextPath() %>/ResultadoServlet?accion=campeon&idTorneo=<%= torneo.getIdTorneo() %>">
                                Campeón
                            </a>

                        </div>

                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>
                    <td colspan="7" class="vacio">
                        Todavía no hay torneos registrados.
                    </td>
                </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>