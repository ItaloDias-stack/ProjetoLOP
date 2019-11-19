<?php
	include 'conexao.php';
	$cod = $_POST['cod'];
	$nome_turma = $_POST['nome_turma'];
	$id_prof = $_POST['id_prof'];

	$consultar=$connect->query("SELECT * FROM turma WHERE cod='".$cod."' and nome_turma='".$nome_turma."'");
	$resultado=array();

	while($extraerDatos=$consultar->fetch_assoc()){
        $resultado=$extraerDatos;
    }

    if($resultado== null){
    	$sql =  "INSERT INTO turma(cod,nome_turma,id_prof) VALUES ('".$cod."','".$nome_turma."','".$id_prof."')";
		$exeQuery = mysqli_query($connect, $sql) ;
		echo json_encode(array('message' =>'true'));
    }else{
    	$arr = array('message' => 'false');
    	echo json_encode($arr);
    }

?>