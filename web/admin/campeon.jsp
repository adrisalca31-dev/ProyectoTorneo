<%@ page import="DAO.TorneoDAO" %>
<%@ page import="modelo.Torneo" %>
<%@ page import="modelo.Equipo" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Campeón del torneo</title>

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

        /* =========================
           BARRA SUPERIOR
           ========================= */

        .barra {
            background: #172536;
            color: white;
            padding: 20px 55px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .btn-volver {
            text-decoration: none;
            color: white;
            border: 1px solid rgba(255,255,255,0.7);
            padding: 10px 18px;
            border-radius: 7px;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn-volver:hover {
            background: white;
            color: #172536;
        }

        /* =========================
           CONTENEDOR
           ========================= */

        .contenedor {
            width: 100%;
            max-width: 1000px;
            margin: 55px auto;
            padding: 0 25px;
        }

        .tarjeta {
            background: white;
            border-radius: 14px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .encabezado {
            margin-bottom: 30px;
        }

        .encabezado h1 {
            margin: 0 0 10px 0;
            font-size: 32px;
        }

        .encabezado p {
            margin: 0;
            color: #666;
            font-size: 16px;
        }

        /* =========================
           SELECCIÓN
           ========================= */

        .seleccion {
            background: #f8fafb;
            border: 1px solid #e1e5e9;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
        }

        .seleccion label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .seleccion select {
            width: 100%;
            height: 48px;
            padding: 0 14px;

            border: 1px solid #d5d9de;
            border-radius: 7px;

            background: white;
            font-size: 15px;
            cursor: pointer;
        }

        .seleccion select:focus {
            outline: none;
            border-color: #2f80ed;
            box-shadow: 0 0 0 3px rgba(47,128,237,0.12);
        }

        .btn-ver {
            display: inline-block;
            margin-top: 18px;

            padding: 12px 22px;

            background: #218653;
            color: white;

            text-decoration: none;
            border-radius: 7px;

            font-weight: bold;
            border: none;

            cursor: pointer;
        }

        .btn-ver:hover {
            background: #196b42;
        }

        /* =========================
           CAMPEÓN
           ========================= */

        .campeon {
            text-align: center;
            padding: 35px 20px;

            background: #fffdf2;
            border: 1px solid #f0df9b;
            border-radius: 12px;
        }

        .trofeo {
            font-size: 55px;
            margin-bottom: 10px;
        }

        .titulo-campeon {
            font-size: 18px;
            color: #777;
            margin-bottom: 8px;
        }

        .nombre-campeon {
            font-size: 30px;
            font-weight: bold;
            color: #b8860b;
        }

        .sin-campeon {
            text-align: center;
            padding: 35px;

            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 12px;

            color: #777;
            font-size: 17px;
        }

        /* =========================
           TORNEO SELECCIONADO
           ========================= */

        .nombre-torneo {
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: bold;
            color: #172536;
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 700px) {

            .barra {
                padding: 18px 25px;
            }

            .logo {
                font-size: 20px;
            }

            .contenedor {
                margin: 30px auto;
                padding: 0 15px;
            }

            .tarjeta {
                padding: 25px;
            }

            .encabezado h1 {
                font-size: 27px;
            }

        }

    </style>

</head>

<body>


<!-- =========================
     BARRA SUPERIOR
     ========================= -->

<div class="barra">

    <div class="logo">
        Sistema de torneos
    </div>

    <a
        class="btn-volver"
        href="<%= request.getContextPath() %>/adminInicio.jsp">

        Volver

    </a>

</div>


<!-- =========================
     CONTENIDO
     ========================= -->

<div class="contenedor">

    <div class="tarjeta">

        <div class="encabezado">

            <h1>
                Campeón del torneo
            </h1>

            <p>
                Seleccione un torneo para consultar su campeón.
            </p>

        </div>


        <!-- =========================
             LISTA DE TORNEOS
             ========================= -->

        <div class="seleccion">

            <form
                action="<%= request.getContextPath() %>/ResultadoServlet"
                method="get">

                <input
                    type="hidden"
                    name="accion"
                    value="campeon">

                <label for="idTorneo">
                    Seleccionar torneo
                </label>

                <select
                    id="idTorneo"
                    name="idTorneo"
                    required>

                    <option value="">
                        -- Seleccione un torneo --
                    </option>

                    <%
                        TorneoDAO torneoDAO = new TorneoDAO();

                        List<Torneo> torneos =
                                torneoDAO.listarTorneos();

                        int idSeleccionado = 0;

                        String parametro =
                                request.getParameter("idTorneo");

                        if (parametro != null &&
                            !parametro.isEmpty()) {

                            try {

                                idSeleccionado =
                                        Integer.parseInt(parametro);

                            } catch (NumberFormatException e) {

                                idSeleccionado = 0;

                            }
                        }

                        for (Torneo torneo : torneos) {
                    %>

                        <option
                            value="<%= torneo.getIdTorneo() %>"
                            <%= torneo.getIdTorneo() == idSeleccionado
                                ? "selected"
                                : "" %>>

                            <%= torneo.getNombre() %>

                        </option>

                    <%
                        }
                    %>

                </select>


                <button
                    type="submit"
                    class="btn-ver">

                    Ver campeón

                </button>

            </form>

        </div>


        <!-- =========================
             RESULTADO
             ========================= -->

        <%

            Equipo campeon =
                    (Equipo) request.getAttribute("campeon");

            Torneo torneoSeleccionado = null;

            if (idSeleccionado > 0) {

                for (Torneo torneo : torneos) {

                    if (torneo.getIdTorneo()
                            == idSeleccionado) {

                        torneoSeleccionado = torneo;
                        break;
                    }
                }
            }

        %>


        <%
            if (idSeleccionado > 0) {
        %>

            <div class="nombre-torneo">

                Torneo:
                <%= torneoSeleccionado != null
                        ? torneoSeleccionado.getNombre()
                        : "No encontrado" %>

            </div>


            <%
                if (campeon != null) {
            %>

                <div class="campeon">

                    <div class="trofeo">
                        🏆
                    </div>

                    <div class="titulo-campeon">
                        Campeón del torneo
                    </div>

                    <div class="nombre-campeon">

                        <%= campeon.getNombreEquipo() %>

                    </div>

                </div>

            <%
                } else {
            %>

                <div class="sin-campeon">

                    Este torneo todavía no tiene un campeón.

                </div>

            <%
                }
            %>

        <%
            }
        %>


    </div>

</div>


</body>

</html>