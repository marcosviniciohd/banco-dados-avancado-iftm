create database theGame;
use theGame;

create table Jogador(
cod_jogador int primary key,
nome varchar(50),
nickname varchar(20),
sexo char(1),
email varchar(100),
dt_nasc date,
pontuacao int,
moedas int);

insert into Jogador
values(1,"Roberto Carlos","robcar","M","robcar@gmail.com","2000-08-07",1000,3000),
(2,"Maria Clara","marcla","F","marcla@gmail.com","1999-05-07",5000,500),
(3,"João Marcos","jomar","M","jomar@gmail.com","1998-01-15",1000,5000),
(4,"Karina Jones","kjones","F","kjones@yahoo.com","1999-03-05",1000,8000);

create table poder(
cod_poder int primary key,
habilidade varchar(40));
insert into poder values
(1,"Choque do trovão"),
(2,"Bola elétrica"),
(3,"Ataque rápido"),
(4,"Cauda de ferro"),
(5,"Teia Elétrica"),
(6,"Jato de Bolhas"),
(7,"Redomoinho");

create table Adquire_poder(
cod_aquisicao int primary key,
cod_jogador int,
cod_poder int,
dt_hora_aquisicao datetime,
foreign key(cod_jogador) references Jogador(cod_jogador),
foreign key(cod_poder) references poder(cod_poder));

insert into Adquire_poder values
(1,1,1,"2021-06-20 19:00:00"),
(2,1,2,"2021-06-21 10:00:00"),
(3,2,1,"2021-06-21 11:00:00"),
(4,2,3,"2021-06-23 13:00:00"),
(5,2,4,"2021-06-24 15:00:00"),
(6,3,4,"2021-06-25 12:00:00"),
(7,3,5,"2021-06-26 08:00:00"),
(8,4,6,"2021-06-26 12:00:00");

create table Cenario(
cod_cenario int primary key,
caracteristicas varchar(30),
qtde_min_pontos int);

insert into Cenario values
(1,"Terrestre",1000),
(2,"Aquatico",2500),
(3,"Espacial",5000);

create table Partida(
cod_partida int primary key,
data_hora_inicio datetime,
data_hora_termino datetime,
pontos_obtidos int,
cod_jogador int,
cod_cenario int,
foreign key(cod_jogador) references Jogador(cod_jogador),
foreign key(cod_cenario)  references Cenario(cod_cenario));

insert into Partida values
(1,"2021-06-27 19:00:00","2021-06-27 20:00:00",300,1,1),
(2,"2021-06-27 19:30:00","2021-06-27 21:00:00",500,2,1),
(3,"2021-06-28 08:00:00","2021-06-28 12:00:00",200,3,1),
(4,"2021-06-28 08:30:00","2021-06-28 11:30:00",200,1,2);

-- 1A) Liste o nickname do jogador,sexo,pontuação, moeda, habilidade do poder e data e hora de aquisição do poder para todos os jogadores cadastrados. Ordene o resultado pela data de aquisição, da mais recente para a mais antiga.
select j.nickname,j.sexo,j.pontuacao,j.moedas,p.habilidade,a.dt_hora_aquisicao from Jogador j
inner join Adquire_poder a on j.cod_jogador = a.cod_jogador
inner join poder p on a.cod_poder = p.cod_poder
order by a.dt_hora_aquisicao desc;

-- 1B) Liste codigo da partida, data de inicio e data de término, pontos obtidos e características do cenário de todas as partidas jogadas pela jogadora Roberto Carlos.
select p.cod_partida,p.data_hora_inicio,p.data_hora_termino,p.pontos_obtidos,c.caracteristicas from Partida p
inner join Cenario c on p.cod_cenario = c.cod_cenario
inner join Jogador j on p.cod_jogador = j.cod_jogador
where j.nome = 'Roberto Carlos';

-- 1C) Liste as informações dos jogadores que jogaram partidas fora do cenário Terrestre.
select distinct Jogador.* from Jogador
inner join Partida on Jogador.cod_jogador = Partida.cod_jogador
inner join Cenario on Partida.cod_cenario = Cenario.cod_cenario
where Cenario.caracteristicas != 'Terrestre';

-- 1D) Liste o nome, sexo e ano de nascimento dos jogadores que jogaram partidas no periodo diurno (antes das 18:00:00) no mês de junho desse ano.
select j.nome, j.sexo, year(j.dt_nasc), p.data_hora_inicio from Jogador j
inner join Partida p on j.cod_jogador = p.cod_jogador
where month(p.data_hora_inicio) = 6 and hour(p.data_hora_inicio) < 18;

-- 1E) Liste as habilidades dos poderes adquiridos pela jogadora Maria Clara no mês de junho desse ano (2021).
select p.habilidade from poder p
inner join Adquire_poder a on p.cod_poder = a.cod_poder
inner join Jogador j on a.cod_jogador = j.cod_jogador
inner join Partida pa on j.cod_jogador = pa.cod_jogador
where j.nome = 'Maria Clara' and month(pa.data_hora_inicio) = 6 and year(pa.data_hora_inicio) = 2021;

-- 2A) Liste o nickname do jogador e a quantidade de partidas realizadas.
select j.nickname, count(p.cod_partida) from Jogador j, Partida p
where j.cod_jogador = p.cod_jogador group by j.nickname;

-- 2B) Liste o mês, dia e a quantidade de partidas realizadas no mês e dia, considere somente partidas do ano 2021.
select month(p.data_hora_inicio), day(p.data_hora_inicio), count(p.cod_partida) from Partida p
where year(p.data_hora_inicio) = 2021 group by month(p.data_hora_inicio), day(p.data_hora_inicio);

-- 2C) Liste o nome do jogador e total de pontos obtidos pelo jogador em partidas. Considere somente jogadores que tiverem um total de pontos superior a 200.
select j.nome, sum(p.pontos_obtidos) from Jogador j, Partida p
where j.cod_jogador = p.cod_jogador group by j.nome having sum(p.pontos_obtidos) > 200;

-- 2D) Liste a caracteristica do cenário e a quantidade de partidas realizadas em cada cenário.
select c.caracteristicas, count(p.cod_partida) from Cenario c, Partida p
where c.cod_cenario = p.cod_cenario group by c.caracteristicas;

-- 2E) Liste o nome do jogador e a quantidade de poderes adquiridos pelo jogador, ordenando em ordem crescente.
select j.nome, count(a.cod_poder) from Jogador j, Adquire_poder a
where j.cod_jogador = a.cod_jogador group by j.nome order by count(a.cod_poder);

