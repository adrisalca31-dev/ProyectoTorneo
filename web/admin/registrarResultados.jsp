<%-- 
    Document   : registrarResultados
    Created on : 5 ago 2026, 1:26:17 p.m.
    Author     : dylan
--%>

<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar resultados</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
            margin: 0;
            padding: 30px;
        }

        .contenedor {
            max-width: 900px;
            margin: auto;
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.10);
        }

        h1 {
            margin-top: 0;
        }

        .partido {
            display: grid;
            grid-template-columns: 1fr 80px 40px 80px 1fr auto;
            gap: 10px;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #dddddd;
        }

        input[type="number"] {
            width: 70px;
            padding: 8px;
        }

        button {
            padding: 9px 14px;
            border: none;
            border-radius: 5px;
            background-color: #1f7a4d;
            color: white;
            cursor: pointer;
        }

        .volver {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="contenedor">

    <h1>Registrar resultados</h1>
    <% if (request.getAttribute("error") != null) { %>
    <p style="color: red; font-weight: bold;">
        <%= request.getAttribute("error") %>
    </p>
<% } %>

    <%
        List<Partido> partidos =
                (List<Partido>) request.getAttribute("partidos");

        Integer idTorneo =
                (Integer) request.getAttribute("idTorneo");
    %>

    <%
        if (partidos != null && !partidos.isEmpty()) {

            for (Partido partido : partidos) {
    %>

        <form action="<%= request.getContextPath() %>/ResultadoServlet"
              method="post">

            <input type="hidden" name="accion" value="registrar">
            <input type="hidden" name="idPartido"
                   value="<%= partido.getIdPartido() %>">
            <input type="hidden" name="idTorneo"
                   value="<%= idTorneo %>">

            <div class="partido">

                <strong>
                    <%= partido.getNombreEquipoLocal() %>
                </strong>

                <input type="number"
                       name="golesLocal"
                       min="0"
                       required>

                <span>vs</span>

                <input type="number"
                       name="golesVisitante"
                       min="0"
                       required>

                <strong>
                    <%= partido.getNombreEquipoVisitante() %>
                </strong>

                <button type="submit">
                    Guardar
                </button>

            </div>

        </form>

    <%
            }

        } else {
    %>

        <p>No hay partidos disponibles.</p>

    <%
        }
    %>

    <a class="volver"
       href="<%= request.getContextPath() %>/TorneoServlet?accion=listar">
        Volver
    </a>

</div>

</body>
</html>