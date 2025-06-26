<%@ page language="java" import="java.time.LocalDate,java.util.*,java.text.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Results</title>
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
<style>
   
   

    

    select, input[type="submit"], input[type="text"] {
        padding: 8px;
        margin: 8px 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    input[type="submit"] {
        background-color: #04AA6D;
        color: white;
        border: none;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #03995c;
    }

    form {
        margin: 10px 0;
        text-align: center;
    }

    

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover td {
        background-color: #e6f7ff;
    }

    td strong {
        display: block;
        font-size: 16px;
        color: #2c3e50;
    }

    
</style>

    <script>
   
    
    function handleChange() {
        var arr = document.getElementById('menu1');
        
        var selectedValue = arr.value;

        // Don't redirect if placeholder is selected
        if (selectedValue === "select" || selectedValue === "") {
            return; // do nothing
        }

        // Use absolute URL to avoid repeated /selectcompany/selectcompany
        window.location.href = "/chart/" + selectedValue;
    }
</script>
</head>
<body>

<h2>Welcome to Results</h2>

<div style="text-align:center;">
    <form>
        
        <label>Select your company:</label>
        <select name="company" id="menu1" onchange="handleChange()">
            <option value="select">-- Select --</option>
            
            <c:forEach var="game" items="${gamelist}">
    					 <option value="${game}"><c:out value="${game}"/></option>
			</c:forEach>
        </select> 
    </form>
   </div>   
   
   

   
  


  </body>
</html>
