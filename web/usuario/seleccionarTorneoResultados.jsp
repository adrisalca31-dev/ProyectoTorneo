<%@ page import="modelo.Torneo" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Seleccionar torneo</title>

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
            background: transparent;
            color: white;
            border: 1px solid white;
            padding: 10px 18px;
            border-radius: 6px;
            text-decoration: none;
        }

        .btn-volver:hover {
            background: white;
            color: #172536;
        }

        .contenedor {
            max-width: 850px;
            margin: 60px auto;
            padding: 0 25px;
        }

        .tarjeta {
            background: white;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.10);
        }

        h1 {
            margin-top: 0;
            text-align: center;
            color: #172536;
        }

        .descripcion {
            text-align: center;
            color: #666;
            margin-bottom: 35px;
        }

        .torneos {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .torneo {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 22px;
            background: #fafafa;
            transition: 0.2s;
        }

        .torneo:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.10);
        }

        .torneo h3 {
            margin-top: 0;
            color: #172536;
        }

        .dato {
            color: #666;
            margin: 8px 0;
        }

        .estado {
            display: inline-block;
            margin-top: 8px;
            padding: 6px 12px;
            border-radius: 20px;
            background: #e8edf2;
            font-size: 13px;
            font-weight: bold;
        }

        .btn-resultados {
            display: block;
            width: 100%;
            margin-top: 18px;
            padding: 11px;
            background: #1f7a4d;
            color: white;
            border: none;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
        }

        .btn-resultados:hover {
            background: #185f3c;
        }

        .sin-torneos {
            text-align: center;
            color: #777;
            padding: 30px;
        }

    </style>

</head>

<body>

<div class="barra">

    <h2>Sistema de torneos</h2>

    <a class="btn-volver"
       href="<%= request.getContextPath() %>/usuarioInicio.jsp">

        Volver

    </a>

</div>


<div class="contenedor">

    <div class="tarjeta">

        <h1>Seleccionar torneo</h1>

        <p class="descripcion">
            Selecciona el torneo del cual deseas consultar los resultados.
        </p>


        <%

            List<Torneo> torneos =
                    (List<Torneo>) request.getAttribute("torneos");

        %>


        <% if (torneos != null && !torneos.isEmpty()) { %>


            <div class="torneos">

                <% for (Torneo torneo : torneos) { %>

                    <div class="torneo">

                        <h3>
                            <%= torneo.getNombre() %>
                        </h3>


                        <div class="dato">

                            Inicio:
                            <%= torneo.getFechaInicio() %>

                        </div>


                        <div class="dato">

                            Final:
                            <%= torneo.getFechaFin() %>

                        </div>


                        <div>

                            <span class="estado">

                                <%= torneo.getEstado() %>

                            </span>

                        </div>


                        <a class="btn-resultados"
                           href="<%= request.getContextPath() %>/ResultadoServlet?accion=listar&idTorneo=<%= torneo.getIdTorneo() %>&vista=usuario">

                            Ver resultados

                        </a>

                    </div>

                <% } %>

            </div>


        <% } else { %>


            <div class="sin-torneos">

                No hay torneos registrados.

            </div>


        <% } %>


    </div>

</div>

</body>

</html>