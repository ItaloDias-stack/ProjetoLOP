<?php
include 'conexao.php';

$id_turma = $_POST['id_turma'];
$id_aluno = $_POST['id_aluno'];


$queryResult3=$connect->query("DELETE FROM aluno WHERE id_aluno='".$id_aluno."'");

$queryResult4=$connect->query("DELETE FROM chamada WHERE id_turma='".$id_turma."'");

$queryResult2=$connect->query("DELETE FROM aluno_turma WHERE id_turma='".$id_turma."'");

$queryResult=$connect->query("DELETE FROM turma WHERE id_turma='".$id_turma."'");
?>