<%@page import="java.util.List"%>
<%@page import="modelo.Torneo"%>
<%@page import="modelo.Equipo"%>
<%@page import="DAO.TorneoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Campeón del Torneo</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            color: #222;
        }

        .barra {
            background: #172536;
            color: white;
            padding: 22px 45px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .barra h2 {
            margin: 0;
            font-size: 24px;
        }

        .btn-volver {
            text-decoration: none;
            color: white;
            border: 1px solid white;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: bold;
        }

        .btn-volver:hover {
            background: white;
            color: #172536;
        }

        .contenedor {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
        }

        .titulo {
            text-align: center;
            margin-bottom: 35px;
        }

        .titulo h1 {
            font-size: 38px;
            margin-bottom: 10px;
        }

        .titulo p {
            color: #666;
            font-size: 17px;
        }

        .tarjeta {
            background: white;
            border-radius: 12px;
            padding: 35px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.10);
            margin-bottom: 30px;
        }

        .tarjeta h3 {
            margin-top: 0;
            color: #172536;
        }

        .formulario {
            display: flex;
            gap: 15px;
            align-items: end;
        }

        .campo {
            flex: 1;
        }

        .campo label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .campo select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 7px;
            font-size: 16px;
            background: white;
        }

        .btn-ver {
            background: #198754;
            color: white;
            border: none;
            padding: 13px 25px;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-ver:hover {
            background: #157347;
        }

        .campeon {
            text-align: center;
            padding: 45px 20px;
        }

        .trofeo {
            font-size: 70px;
            margin-bottom: 15px;
        }

        .campeon h2 {
            font-size: 34px;
            margin: 10px 0;
            color: #172536;
        }

        .nombre-campeon {
            font-size: 30px;
            font-weight: bold;
            color: #198754;
            margin: 20px 0;
        }

        .mensaje {
            color: #666;
            font-size: 17px;
        }

        .btn-panel {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: #198754;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .btn-panel:hover {
            background: #157347;
        }

        .sin-torneos {
            text-align: center;
            color: #777;
            padding: 20px;
        }

    </style>

</head>

<body>


<!-- BARRA SUPERIOR -->

<div class="barra">

    <h2>Sistema de torneos</h2>

    <a href="<%=request.getContextPath()%>/usuarioInicio.jsp"
       class="btn-volver">

        Volver

    </a>

</div>


<div class="contenedor">


    <!-- TÍTULO -->

    <div class="titulo">

        <h1>🏆 Campeón del torneo</h1>

        <p>
            Selecciona un torneo para consultar su equipo ganador.
        </p>

    </div>


    <!-- SELECTOR DE TORNEO -->

    <div class="tarjeta">

        <h3>Seleccionar torneo</h3>

        <p>
            Elige el torneo del cual deseas conocer el campeón.
        </p>


        <%

            TorneoDAO torneoDAO = new TorneoDAO();

            List<Torneo> torneos = torneoDAO.listarTorneos();

        %>


        <% if (torneos == null || torneos.isEmpty()) { %>

            <div class="sin-torneos">

                No hay torneos registrados.

            </div>

        <% } else { %>


            <form action="<%=request.getContextPath()%>/ResultadoServlet"
                  method="GET"
                  class="formulario">


                <input type="hidden"
                       name="accion"
                       value="campeon">


                <input type="hidden"
                       name="vista"
                       value="usuario">


                <div class="campo">

                    <label for="idTorneo">
                        Torneo
                    </label>


                    <select name="idTorneo"
                            id="idTorneo"
                            required>

                        <option value="">
                            -- Seleccione un torneo --
                        </option>


                        <%

                            for (Torneo torneo : torneos) {

                        %>

                            <option value="<%=torneo.getIdTorneo()%>">

                                <%=torneo.getNombre()%>

                            </option>

                        <%

                            }

                        %>

                    </select>

                </div>


                <button type="submit"
                        class="btn-ver">

                    Ver campeón

                </button>


            </form>


        <% } %>

    </div>


    <!-- RESULTADO DEL CAMPEÓN -->

    <%

        Equipo campeon =
                (Equipo) request.getAttribute("campeon");

    %>


    <% if (campeon != null) { %>


        <div class="tarjeta campeon">

            <div class="trofeo">
                🏆
            </div>


            <h2>
                Campeón del torneo
            </h2>


            <div class="nombre-campeon">

                <%=campeon.getNombreEquipo()%>

            </div>


            <p class="mensaje">

                ¡Felicidades al equipo ganador!

            </p>


            <a href="<%=request.getContextPath()%>/usuarioInicio.jsp"
               class="btn-panel">

                Volver al panel

            </a>

        </div>


    <% } %>


</div>


</body>

</html>