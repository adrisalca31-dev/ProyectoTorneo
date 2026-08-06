<%@page import="java.util.List"%>
<%@page import="modelo.Partido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultados del torneo</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background:#f2f4f7;
        }

        .contenedor{
            width:900px;
            margin:40px auto;
            background:white;
            padding:25px;
            border-radius:10px;
            box-shadow:0 2px 10px rgba(0,0,0,.15);
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th,td{
            border-bottom:1px solid #ddd;
            padding:12px;
            text-align:center;
        }

        th{
            background:#26384c;
            color:white;
        }

        .btn{
            display:inline-block;
            margin-top:20px;
            padding:10px 18px;
            background:#198754;
            color:white;
            text-decoration:none;
            border-radius:5px;
        }
    </style>

</head>
<body>

<div class="contenedor">

<h1>Resultados del Torneo</h1>

<%
List<Partido> partidos =
(List<Partido>)request.getAttribute("partidos");
%>

<table>

<tr>
    <th>Ronda</th>
    <th>Equipo Local</th>
    <th>Marcador</th>
    <th>Equipo Visitante</th>
    <th>Estado</th>
</tr>

<%
if(partidos != null){

    for(Partido p : partidos){
%>

<tr>

<td><%=p.getNombreRonda()%></td>

<td><%=p.getNombreEquipoLocal()%></td>

<td>
    <%=p.getGolesLocal()%>
    -
    <%=p.getGolesVisitante()%>
</td>

<td><%=p.getNombreEquipoVisitante()%></td>

<td><%=p.getEstado()%></td>

</tr>

<%
    }
}
%>

</table>

<a class="btn"
href="<%=request.getContextPath()%>/usuarioInicio.jsp">
Volver
</a>

</div>

</body>
</html>