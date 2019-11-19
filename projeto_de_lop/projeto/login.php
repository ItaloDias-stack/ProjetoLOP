<?php

    include 'conexao.php';

    $usuario = $_POST['usuario'];
    $senha = $_POST['senha'];

    $consultar=$connect->query("SELECT * FROM professor WHERE usuario='".$usuario."' and senha='".$senha."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado=$extraerDatos;
    }

    echo json_encode($resultado);

    ?>