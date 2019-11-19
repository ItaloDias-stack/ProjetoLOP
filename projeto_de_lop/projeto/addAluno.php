<?php

    include 'conexao.php';

    $nome = $_POST['nome'];
    $codigo = $_POST['codigo'];
    $matricula = $_POST['matricula'];


	$queryResult=$connect->query("SELECT * FROM aluno WHERE codigo='".$codigo."' and nome='".$nome."' and matricula='".$matricula."'");
	$result=array();

	while($fetchData=$queryResult->fetch_assoc()){
		$result=$fetchData;
	}

	if($result== null){
    	$sql =  "INSERT INTO aluno(codigo,nome,matricula) VALUES ('".$codigo."','".$nome."','".$matricula."')";
		$exeQuery = mysqli_query($connect, $sql) ;
		echo json_encode(array('message' =>'true'));
    }else{
    	$arr = array('message' => 'false');
    	echo json_encode($arr);
    }


?>