Create database venda;
-- drop database venda;
Use venda;
/* Criação das tabelas */

Create table cliente (
    cod_cliente int auto_increment primary key,
    nome varchar(50),
    endereco varchar(50),
    telefone varchar(11),
    cpnj varchar(14)
);
alter table cliente change cpnj cnpj varchar(14);

create table categoria(
cod_cat int auto_increment primary key,
nome_categoria varchar(50));

create table produto(
cod_produto int auto_increment primary key,
nome varchar(30) unique not null,
valor_unit numeric(7,2),
quantidade smallint,
cod_cat int,
foreign key(cod_cat) references categoria(cod_cat));




create table pedido(
    cod_pedido int auto_increment primary key,
    cod_cliente int,
    data_compra date,
    valor_total numeric(7 , 2 ),
    status varchar(20),
    Foreign key (cod_cliente)
    references cliente (cod_cliente)
);
Create table item_pedido(
cod_item int auto_increment primary key,
cod_produto int,
cod_pedido int,
quantidade smallint,
valor_item numeric(7,2),
Foreign key(cod_pedido) references pedido(cod_pedido),
Foreign key(cod_produto) references produto(cod_produto));

Create table entrada (
    cod_entrada int auto_increment primary key,
    data_entrada date,
    cod_produto int,
    qtde_prod smallint,
    Foreign key (cod_produto)
    references produto (cod_produto)
);

Insert into categoria values(1, "Produtos esportivos");
insert into produto values (1,"Bicicleta",500,50,1),(2,"Capacete",50,50,1);
insert into produto values (3,"Oculos",500,30,1),(4,"Sapatilha",50,50,1);

insert into cliente values(1,"Bic & Companhia","Rua x","32355678","01234567880012");
insert into cliente values(2,"Bic UDI","Rua Y","32355898","01234567880013");
insert into pedido values(1,1,current_date(),null,'PENDENTE');
insert into pedido values(2,1,current_date(),null,'PENDENTE');

insert into pedido values(3,1,'2022-04-01',null,'PENDENTE');



insert into item_pedido values(1,1,1,10,500);
insert into item_pedido values(2,2,1,10,50);
insert into item_pedido values(3,1,2,15,500);
insert into item_pedido values(4,2,2,20,50);

insert into item_pedido values(5,3,3,15,500);
insert into item_pedido values(6,2,3,20,50);

insert into entrada values(1,current_date(),1,30);

## Conforme o esquema relacional Venda, responda as questões abaixo utilizando a
## linguagem SQL(Operadores de Junção, Funções agregadas e Agrupamento):
## a) Escreva o comando SQL que irá listar o nome, CNPJ e total pago em compras dos
## top-10 clientes(10 maiores compradores) do mês de março de 2023. Considerar para o
## cálculo somente pedidos com status “Pago”.

select c.nome,c.cpnj,sum(ip.valor_item) as total_pago from cliente c
inner join pedido p on c.cod_cliente = p.cod_cliente
inner join item_pedido ip on p.cod_pedido = ip.cod_pedido
where p.data_compra between '2023-03-01' and '2023-03-31' and p.status = 'PAGO';

select c.nome,c.cnpj, sum(ip.valor_item) as total_pago from cliente c
inner join pedido p on c.cod_cliente = p.cod_cliente
inner join item_pedido ip on p.cod_pedido = ip.cod_pedido
where p.data_compra between '2023-03-01' and '2023-03-31' and p.status = 'PAGO';

## b) Faça um relatório com o nome do cliente, o mês e a pontuação mensal do cliente
## dado pelo percentual do total pago em pedidos por mês. Considere o percentual de 1%
## sobre o total pago no mês, pedidos com o status “Pago” e somente pedidos realizados
## neste ano. Ex.: Se o cliente realizou no mês 04 (abril) deste ano pedidos que somam
## um total de R$ 1000 sua pontuação será de 10 pontos neste mês.

select c.nome,month(p.data_compra) as mes, sum(ip.valor_item) as total_pago,
sum(ip.valor_item)*0.01 as pontuacao from cliente c
inner join pedido p on c.cod_cliente = p.cod_cliente
inner join item_pedido ip on p.cod_pedido = ip.cod_pedido
where p.data_compra between '2023-01-01' and '2023-12-31' and p.status = 'PAGO';