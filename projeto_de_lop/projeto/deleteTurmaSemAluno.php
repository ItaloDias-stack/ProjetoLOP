<?php
include 'conexao.php';

$id_turma = $_POST['id_turma'];

$queryResult=$connect->query("DELETE FROM turma WHERE id_turma='".$id_turma."'");

?>