#!/usr/bin/php
<?php 
include 'gdclass.php';
use \Marxvn\gdrive;

$result = $argv[1];
$calidadMostrar = $argv[2];

if (strpos($result, 'status=ok') !== false) {

    $gdrive = new gdrive;
    $gdrive->getLink($result);
    $links = json_decode($gdrive->getSources());

    foreach ($links as $key => $value) {
        switch ($value->label) {
            case '360':
                $estado360 = substr($value->file, 0, -9);
                break;
            case '480':
                $estado480 = substr($value->file, 0, -9);
                break;
            case '720':
                $estado720 = substr($value->file, 0, -9);
                break;
            case '1080':
                $estado1080 = substr($value->file, 0, -9);
                break;
            default:
                echo "No hay calidad disponible";
                break;
        }
    }
    
    if ($calidadMostrar == "720p") {
        $mostrar = (!empty($estado720)) ? $estado720 : false;

    }elseif ($calidadMostrar == "1080p") {
        $mostrar = (!empty($estado1080)) ? $estado1080 : false;

    }elseif ($calidadMostrar == "480p") {
        $mostrar = (!empty($estado480)) ? $estado480 : false;

    }elseif ($calidadMostrar == "360p") {
        $mostrar = (!empty($estado360)) ? $estado360 : false;
    }
    echo $mostrar;
    
    // preg_match('/(&fmt_stream_map=)(.*)(&url_encoded_fmt_stream_map)/', $result, $matches);
    // $result = urldecode($matches[2]);
    // $ru = explode('|', $result);
    // // $ru[1] 360
    // // $ru[2] 720
    // // $ru[3] 1080
    // // $ru[4] 480
    // // echo('<pre>');
    // // print_r($ru);
    // // echo('</pre>');

    // $inicial = substr($ru[2], 0, -3);
    // echo $inicial;
}else {
    echo "false";
}

?>  