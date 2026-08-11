<%-- 
    Document   : registrarResultados
    Created on : 5 ago 2026
    Author     : dylan
--%>

<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Registrar resultados</title>

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

        .barra {
            background-color: #182433;
            color: white;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .barra h2 {
            margin: 0;
        }

        .volver {
            color: white;
            text-decoration: none;
            padding: 9px 14px;
            border: 1px solid white;
            border-radius: 6px;
        }

        .volver:hover {
            background-color: white;
            color: #182433;
        }

        .contenedor {
            width: 92%;
            max-width: 1000px;
            margin: 35px auto;
        }

        .encabezado {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
            margin-bottom: 25px;
        }

        .encabezado h1 {
            margin: 0 0 8px;
        }

        .encabezado p {
            margin: 0;
            color: #666;
        }

        .mensaje-error {
            background-color: #fde2e2;
            color: #a61b1b;
            border: 1px solid #efb0b0;
            padding: 12px 15px;
            border-radius: 7px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .partidos {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .partido {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
            overflow: hidden;
        }

        .ronda {
            background-color: #26384c;
            color: white;
            padding: 10px 15px;
            font-size: 14px;
            font-weight: bold;
        }

        .contenido-partido {
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 80px 45px 80px 1fr 100px;
            gap: 12px;
            align-items: center;
        }

        .equipo {
            font-weight: bold;
            font-size: 16px;
        }

        .equipo.visitante {
            text-align: right;
        }

        .vs {
            text-align: center;
            color: #777;
            font-weight: bold;
        }

        input[type="number"] {
            width: 70px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            text-align: center;
            font-size: 16px;
        }

        input[type="number"]:focus {
            outline: none;
            border-color: #1f7a4d;
        }

        button {
            padding: 10px 14px;
            border: none;
            border-radius: 6px;
            background-color: #1f7a4d;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #185f3c;
        }

        .sin-partidos {
            background-color: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
            text-align: center;
        }

        .sin-partidos h2 {
            margin-top: 0;
        }

        .sin-partidos p {
            color: #666;
        }

        .enlace-llaves {
            display: inline-block;
            margin-top: 15px;
            background-color: #7c4bb4;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 6px;
        }

        @media (max-width: 800px) {

            .barra {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .contenido-partido {
                grid-template-columns: 1fr 65px 35px 65px 1fr;
            }

            .contenido-partido button {
                grid-column: 1 / -1;
                width: 100%;
            }

            .equipo {
                font-size: 14px;
            }
        }

    </style>

</head>

<body>

<div class="barra">

    <h2>Sistema de torneos</h2>

    <a class="volver"
       href="<%= request.getContextPath() %>/TorneoServlet?accion=listar">
        Volver
    </a>

</div>


<div class="contenedor">

    <div class="encabezado">

        <h1>Registrar resultados</h1>

        <p>
            Ingresa los marcadores de los partidos pendientes.
        </p>

    </div>


    <%
        if (request.getAttribute("error") != null) {
    %>

        <div class="mensaje-error">

            <%= request.getAttribute("error") %>

        </div>

    <%
        }
    %>


    <%
        List<Partido> partidos =
                (List<Partido>) request.getAttribute("partidos");

        Integer idTorneo =
                (Integer) request.getAttribute("idTorneo");

        boolean hayPendientes = false;
    %>


    <div class="partidos">

    <%
        if (partidos != null && !partidos.isEmpty()) {

            for (Partido partido : partidos) {

                /*
                 * Solo mostramos partidos que todavía
                 * están pendientes.
                 */
                if (!"PENDIENTE".equalsIgnoreCase(
                        partido.getEstado())) {

                    continue;
                }

                hayPendientes = true;
    %>


        <div class="partido">

            <div class="ronda">

                <%= partido.getNombreRonda() %>

            </div>


            <form action="<%= request.getContextPath() %>/ResultadoServlet"
                  method="post">

                <input type="hidden"
                       name="accion"
                       value="registrar">

                <input type="hidden"
                       name="idPartido"
                       value="<%= partido.getIdPartido() %>">

                <input type="hidden"
                       name="idTorneo"
                       value="<%= idTorneo %>">


                <div class="contenido-partido">

                    <div class="equipo">

                        <%= partido.getNombreEquipoLocal() %>

                    </div>


                    <input type="number"
                           name="golesLocal"
                           min="0"
                           required>


                    <div class="vs">

                        VS

                    </div>


                    <input type="number"
                           name="golesVisitante"
                           min="0"
                           required>


                    <div class="equipo visitante">

                        <%= partido.getNombreEquipoVisitante() %>

                    </div>


                    <button type="submit">

                        Guardar

                    </button>

                </div>

            </form>

        </div>


    <%
            }
        }
    %>

    </div>


    <%
        if (!hayPendientes) {
    %>

        <div class="sin-partidos">

            <h2>No hay partidos pendientes</h2>

            <p>
                Todos los partidos de este torneo
                ya fueron finalizados.
            </p>

            <a class="enlace-llaves"
               href="<%= request.getContextPath() %>/GenerarLlavesServlet?idTorneo=<%= idTorneo %>">

                Ver llaves

            </a>

        </div>

    <%
        }
    %>


</div>

</body>

</html>