create database projeto;
use projeto;
create table Turma(
id_turma int not null auto_increment,
cod varchar(50),
nome_turma varchar(50),
primary key(id_turma),
id_prof int
);
create table Aluno(
 id_aluno int not null auto_increment,
 nome varchar(50) not null,
 codigo int not null,
 matricula int,
 primary key(id_aluno)
);

create table Chamada(
	id_chamada int not null auto_increment primary key,
    id_turma int,
    dia varchar(50),
    id_aluno int
);
create table Professor(
id_prof int not null auto_increment,
nome varchar(50),
usuario varchar(50),
senha varchar(50),
primary key(id_prof)
);
create table Aluno_Turma(
id int auto_increment primary key,
id_aluno int,
id_turma int
);

alter table Turma add foreign key(id_prof) references Professor(id_prof);
alter table Chamada add foreign key(id_turma) references Turma(id_turma);
alter table Chamada add foreign key(id_aluno) references Aluno(id_aluno);
alter table Aluno_Turma add foreign key(id_turma) references Turma(id_turma);
alter table Aluno_Turma add foreign key(id_aluno) references Aluno(id_aluno);
alter table Aluno change codigo codigo long;
alter table Aluno change matricula matricula long;
