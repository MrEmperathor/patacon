<?php 
// include_once '../xion/conexion.php';
// # Función para añadir un elemento en una posición del array o vector
// # Tiene que recibir:
// #	$valor a añadir
// #	$posicion donde añadir el $valor (0 es la primera posicion)
// #	$array el array donde añadir dicho $valor
// # Devuelve el array modificado o false si no se ha podido añadir
function insertar($valor,$posicion,$array)
{
	// Si la posición indicad es superior al los valores del array o inferior a 0
	if($posicion>count($array) || $posicion<0)
	{
		return false;
	}
 
	// si la posicion es la misma que la cantidad de valores, lo añadiremos al
	// final del array que hemos recibido
	if($posicion==count($array))
	{
		$array[]=$valor;
		return $array;
	}
 
	$nuevoArray=array();
 
	// Recorremos todo el array de valores y añadimos el valor en la posicion
	// indicada
	for($i=0;$i<count($array);$i++)
	{
 
		// En el momento que coincide, se añade el valor
		if($i==$posicion)
			$nuevoArray[]=$valor;
 
		$nuevoArray[]=$array[$i];
	}
 
	// Devolvemos el array modificado
	return $nuevoArray;
}

// $arrayInicial=array("a","b","d");
// $nuevoArray=insertar("c",2,$arrayInicial);
 
// if($nuevoArray)
// {
// 	echo('<pre>');
// 	print_r($nuevoArray);
// 	echo('</pre>');
// }else{
// 	echo "Error";
// }

function buscarDato($arrayExample,$termToSearch)
{

	// $arrayExample = array('Zapatillas de running', 'Zapatillas de tenis', 'Zapatillas de basket');
	// $termToSearch = 'zapatillas';
	$matches = array_filter($arrayExample, function($var) use ($termToSearch) { return stristr($var, $termToSearch); });
	if($matches)
	{	

		// $very = array_search('http://vip.pastepelis.xyz/?v=jUh', $enlaces, true);
		// echo('<prev>');
		// print_r($matches);
		// echo('</prev>');
		foreach ($matches as $match) 
		{
			$very = array_search($match, $arrayExample, true);
        	// echo $very.'<br>';
    	}
	    return $very;
	}
}
// $arrayExample = array('camisas de tenis', 'tenis de basket', 'Zapatillas de running');
// $termToSearch = 'zapatillas';
// $salid = buscarDato($arrayExample,$termToSearch);

// echo('<prev>');
// print_r($salid);
// // echo $salid;
// echo('</prev>');

// $result = array_search(, haystack)



// if ($salid) {
// 	echo "se encontro un elemento";
// 	echo('<prev>');
// print_r($salid);
// // echo $salid;
// echo('</prev>');
// }


// $url = 'https://verystream.com/stream/QPgmGj9XNko';

// $hu = parse_url($url);
// // echo $hu['host'][pat];
// echo('<prev>');
// print_r($hu);
// echo('</prev>');
// echo $hu['host'].$hu['path'];

function borrarLinkk($tabla,$fila,$id)
{

	$sql_editar = 'UPDATE $tabla SET $fila=? WHERE id=?';
	$sentencia_editar = $pdo->prepare($sql_editar);
	$sentencia_editar->execute(array($tvip,$tfree,$iid));

	//cerramos conexión base de datos y sentencia
	$pdo = null; 
	$sentencia_editar = null; 

}

// function b10tobstr($b10){
//   $base = 'ijklGHLMcsFqraPQRtuvwVWXYZmnopIJdeNOyzABfgCDESTUKxbh';
//   $strlen = strlen($base);
// 	$bstr = '';
//   while ($b10>0) {
//     $mod = $b10 % $strlen;
//     $b10 = (int)($b10 / $strlen);
// 		$bstr = $base[$mod].$bstr;
//   }
// 	return $bstr;
// }

// function bstrtob10($str)
// {
// 	$base = 'ijklGHLMcsFqraPQRtuvwVWXYZmnopIJdeNOyzABfgCDESTUKxbh';
// 	$strlen = strlen($base);
// 	$i = strlen($str)-1;
// 	$number = 0;
// 	$pos = 0;
// 	while ($i>=0) {
// 		$aux = $str[$i];
// 		$aux2 = strpos($base,$aux);
// 		if (is_numeric($aux2)){
// 			$number = $number + ($aux2 * pow($strlen,$pos));
// 		} else {
// 			$i = 0;
// 			$number = false;
// 		}
// 		$pos++;
// 		$i--;
// 	}
// 	return $number;
// }





 ?>