<?php 
// require_once(__DIR__ . '/../config.php');
require_once("/var/www/html/panel/inc/config.php");

if (!empty($permiso) == "admin2") {

    $nameBase = $CONFIG["nameBase2"];

}else {
    $nameBase = $CONFIG["nameBase"];

    if ($_SESSION['nombre'] == $CONFIG["EmbedUser"]) $nameBase = $CONFIG["nameBase"];
    if ($_SESSION['nombre'] == $CONFIG["EmbedUser2"]) $nameBase = $CONFIG["nameBase2"];

}


    $link = 'mysql:host=localhost;dbname=' . $nameBase;
    $usuario = $CONFIG["dbUser"];
    $pass = $CONFIG["dbPass"];


try{
	$pdo = new PDO($link, $usuario, $pass);

	// echo "Conectado";

// 	foreach($pdo->query('SELECT * FROM `pelis`
// ') as $fila) {
//         print_r($fila);
// }


}catch (PDOException $e) {
    print "¡Error!: " . $e->getMessage() . "<br/>";
    die();
}

 ?>