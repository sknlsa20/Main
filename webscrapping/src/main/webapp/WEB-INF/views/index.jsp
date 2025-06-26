<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f4f4f4;
        }

        .data-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        table {
            width: 100% !important;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #04AA6D;
            color: white;
        }
    </style>
</head>
<body>
<div class="data-container">
    <!-- ✅ Inject scraped table HTML -->
    <div id="table-container">${tableHtml}</div>
</div>

<!-- ✅ Include jQuery & DataTables JS -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script>
    // 🧠 On page load, apply DataTables
    $(document).ready(function() {
        // Find the first table in #table-container and apply DataTables
        $('#table-container table').DataTable({
            "paging": true,
            "scrollX": true,
            "pageLength": 10,
            "lengthMenu": [5, 10, 20, 50],
        });
    });
</script>

</body>
</html>
