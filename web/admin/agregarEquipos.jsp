<%@ page import="java.util.List" %>
<%@ page import="modelo.Equipo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar equipos</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
            margin: 0;
            padding: 30px;
        }

        .contenedor {
            max-width: 800px;
            margin: auto;
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.10);
        }

        h1 {
            margin-top: 0;
        }

        .equipo {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-bottom: 1px solid #dddddd;
        }

        .boton {
            margin-top: 20px;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            background-color: #1f7a4d;
            color: white;
            cursor: pointer;
            font-weight: bold;
        }

        .volver {
            display: inline-block;
            margin-left: 10px;
            text-decoration: none;
        }

        .error {
            color: #b00020;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="contenedor">

    <h1>Agregar equipos al torneo</h1>

    <%
        List<Equipo> equipos =
                (List<Equipo>) request.getAttribute("equipos");

        Integer idTorneo =
                (Integer) request.getAttribute("idTorneo");
    %>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error">
            <%= request.getAttribute("error") %>
        </p>
    <% } %>

    <form action="<%= request.getContextPath() %>/TorneoServlet"
          method="post">

        <input type="hidden" name="accion" value="agregarEquipos">
        <input type="hidden" name="idTorneo" value="<%= idTorneo %>">

        <%
            if (equipos != null && !equipos.isEmpty()) {

                for (Equipo equipo : equipos) {
        %>

            <div class="equipo">

                <input type="checkbox"
                       name="idEquipo"
                       value="<%= equipo.getIdEquipo() %>">

                <strong>
                    <%= equipo.getNombreEquipo() %>
                </strong>

            </div>

        <%
                }

            } else {
        %>

            <p>No hay equipos aprobados disponibles.</p>

        <%
            }
        %>

        <button type="submit" class="boton">
            Guardar equipos
        </button>

        <a class="volver"
           href="<%= request.getContextPath() %>/TorneoServlet?accion=listar">
            Volver
        </a>

    </form>

</div>

</body>
</html>