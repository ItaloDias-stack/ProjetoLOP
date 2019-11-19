<?php

	include 'conexao.php';
	
	$usuario = $_POST['usuario'];
	$senha = $_POST['senha'];
	$nome = $_POST['nome'];
		
	$consultar=$connect->query("SELECT * FROM professor WHERE usuario='".$usuario."'");
	$resultado=array();

	while($extraerDatos=$consultar->fetch_assoc()){
        $resultado=$extraerDatos;
    }

	if ($resultado==null) {
		$sql =  "INSERT INTO professor(usuario,senha,nome) VALUES ('".$usuario."','".$senha."','".$nome."')";
		$exeQuery = mysqli_query($connect, $sql) ;
		echo json_encode(array('message' =>'true'));
    }else{
    	$arr = array('message' => 'false');
    	echo json_encode($arr);
    }
	

?>