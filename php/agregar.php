#!/usr/bin/php
<?php 
// define("RUTA_DB", "/var/www/html/panel/inc/xion/");
if(!empty($argv)){

    // unset($argv[0]);
    $iid = (empty($argv[1])) ? " " : $argv[1];
    $e = base64_decode($argv[2]);
    $backup_url = (empty($e)) ? " " : $e;
    
    if(!empty($argv[3])) $permiso = $argv[3];

	echo 'DATOS PREPARADOS PARA SER GUARDADOS, ID:'.$iid. 'enlace' . $backup_url;
    include 'conexion.php';


	$sql_editar = 'UPDATE pelis SET Backup=? WHERE id=?';
	$sentencia_editar = $pdo->prepare($sql_editar);
	$sentencia_editar->execute(array($backup_url,$iid));

	//cerramos conexión base de datos y sentencia
	$pdo = null; 
	$sentencia_editar = null; 

}
