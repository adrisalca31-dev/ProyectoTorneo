<%-- 
    Document   : campeon
    Created on : 5 ago 2026, 1:41:00 p.m.
    Author     : dylan
--%>

<%@ page import="modelo.Equipo" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Campeón del Torneo</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background:#f2f4f7;
        }

        .contenedor{
            width:500px;
            margin:60px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0 2px 10px rgba(0,0,0,.15);
            text-align:center;
        }

        img{
            width:150px;
            margin:20px 0;
        }

        .btn{
            display:inline-block;
            margin-top:20px;
            padding:10px 20px;
            background:#1f7a4d;
            color:white;
            text-decoration:none;
            border-radius:5px;
        }
    </style>

</head>
<body>

<div class="contenedor">

<%
    Equipo campeon = (Equipo) request.getAttribute("campeon");
    Integer idTorneo = (Integer) request.getAttribute("idTorneo");
%>

<h1>🏆 Campeón del Torneo</h1>

<%
    if(campeon != null){
%>

    <h2><%= campeon.getNombreEquipo() %></h2>

    <img src="<%=request.getContextPath()%>/imagenes/<%=campeon.getEscudo()%>"
         alt="Escudo">

    <p>¡Felicidades al campeón!</p>

<%
    }else{
%>

    <h3>Aún no existe un campeón.</h3>

<%
    }
%>

<br>

<a class="btn"
   href="<%=request.getContextPath()%>/TorneoServlet?accion=listar">
    Volver
</a>

</div>

</body>
</html>