## 1) Criação do Modelo Físico (create database, create table).
create database startup_dev;
use startup_dev;
## Criação das tabelas.
create table tb_cargo (
    id int primary key auto_increment,
    nome varchar(20) not null,
    nivel varchar(10),
    salario float
);

create table tb_funcionario (
    id int primary key auto_increment,
    nome varchar(50) not null,
    data_nasc date,
    data_adm date,
    sexo char(1),
    email varchar(30) not null,
    cod_cargo int not null,
    cod_depto int not null,
    foreign key (cod_cargo) references tb_cargo(id),
    foreign key (cod_depto) references tb_departamento(id)
);

create table tb_departamento (
    id int primary key auto_increment,
    nome varchar(20) not null,
    sigla varchar(10)
);

## 2) Modelo lógico relacional em diagrama gerado por engenharia reversa no MySQL Workbench.
        ## Anexado no diretório do projeto.

## 3) Carga de dados.. Os dados inseridos tem que simular dados reais. Fazer
## uma distribuição dos dados de forma a ter a representação de diferentes
## grupos. Ex.: Caso a base de dados tenha dados de Pessoa/Cliente inserir
## dados de diferentes faixas etárias, sexo masculino e feminino, etc.

insert into tb_cargo (nome, nivel, salario) values ('Gerente', 'Senior', 10000);
insert into tb_cargo (nome, nivel, salario) values ('Analista', 'Pleno', 5000);
insert into tb_cargo (nome, nivel, salario) values ('Programador', 'Junior', 3000);
insert into tb_cargo (nome, nivel, salario) values ('Programador', 'Pleno', 5000);
insert into tb_cargo (nome, nivel, salario) values ('Programador', 'Senior', 10000);
insert into tb_cargo (nome, nivel, salario) values ('Analista', 'Junior', 7000);
insert into tb_cargo (nome, nivel, salario) values ('Analista', 'Senior', 11000);
select * from tb_cargo;

insert into tb_departamento (nome, sigla) values ('Desenvolvimento', 'DEV');
insert into tb_departamento (nome, sigla) values ('Recursos Humanos', 'RH');
insert into tb_departamento (nome, sigla) values ('Financeiro', 'FIN');
insert into tb_departamento (nome, sigla) values ('Juridico', 'JUR');
insert into tb_departamento (nome, sigla) values ('Pesquisa', 'PES');

insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto)
values
    ('João das Dores', '1970-01-01', '2010-01-01', 'M', 'joao@gmail.com', 1, 1),
    ('Maria das Dores', '1975-01-05', '2010-01-01', 'F', 'maria@gmail.com', 2, 1),
    ('José das Couves', '1980-02-01', '2009-01-01', 'M', 'jose.couves@gmail.com', 3, 1),
    ('Joana da Silva Sauro', '1985-02-05', '2012-01-01', 'F', 'joana.sauro@gmail.com',2, 1),
    ('João da Silva Sauro', '1985-02-05', '2012-01-01', 'M', 'joao.silva.sauro@gmail.com',2, 2),
    ('Marcos Vinício Fernandes', '1986-04-04', '2021-10-19', 'M', 'marcos.fernandes@gmail.com',3, 1),
    ('Ana Maria da Silva', '1987-05-05', '2021-10-19', 'F', 'ana.maria@gmail.com',3, 2),
    ('Maria Aparecida', '1988-06-06', '2021-10-19', 'F', 'maria.aparecida@gmail.com',3, 3),
    ('Daniela Oliveira Carvalho', '1995-01-13', '2022-05-30', 'F', 'daniela@gmail.com', 1, 3);

## 4) Criar relatórios sobre os dados usando o comando SELECT com subconsultas. Deve ser realizado ao menos 2 relatórios por participante.
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Gerente');
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Analista');
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Programador');
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Programador' and c.nivel = 'Junior');
select f.nome, f.sexo from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Analista' and c.nivel = 'Pleno');
select d.nome from tb_departamento d where d.id in
   (select f.cod_depto from tb_funcionario f where f.cod_cargo in
   (select c.id from tb_cargo c where c.nome = 'Analista' and c.nivel = 'Pleno'));

## 5) Criar relatórios sobre os dados usando o comando SELECT com JOIN. Deve ser realizado ao menos 2 relatórios por participante.
select f.nome, c.nome from tb_funcionario f inner join tb_cargo c on f.cod_cargo = c.id;
select f.nome, c.nome from tb_funcionario f inner join tb_cargo c on f.cod_cargo = c.id where c.nome = 'Analista';
select f.nome, c.nome from tb_funcionario f inner join tb_cargo c on f.cod_cargo = c.id where c.nome = 'Programador';
select f.nome, c.nome from tb_funcionario f inner join tb_cargo c on f.cod_cargo = c.id where c.nome = 'Programador' and c.nivel = 'Junior';
select f.nome, c.nome from tb_funcionario f inner join tb_cargo c on f.cod_cargo = c.id where c.nome = 'Analista' and c.nivel = 'Pleno';
select f.nome, d.nome from tb_funcionario f inner join tb_departamento d on f.cod_depto = d.id where d.nome = 'Desenvolvimento';

## 6) Criar 2 relatórios usando operador UNION/UNION ALL
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Gerente')
union
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Analista');

select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Gerente')
union all
select f.nome from tb_funcionario f where f.cod_cargo in (select c.id from tb_cargo c where c.nome = 'Analista');

## 7) Criar 3 visões sobre os dados.
create view vw_funcionario as select * from tb_funcionario;
create view vw_cargo as select * from tb_cargo;
create view vw_departamento as select * from tb_departamento;




## Produto cartesiano.
select * from tb_funcionario, tb_cargo;

## Inner join. (Junção)
select * from tb_funcionario f inner join tb_cargo c on f.cod_cargo = c.id;

select nome_func.nome, nome_cargo.nome
from tb_funcionario nome_func
    inner join tb_cargo nome_cargo on nome_func.cod_cargo = nome_cargo.id;
