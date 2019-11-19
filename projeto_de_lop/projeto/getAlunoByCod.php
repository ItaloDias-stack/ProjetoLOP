<?php
include 'conexao.php';

$cod = $_POST['cod'];

$queryResult=$connect->query("SELECT id_aluno FROM aluno WHERE codigo='".$cod."'");

$result=array();
$id_aluno;
while($row=$queryResult->fetch_assoc()){
	$id_aluno = $row["id_aluno"];
}

$sql =  "INSERT INTO chamada(cod,nome_turma,id_prof) VALUES ('".$cod."','".$nome_turma."','".$id_prof."')";
echo json_encode($result);

?>