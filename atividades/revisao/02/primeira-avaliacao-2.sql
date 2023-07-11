Create database venda_2;
Use venda_2;
/* Criação das tabelas */

create table cliente (
    codCliente int auto_increment primary key,
    Nome varchar(50),
    Endereco varchar(50),
    Telefone varchar(11),
    CNPJ varchar(14)
);

create table categoria(
codCat int auto_increment primary key,
nomeCategoria varchar(50));

create table produto(
codProduto int auto_increment primary key,
nome varchar(30) unique not null,
valorUnit numeric(7,2),
quantidade smallint,
codCat int,
foreign key(codCat) references categoria(codCat));


create table pedido (
    codPedido int auto_increment primary key,
    codCliente int,
    dataCompra date,
    valorTotal numeric(7 , 2 ),
    status varchar(20),
    Foreign key (codcliente)
    references cliente (codCliente)
);

create table itemPedido(
codItem int auto_increment primary key,
codProduto int,
codPedido int,
quantidade smallint,
valorItem numeric(7,2),
Foreign key(codPedido) references pedido(codPedido),
Foreign key(codProduto) references produto(codProduto));

create table entrada (
    cod_Entrada int auto_increment primary key,
    dataEntrada date,
    codProduto int,
    qtdeProd smallint,
    foreign key (codProduto)
    references produto (codProduto)
);

Insert into categoria values(1, "Produtos esportivos");
Insert into categoria values(2, "Produtos de beleza");
Insert into categoria values(3, "Produtos para pesca");
insert into produto values (1,"Bicicleta",500,50,1),(2,"Capacete",50,50,1);
insert into produto values (3,"Oculos",500,30,1),(4,"Sapatilha",50,50,1);
SELECT * from produto;

insert into cliente values(1,"Bic & Companhia","Rua x","32355678","01234567880012");
insert into cliente values(2,"Bic UDI","Rua Y","32355898","01234567880013");
insert into cliente values(3,"Bic UDI","Rua Y","32355898","01234567880013");
insert into cliente values(4,"Bic UDI","Rua Y","32355898","01234567880013");
insert into cliente values(5,"Bic UDI","Rua Y","32355898","01234567880013");

insert into pedido values(1,1,current_date(),null,'PENDENTE');
insert into pedido values(2,1,current_date(),null,'PENDENTE');
insert into pedido values(3,1,'2022-04-01',null,'PENDENTE');
insert into pedido values(4,1,'2022-03-01',10.0,'PAGO');
insert into pedido values(5,1,'2022-03-01',10.0,'PAGO');
insert into pedido values(6,1,'2022-03-01',10.0,'PAGO');
insert into pedido values(7,1,'2022-03-03',10.0,'PAGO');
insert into pedido values(8,1,'2022-03-03',10.0,'PAGO');
insert into pedido values(9,1,'2022-03-03',10.0,'PAGO');

insert into pedido values(10,1,'2023-03-03',10.0,'PAGO');
insert into pedido values(11,1,'2023-03-03',10.0,'PAGO');
insert into pedido values(12,1,'2023-03-03',10.0,'PAGO');
insert into pedido values(13,1,'2023-03-03',10.0,'PAGO');
insert into pedido values(14,1,current_date(),15,'PENDENTE');
insert into pedido values(15,1,current_date(),20,'PENDENTE');

insert into pedido values(16,2,'2023-03-04',10.0,'PAGO');
insert into pedido values(17,2,'2023-03-05',10.0,'PAGO');
insert into pedido values(18,2,'2023-03-06',10.0,'PAGO');
insert into pedido values(19,2,'2023-04-04',10.0,'PAGO');

SELECT * FROM pedido;

desc pedido;

insert into itemPedido values(1,1,1,10,500);
insert into itemPedido values(2,2,1,10,50);
insert into itemPedido values(3,1,2,15,500);
insert into itemPedido values(4,2,2,20,50);

insert into itemPedido values(5,3,3,15,500);
insert into itemPedido values(6,2,3,20,50);

insert into entrada values(1,current_date(),1,30);
insert into entrada values(2,'2023-03-01',1,30);
insert into entrada values(3,'2023-04-01',1,30);
insert into entrada values(4,'2023-03-01',1,30);
insert into entrada values(5,'2023-03-01',1,30);

/*
 ## APARTIR DAQUI COMEÇA AS QUESTÕES
 */

## Conforme o esquema relacional Venda, responda as questões abaixo utilizando a
## linguagem SQL(Operadores de Junção, Funções agregadas e Agrupamento):

## a) Escreva o comando SQL que irá listar o nome, CNPJ e total pago em compras dos
## top-10 clientes(10 maiores compradores) do mês de março de 2023. Considerar para o
## cálculo somente pedidos com status “Pago”.

