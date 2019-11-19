<?php

	include 'conexao.php';

	$id_aluno = $_POST['id_aluno'];
	$id_turma = $_POST['id_turma'];

	$sql =  "INSERT INTO aluno_turma(id_turma,id_aluno) VALUES ('".$id_turma."','".$id_aluno."')";
	$exeQuery = mysqli_query($connect, $sql) ;
?>