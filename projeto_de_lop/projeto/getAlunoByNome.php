<?php
include 'conexao.php';

$nome = $_POST['nome'];
$matricula = $_POST['matricula'];
$queryResult=$connect->query("SELECT * FROM aluno WHERE nome='".$nome."' and matricula='".$matricula."'");

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result=$fetchData;
}

echo json_encode($result);

?>