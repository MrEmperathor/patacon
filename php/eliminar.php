<?php 

include_once 'conexion.php';

$id = $_GET['id'];

$sql_eliminar = 'DELETE FROM pelis WHERE id=?';
$sentencia_elimninar = $pdo->prepare($sql_eliminar);
$sentencia_elimninar->execute(array($id));

//cerramos conexión base de datos y sentencia
$pdo = null;
$sentencia_eliminar = null;

header('location:index.php');
