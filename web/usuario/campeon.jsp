<%@ page import="modelo.Equipo" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Campeón del torneo</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
        }

        .contenedor {
            width: 500px;
            max-width: 90%;
            margin: 60px auto;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.15);
        }

        .trofeo {
            font-size: 65px;
            margin-bottom: 10px;
        }

        .escudo {
            width: 150px;
            height: 150px;
            object-fit: contain;
            margin: 20px 0;
        }

        .boton {
            display: inline-block;
            margin-top: 20px;
            padding: 11px 20px;
            background-color: #198754;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>

<body>

<div class="contenedor">

    <%
        Equipo campeon =
                (Equipo) request.getAttribute("campeon");
    %>

    <div class="trofeo">🏆</div>

    <h1>Campeón del torneo</h1>

    <%
        if (campeon != null) {
    %>

        <h2><%= campeon.getNombreEquipo() %></h2>

        <%
            if (campeon.getEscudo() != null
                    && !campeon.getEscudo().isBlank()) {
        %>

            <img class="escudo"
                 src="<%= request.getContextPath() %>/imagenes/<%= campeon.getEscudo() %>"
                 alt="Escudo del campeón">

        <%
            }
        %>

        <p>¡Felicidades al equipo ganador!</p>

    <%
        } else {
    %>

        <p>Aún no existe un campeón para este torneo.</p>

    <%
        }
    %>

    <a class="boton"
       href="<%= request.getContextPath() %>/usuarioInicio.jsp">
        Volver al panel
    </a>

</div>

</body>
</html>