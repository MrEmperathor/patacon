#!/usr/bin/php
<?php 

if ($argv) {

	unset($argv[0]);

	$TMBDid = (empty($argv[1])) ? " " : $argv[1];
	$name = (empty($argv[2])) ? " " : $argv[2];
	$calidad = (empty($argv[3])) ? " " : $argv[3];
	$idioma = (empty($argv[4])) ? " " : $argv[4];
	if (empty($argv[5])) {
		$enlaces = " ";
	}else{
		if ($argv[5] == "admin2") {
			$permiso = $argv[5];
		}else {
			$enlaces = $argv[5];
		}
	}
	$enlaces = (empty($argv[5])) ? " " : $argv[5];
	$descarga = (empty($argv[6])) ? " " : $argv[6];
	$lvip =(empty($argv[7])) ? " " : $argv[7];
	$lfree = (empty($argv[8])) ? " " : $argv[8];
	$tvip = (empty($argv[9])) ? " " : $argv[9];
	$tfree = (empty($argv[10])) ? " " : $argv[10];
	$embed = (empty($argv[11])) ? " " : $argv[11];
	$backup = (empty($argv[12])) ? " " : $argv[12];
	
	include 'conexion.php';


	$sql_agregar = 'INSERT INTO pelis (TMDB,nombre,calidad,idioma,links,DLinks,LVIP,LFREE,7VIP,7FREE,Embed,Backup) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)';
	$sentencia_agregar = $pdo->prepare($sql_agregar);
	$sentencia_agregar->execute(array($TMBDid,$name,$calidad,$idioma,$enlaces,$descarga,$lvip,$lfree,$tvip,$tfree,$embed,$backup));


	  $sql = "SELECT MAX(id) AS id FROM pelis";
	  $query = $pdo->prepare($sql);
	  $query->execute();
	  $row = $query->fetch();

	  echo $row['id'];

	//cerramos conexión base de datos y sentencia
    $sentencia_agregar = null;
    $pdo = null;
    // header('location:index.php');
}
	

 ?>