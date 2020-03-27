#!/usr/bin/php
<?php 
include 'conexion.php';

if ($argv) {

	unset($argv[0]);

	$TMBDid = (empty($argv[1])) ? " " : $argv[1];
	$name = (empty($argv[2])) ? " " : $argv[2];
	$temporada = (empty($argv[3])) ? " " : $argv[3];
	$calidad = (empty($argv[4])) ? " " : $argv[4];
	$idioma = (empty($argv[5])) ? " " : $argv[5];
	$enlaces = (empty($argv[6])) ? " " : $argv[6];
	$Backup = (empty($argv[7])) ? " " : $argv[7];
	$LEmbed = (empty($argv[8])) ? " " : $argv[8];

	$enlaces = unserialize(base64_decode($enlaces));
	$p = array();
	foreach ($enlaces as $key => $value) {
		$p[$key] = base64_decode($value);
	}
	$enlaces = serialize($p);

	$sql_agregar = 'INSERT INTO seriess (TMDB,nombre,temp,calidad,idioma,links,Backup,LEmbed) VALUES (?,?,?,?,?,?,?,?)';
	$sentencia_agregar = $pdo->prepare($sql_agregar);
	$sentencia_agregar->execute(array($TMBDid,$name,$temporada,$calidad,$idioma,$enlaces,$Backup,$LEmbed));


	  // $sql = "SELECT MAX(id) AS id FROM seriess";
	  // $query = $pdo->prepare($sql);
	  // $query->execute();
	  // $row = $query->fetch();

	  // echo $row['id'];

	//cerramos conexión base de datos y sentencia
    $sentencia_agregar = null;
    $pdo = null;
    // header('location:index.php');
}
	

 ?>