select c.nome, c.cnpj, sum(ip.valorItem) as totalPago from cliente c
inner join pedido p on c.codCliente = p.codCliente
inner join itemPedido ip on p.codPedido = ip.codPedido
where p.dataCompra between '2023-03-01' and '2023-03-31' and p.status = 'PAGO'
group by c.nome, c.cnpj order by c.nome limit 10;

## b) Faça um relatório com o nome do cliente, o mês e a pontuação mensal do cliente
## dado pelo percentual do total pago em pedidos por mês. Considere o percentual de 1%
## sobre o total pago no mês, pedidos com o status “Pago” e somente pedidos realizados
## neste ano. Ex.: Se o cliente realizou no mês 04 (abril) deste ano pedidos que somam
## um total de R$ 1000 sua pontuação será de 10 pontos neste mês.

select c.nome, month(p.dataCompra) as mes, sum(ip.valorItem) * 0.01 as pontuacao from cliente c
inner join pedido p on c.codCliente = p.codCliente
inner join itemPedido ip on p.codPedido = ip.codPedido
where p.dataCompra between '2023-01-01' and '2023-12-31' and p.status = 'PAGO'
group by c.nome, month(p.dataCompra) order by c.nome, month(p.dataCompra);

## c) Selecione o nome da categoria e a quantidade distinta de produtos por categoria. Se a
## categoria não tiver nenhum produto cadastrado para ela, a quantidade deve vir com o
## valor zero.

select c.nomeCategoria, count(p.codProduto) as quantidade from categoria c
left join produto p on c.codCat = p.codCat
group by c.nomeCategoria;

## d) Listar o nome do produto e a quantidade de itens do produto que fizeram parte dos
## pedidos realizados nos últimos 6 meses.

select p.nome, sum(ip.quantidade) as quantidade from produto p
inner join itemPedido ip on p.codProduto = ip.codProduto
inner join pedido pe on ip.codPedido = pe.codPedido
where pe.dataCompra between '2023-01-01' and '2023-06-30'
group by p.nome;

## Utilizando subconsultas responda as questões abaixo:
## a) Listar o nome, endereço e CNPJ dos clientes que não efetuaram pedidos neste ano (2023).

select nome, endereco, cnpj from cliente where codCliente not in
(select codCliente from pedido where dataCompra between '2023-01-01' and '2023-12-31');

## b) Liste os dados dos Produtos que não foram adquiridos, ou seja, não aparecem na tabela ItemPedido.
select * from produto where codProduto not in (select codProduto from itemPedido);

## c) Liste o CNPJ e nome dos clientes que realizaram pedido com valores acima da média no ano de 2022.

select cnpj, nome from cliente where codCliente in
(select codCliente from pedido where dataCompra between '2022-01-01' and '2022-12-31'
and valorTotal > (select avg(valorTotal) from pedido where dataCompra between '2022-01-01' and '2022-12-31'));

## d) Liste o nome do cliente, data da compra, valor total e status do(s) pedido(s) realizados mais recentemente.

select c.nome, p.dataCompra, p.valorTotal, p.status from cliente c
inner join pedido p on c.codCliente = p.codCliente
where p.dataCompra = (select max(dataCompra) from pedido);

## 3) Utilizando UNION, dê o comando SQL para gerar o seguinte relatório,
## que irá listar o tipo de operação e o mês, o nome do produto e a quantidade pedida ou
## adquirida de cada produto nos meses de março e abril deste ano:

select 'Pedido' as tipoOperacao, month(p.dataCompra) as mes, pr.nome, ip.quantidade from pedido p
inner join itemPedido ip on p.codPedido = ip.codPedido
inner join produto pr on ip.codProduto = pr.codProduto
where p.dataCompra between '2023-03-01' and '2023-04-30'
union
select 'Entrada' as tipoOperacao, month(e.dataEntrada) as mes, pr.nome, e.qtdeProd from entrada e
inner join produto pr on e.codProduto = pr.codProduto
where e.dataEntrada between '2023-03-01' and '2023-04-30'
order by mes, nome;

## 4) Classificar como V ou F. Justificar as falsas.
## a) As visões são tabelas criadas fisicamente no banco de dados.
    ## Falso, as visões são tabelas virtuais, não são criadas fisicamente no banco de dados.

## b) Em uma visão obtida através da junção de tabelas e que contém dados
## de mais de uma tabela, é possível fazer a alteração ( UPDATE) na visão,
## alterando em um mesmo comando UPDATE dados de mais de uma
## tabela.
    ## Falso, não é possível fazer alterações em mais de uma tabela ao mesmo tempo.

## c) Visões que foram criadas a partir de funções de agregação (count, min, max, avg, sum) aceitam as operações de UPDATE, INSERT e DELETE.
    ## Falso, não é possível fazer alterações em visões que foram criadas a partir de funções de agregação.

## d) O comando usado para apagar uma visão é Delete View nome_visão;
    ## Falso, o comando correto é Drop View nome_visão;






