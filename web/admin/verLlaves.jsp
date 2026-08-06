<%-- 
    Document   : verLlaves
    Created on : 5 ago 2026, 12:14:26 p.m.
    Author     : dylan
--%>

<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Llaves del torneo</title>
</head>
<body>

<h1>Llaves del torneo</h1>

<%
    List<Partido> partidos =
            (List<Partido>) request.getAttribute("partidos");
%>

<%
    if (partidos != null && !partidos.isEmpty()) {

        for (Partido partido : partidos) {
%>

    <p>
        <strong><%= partido.getNombreRonda() %>:</strong>
        <%= partido.getNombreEquipoLocal() %>
        vs
        <%= partido.getNombreEquipoVisitante() %>
        -
        <%= partido.getEstado() %>
    </p>

<%
        }

    } else {
%>

    <p>No hay llaves generadas.</p>

<%
    }
%>

</body>
</html>