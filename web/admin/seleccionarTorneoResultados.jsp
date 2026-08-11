<%@ page import="java.util.List" %>
<%@ page import="modelo.Torneo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Seleccionar torneo</title>

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
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.10);
        }

        h1 {
            margin-top: 0;
        }

        .torneo {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #ddd;
        }

        .nombre {
            font-size: 18px;
            font-weight: bold;
        }

        .estado {
            color: #666;
            margin-left: 10px;
        }

        .boton {
            background-color: #1f7a4d;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 6px;
        }

        .boton:hover {
            background-color: #185f3c;
        }

        .volver {
            display: inline-block;
            margin-top: 25px;
            text-decoration: none;
            color: #6a1b9a;
        }

        .vacio {
            color: #666;
            padding: 20px 0;
        }

    </style>

</head>

<body>

<div class="contenedor">

    <h1>Registrar resultados</h1>

    <p>
        Selecciona el torneo en el que deseas registrar resultados.
    </p>

    <%
        List<Torneo> torneos =
                (List<Torneo>) request.getAttribute("torneos");
    %>

    <%
        if (torneos != null && !torneos.isEmpty()) {

            for (Torneo torneo : torneos) {
    %>

        <div class="torneo">

            <div>

                <span class="nombre">
                    <%= torneo.getNombre() %>
                </span>

                <span class="estado">
                    Estado:
                    <%= torneo.getEstado() %>
                </span>

            </div>

            <a class="boton"
               href="<%= request.getContextPath() %>/ResultadoServlet?accion=listar&idTorneo=<%= torneo.getIdTorneo() %>">

                Registrar resultados

            </a>

        </div>

    <%
            }

        } else {
    %>

        <p class="vacio">
            No hay torneos registrados.
        </p>

    <%
        }
    %>

    <a class="volver"
       href="<%= request.getContextPath() %>/adminInicio.jsp">

        Volver al inicio

    </a>

</div>

</body>

</html>