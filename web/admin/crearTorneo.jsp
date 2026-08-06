    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>Crear torneo</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 30px;
        }

        .contenedor {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
        }

        h1 {
            text-align: center;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input,
        select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            cursor: pointer;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
    </head>

    <body>

    <div class="contenedor">

    <h1>Crear torneo</h1>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error">
            <%= request.getAttribute("error") %>
        </p>
    <% } %>

    <form action="<%= request.getContextPath() %>/TorneoServlet"
          method="post">

        <input type="hidden" name="accion" value="crear">

        <label for="nombre">Nombre del torneo</label>
        <input type="text"
               id="nombre"
               name="nombre"
               required>

        <label for="imagen">Imagen</label>
        <input type="text"
               id="imagen"
               name="imagen"
               placeholder="Ejemplo: torneo1.jpg">

        <label for="fechaInicio">Fecha de inicio</label>
        <input type="date"
               id="fechaInicio"
               name="fechaInicio"
               required>

        <label for="fechaFin">Fecha de finalización</label>
        <input type="date"
               id="fechaFin"
               name="fechaFin"
               required>

        <label for="premio">Premio</label>
        <input type="number"
               id="premio"
               name="premio"
               min="0"
               step="0.01"
               required>

        <button type="submit">
            Crear torneo
        </button>

    </form>

    </div>

    </body>
    </html>