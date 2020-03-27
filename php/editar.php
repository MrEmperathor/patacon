#!/usr/bin/php
<?php 
include 'conexion.php';

if ($argv) {
	
	unset($argv[0]);

	$tvip = (empty($argv[1])) ? " " : $argv[1];
	$tfree = (empty($argv[2])) ? " " : $argv[2];
	$iid = (empty($argv[3])) ? " " : $argv[3];
	


	$sql_editar = 'UPDATE pelis SET 7VIP=?,7FREE=? WHERE id=?';
	$sentencia_editar = $pdo->prepare($sql_editar);
	$sentencia_editar->execute(array($tvip,$tfree,$iid));

	//cerramos conexión base de datos y sentencia
	$pdo = null; 
	$sentencia_editar = null; 
}

 ?>