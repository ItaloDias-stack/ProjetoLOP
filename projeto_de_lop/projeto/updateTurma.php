<?php
	include 'conexao.php';
	$id_turma = $_POST['id_turma'];
	$nome_turma = $_POST['nome_turma'];
	$cod = $_POST['cod'];

	$consultar=$connect->query("SELECT * FROM turma WHERE cod='".$cod."' and nome_turma='".$nome_turma."'");
	$resultado=array();

	while($extraerDatos=$consultar->fetch_assoc()){
        $resultado=$extraerDatos;
    }

	
    if ($resultado==null) {
		$connect->query("UPDATE turma SET nome_turma='".$nome_turma."', cod='".$cod."' WHERE id_turma=". $id_turma);
		echo json_encode(array('message' =>'true'));
	}else{
		echo json_encode(array('message' =>'false'));
	}

?>