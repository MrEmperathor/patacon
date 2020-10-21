#!/bin/bash/php
<?php
$permiso = 'admin2';
include 'conexion.php';

$nombre = $argv[1];

$sql_unico = "SELECT * FROM pelis ORDER BY nombre ASC";

$gsent_unico = $pdo->prepare($sql_unico);
$gsent_unico->execute(array($nombre));

$resultado_unico = $gsent_unico->fetch();

var_dump($resultado_unico);
