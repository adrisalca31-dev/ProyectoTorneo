<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Crear torneo</title>

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
            max-width: 900px;
            margin: 55px auto;
            padding: 0 25px;
        }

        .tarjeta {
            background: white;
            border-radius: 14px;
            padding: 40px 45px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .encabezado {
            margin-bottom: 35px;
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
           FORMULARIO
           ========================= */

        .campo {
            margin-bottom: 24px;
        }

        .campo label {
            display: block;
            margin-bottom: 9px;
            font-size: 15px;
            font-weight: bold;
            color: #333;
        }

        .campo input {
            width: 100%;
            height: 48px;
            padding: 0 14px;

            border: 1px solid #d5d9de;
            border-radius: 7px;

            font-size: 15px;
            font-family: Arial, sans-serif;

            background: white;

            transition: 0.2s;
        }

        .campo input:focus {
            outline: none;
            border-color: #2f80ed;
            box-shadow: 0 0 0 3px rgba(47,128,237,0.12);
        }

        .campo input::placeholder {
            color: #aaa;
        }

        /* =========================
           DOS COLUMNAS
           ========================= */

        .fila {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* =========================
           AYUDA
           ========================= */

        .ayuda {
            margin-top: 7px;
            font-size: 13px;
            color: #777;
        }

        /* =========================
           BOTÓN
           ========================= */

        .acciones {
            margin-top: 32px;
            padding-top: 25px;
            border-top: 1px solid #e5e7eb;
        }

        .btn-crear {
            width: 100%;
            height: 50px;

            border: none;
            border-radius: 7px;

            background: #218653;
            color: white;

            font-size: 16px;
            font-weight: bold;

            cursor: pointer;

            transition: 0.2s;
        }

        .btn-crear:hover {
            background: #196b42;
            transform: translateY(-1px);
        }

        .btn-crear:active {
            transform: translateY(0);
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
                padding: 30px 25px;
            }

            .fila {
                grid-template-columns: 1fr;
                gap: 0;
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
                Crear torneo
            </h1>

            <p>
                Complete la información para registrar un nuevo torneo.
            </p>

        </div>


        <!-- =========================
             FORMULARIO
             ========================= -->

        <form
            action="<%= request.getContextPath() %>/TorneoServlet"
            method="post">

            <input
                type="hidden"
                name="accion"
                value="crear">


            <!-- NOMBRE -->

            <div class="campo">

                <label for="nombre">
                    Nombre del torneo
                </label>

                <input
                    type="text"
                    id="nombre"
                    name="nombre"
                    placeholder="Ejemplo: Campeonato Nacional 2026"
                    required>

            </div>


            <!-- IMAGEN -->

            <div class="campo">

                <label for="imagen">
                    Imagen del torneo
                </label>

                <input
                    type="text"
                    id="imagen"
                    name="imagen"
                    placeholder="Ejemplo: torneo1.jpg">

                <div class="ayuda">
                    Indique el nombre de la imagen que utilizará el torneo.
                </div>

            </div>


            <!-- FECHAS -->

            <div class="fila">

                <div class="campo">

                    <label for="fechaInicio">
                        Fecha de inicio
                    </label>

                    <input
                        type="date"
                        id="fechaInicio"
                        name="fechaInicio"
                        required>

                </div>


                <div class="campo">

                    <label for="fechaFin">
                        Fecha de finalización
                    </label>

                    <input
                        type="date"
                        id="fechaFin"
                        name="fechaFin"
                        required>

                </div>

            </div>


            <!-- PREMIO -->

            <div class="campo">

                <label for="premio">
                    Premio del torneo
                </label>

                <input
                    type="number"
                    id="premio"
                    name="premio"
                    placeholder="Ejemplo: 500000"
                    min="0"
                    step="0.01"
                    required>

                <div class="ayuda">
                    Ingrese el monto del premio en colones.
                </div>

            </div>


            <!-- BOTÓN -->

            <div class="acciones">

                <button
                    type="submit"
                    class="btn-crear">

                    Crear torneo

                </button>

            </div>

        </form>

    </div>

</div>


</body>

</html>