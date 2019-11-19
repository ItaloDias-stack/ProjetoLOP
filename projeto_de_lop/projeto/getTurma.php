<?php
include 'conexao.php';

$id_prof = $_POST['id_prof'];
$queryResult=$connect->query("SELECT * FROM turma WHERE id_prof='".$id_prof."'");

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

?>
