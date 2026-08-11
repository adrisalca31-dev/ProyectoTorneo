<%-- 
    Document   : verLlaves
    Created on : 5 ago 2026, 12:14:26
    Author     : dylan
--%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.Partido" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Llaves del torneo</title>

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
            width: 95%;
            max-width: 1400px;
            margin: 35px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 35px;
        }

        .llaves {
            display: flex;
            justify-content: center;
            gap: 30px;
            overflow-x: auto;
            padding: 20px 10px 40px;
        }

        .ronda {
            min-width: 260px;
        }

        .ronda h2 {
            text-align: center;
            background-color: #26384c;
            color: white;
            padding: 12px;
            border-radius: 7px;
            font-size: 18px;
            margin-bottom: 25px;
        }

        .partidos {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            min-height: 500px;
            gap: 25px;
        }

        .partido {
            background-color: white;
            border-radius: 9px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.10);
            overflow: hidden;
            border: 1px solid #ddd;
        }

        .equipo {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 11px 14px;
            border-bottom: 1px solid #eee;
            font-weight: bold;
        }

        .equipo:last-child {
            border-bottom: none;
        }

        .nombre-equipo {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .marcador {
            margin-left: 15px;
            font-size: 18px;
            min-width: 20px;
            text-align: center;
        }

        .estado {
            text-align: center;
            padding: 7px;
            font-size: 12px;
            font-weight: bold;
        }

        .finalizado {
            background-color: #d5f4e3;
            color: #17653c;
        }

        .pendiente {
            background-color: #fff2c7;
            color: #7c5d00;
        }

        .sin-partidos {
            background-color: white;
            padding: 25px;
            border-radius: 9px;
            text-align: center;
            color: #666;
        }

        .campeon {
            margin: 30px auto;
            max-width: 450px;
            background-color: #fff8d6;
            border: 2px solid #d6b600;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }

        @media (max-width: 800px) {

            .barra {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .llaves {
                justify-content: flex-start;
            }

            .ronda {
                min-width: 240px;
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

    <h1>Llaves del torneo</h1>

    <%
        List<Partido> partidos =
                (List<Partido>) request.getAttribute("partidos");

        List<Partido> cuartos =
                new ArrayList<>();

        List<Partido> semifinales =
                new ArrayList<>();

        List<Partido> finalPartidos =
                new ArrayList<>();

        if (partidos != null) {

            for (Partido partido : partidos) {

                if (partido.getIdRonda() == 2) {

                    cuartos.add(partido);

                } else if (partido.getIdRonda() == 3) {

                    semifinales.add(partido);

                } else if (partido.getIdRonda() == 4) {

                    finalPartidos.add(partido);
                }
            }
        }
    %>


    <%
        if (partidos != null && !partidos.isEmpty()) {
    %>

        <div class="llaves">


            <!-- CUARTOS -->

            <div class="ronda">

                <h2>Cuartos de final</h2>

                <div class="partidos">

                    <%
                        for (Partido partido : cuartos) {
                    %>

                        <div class="partido">

                            <div class="equipo">

                                <span class="nombre-equipo">
                                    <%= partido.getNombreEquipoLocal() %>
                                </span>

                                <span class="marcador">
                                    <%= partido.getGolesLocal() %>
                                </span>

                            </div>

                            <div class="equipo">

                                <span class="nombre-equipo">
                                    <%= partido.getNombreEquipoVisitante() %>
                                </span>

                                <span class="marcador">
                                    <%= partido.getGolesVisitante() %>
                                </span>

                            </div>

                            <%
                                if ("FINALIZADO".equalsIgnoreCase(
                                        partido.getEstado())) {
                            %>

                                <div class="estado finalizado">
                                    FINALIZADO
                                </div>

                            <%
                                } else {
                            %>

                                <div class="estado pendiente">
                                    PENDIENTE
                                </div>

                            <%
                                }
                            %>

                        </div>

                    <%
                        }
                    %>

                </div>

            </div>


            <!-- SEMIFINALES -->

            <div class="ronda">

                <h2>Semifinales</h2>

                <div class="partidos">

                    <%
                        for (Partido partido : semifinales) {
                    %>

                        <div class="partido">

                            <div class="equipo">

                                <span class="nombre-equipo">
                                    <%= partido.getNombreEquipoLocal() %>
                                </span>

                                <span class="marcador">
                                    <%= partido.getGolesLocal() %>
                                </span>

                            </div>

                            <div class="equipo">

                                <span class="nombre-equipo">
                                    <%= partido.getNombreEquipoVisitante() %>
                                </span>

                                <span class="marcador">
                                    <%= partido.getGolesVisitante() %>
                                </span>

                            </div>

                            <%
                                if ("FINALIZADO".equalsIgnoreCase(
                                        partido.getEstado())) {
                            %>

                                <div class="estado finalizado">
                                    FINALIZADO
                                </div>

                            <%
                                } else {
                            %>

                                <div class="estado pendiente">
                                    PENDIENTE
                                </div>

                            <%
                                }
                            %>

                        </div>

                    <%
                        }
                    %>

                </div>

            </div>


            <!-- FINAL -->

            <div class="ronda">

                <h2>Final</h2>

                <div class="partidos">

                    <%
                        for (Partido partido : finalPartidos) {
                    %>

                        <div class="partido">

                            <div class="equipo">

                                <span class="nombre-equipo">
                                    <%= partido.getNombreEquipoLocal() %>
                                </span>

                                <span class="marcador">
                                    <%= partido.getGolesLocal() %>
                                </span>

                            </div>

                            <div class="equipo">

                                <span class="nombre-equipo">
                                    <%= partido.getNombreEquipoVisitante() %>
                                </span>

                                <span class="marcador">
                                    <%= partido.getGolesVisitante() %>
                                </span>

                            </div>

                            <%
                                if ("FINALIZADO".equalsIgnoreCase(
                                        partido.getEstado())) {
                            %>

                                <div class="estado finalizado">
                                    FINALIZADO
                                </div>

                            <%
                                } else {
                            %>

                                <div class="estado pendiente">
                                    PENDIENTE
                                </div>

                            <%
                                }
                            %>

                        </div>

                    <%
                        }
                    %>

                </div>

            </div>

        </div>

    <%
        } else {
    %>

        <div class="sin-partidos">
            No hay llaves generadas para este torneo.
        </div>

    <%
        }
    %>

</div>

</body>

</html>