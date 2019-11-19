<?php
include 'conexao.php';

$id_turma = $_POST['id_turma'];
$queryResult=$connect->query(" SELECT * FROM chamada where id_turma = '".$id_turma."' ");

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

?>