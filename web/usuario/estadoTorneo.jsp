<%@ page import="modelo.Torneo" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Estado del Torneo</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
            padding: 40px;
        }

        .contenedor {
            max-width: 900px;
            margin: auto;
            background-color: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        h1 {
            margin-top: 0;
            color: #222;
        }

        .informacion {
            margin-top: 25px;
        }

        .dato {
            padding: 18px;
            border-bottom: 1px solid #ddd;
        }

        .titulo {
            font-weight: bold;
            color: #555;
        }

        .valor {
            font-size: 20px;
            font-weight: bold;
            margin-top: 5px;
        }

        .estado {
            color: #1f7a4d;
        }

        .ronda {
            color: #d69e00;
        }

        .volver {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 18px;
            background-color: #1f7a4d;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .volver:hover {
            background-color: #185f3c;
        }

    </style>

</head>

<body>

<div class="contenedor">

    <h1>Estado actual del torneo</h1>

    <%
        Torneo torneo =
                (Torneo) request.getAttribute("torneo");

        String rondaActual =
                (String) request.getAttribute("rondaActual");

        List<Partido> partidos =
                (List<Partido>) request.getAttribute("partidos");
    %>

    <div class="informacion">

        <div class="dato">

            <div class="titulo">
                Torneo
            </div>

            <div class="valor">

                <%
                    if (torneo != null) {
                %>

                    <%= torneo.getNombre() %>

                <%
                    } else {
                %>

                    Torneo no encontrado

                <%
                    }
                %>

            </div>

        </div>


        <div class="dato">

            <div class="titulo">
                Estado
            </div>

            <div class="valor estado">

                <%
                    if (torneo != null) {
                %>

                    <%= torneo.getEstado() %>

                <%
                    } else {
                %>

                    No disponible

                <%
                    }
                %>

            </div>

        </div>


        <div class="dato">

            <div class="titulo">
                Etapa actual
            </div>

            <div class="valor ronda">

                <%= rondaActual %>

            </div>

        </div>


        <div class="dato">

            <div class="titulo">
                Partidos registrados
            </div>

            <div class="valor">

                <%
                    if (partidos != null) {
                %>

                    <%= partidos.size() %>

                <%
                    } else {
                %>

                    0

                <%
                    }
                %>

            </div>

        </div>

    </div>

    <a class="volver"
       href="<%= request.getContextPath() %>/usuarioInicio.jsp">

       Volver al panel

    </a>


</div>

</body>

</html>