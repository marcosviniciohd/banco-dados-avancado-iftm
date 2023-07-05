-- use MePoupe;
-- select * from cliente;
-- select * from conta_corrente;
## 1A) Inserir novas clientes na base de dados
insert into cliente (nome, cpf, sexo, dt_nasc, telefone, email)
values
    ('Maria', '12345678900', 'F', '1990-01-01', '11 99999-9999', 'maria.das.dores@gmail.com');
insert into cliente (nome, cpf, sexo, dt_nasc, telefone, email)
values ('João', '12345678901', 'M', '1977-01-01', '11 99999-9999', 'joao.das.couves@gmail.com');
insert into cliente (nome, cpf, sexo, dt_nasc, telefone, email)
values ('José', '12345678902', 'M', '1980-01-01', '11 99999-9999', 'jose.silva.sauro@gmail.com');
insert into cliente (nome, cpf, sexo, dt_nasc, telefone, email)
values ('Mario', '12345678902', 'M', '1958-07-10', '11 99999-9999', 'mario.silva.sauro@gmail.com');

-- 1B) Inserir novas contas correntes na base de dados
insert into conta_corrente (cod_conta, cod_cliente, saldo, dt_hora_abertura) values (7, 7, 1000, '2023-10-02 00:00:00');
insert into conta_corrente (cod_conta, cod_cliente, saldo, dt_hora_abertura) values (8, 8, 2000, '2023-01-31 00:00:00');
insert into conta_corrente (cod_conta, cod_cliente, saldo, dt_hora_abertura) values (9, 9, 3000, '2022-02-27 00:00:00');
insert into conta_corrente (cod_conta, cod_cliente, saldo, dt_hora_abertura) values (10, 10, 3000, '2023-02-17 00:00:00');

-- 1C) Insira novos registros de saques e depósitos na base de dados
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (1, '2023-02-02 00:00:00', '150.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (2, '2023-02-27 01:00:00', '250.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (3, '2023-01-15 06:00:00', '350.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (4, '2023-01-30 17:00:00', '100.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (5, '2023-02-01 18:00:00', '500.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (6, '2023-02-02 19:00:00', '100.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (7, '2023-02-03 20:00:00', '200.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (8, '2023-02-04 21:00:00', '300.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (9, '2023-02-05 22:00:00', '400.00');
insert into registro_saque (cod_conta, dt_saque, valor_saque) values (10, '2023-02-06 23:00:00', '500.00');

insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (1, '2023-02-02 00:00:00', '350.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (2, '2023-02-27 01:00:00', '450.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (3, '2023-01-15 06:00:00', '550.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (4, '2023-01-30 17:00:00', '673.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (5, '2023-02-01 18:00:00', '100.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (6, '2023-02-02 19:00:00', '200.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (7, '2023-02-03 20:00:00', '300.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (8, '2023-02-04 21:00:00', '400.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (9, '2023-02-05 22:00:00', '500.00');
insert into registro_deposito (cod_conta, dt_deposito, valor_deposito) values (10, '2023-02-06 23:00:00', '600.00');

## Utilizando o operador UNION escreva o comando SQL que irá gerar o relatório
## contendo o nome do cliente, o código da conta e total de depósitos e saques efetuados.
## Obs.: Utilizar a função concat para concatenar “Depositos:” e o total de depositos, e
## “Saques:” com o total de saques. Utilize a função cast para converter o valor decimal
## para char.
(select c.nome, cc.cod_conta, concat('Depositos: ', coalesce(sum(rd.valor_deposito), 0)) operacao
 from registro_deposito rd
          right join conta_corrente cc on cc.cod_conta = rd.cod_conta
          join cliente c on c.cod_cliente = cc.cod_cliente
 group by 1, 2)
union all
(select c.nome, cc.cod_conta, concat('Saques: ', coalesce(sum(rs.valor_saque), 0)) operacao
 from registro_saque rs
          right join conta_corrente cc on cc.cod_conta = rs.cod_conta
          join cliente c on c.cod_cliente = cc.cod_cliente
 group by 1, 2);

## 2) Utilizando operadores de junção de tabelas responda as questões abaixo:
## a) Listar o número da conta, nome, telefone e email dos clientes que são titulares de contas
## que não foram movimentadas nos últimos 6 meses. Considere como operação de
## movimentação saques e depósitos. (Utilize operadores de Junção e Subconsultas para fazer o
## relatório).

select cc.cod_conta, c.nome, c.telefone, c.email
from cliente c
join conta_corrente cc on c.cod_cliente = cc.cod_cliente
where cc.cod_conta not in (select rd.cod_conta from registro_deposito rd
where rd.cod_conta = cc.cod_conta and timestampdiff(month, rd.dt_deposito, now()) >= 6)
and cc.cod_conta not in (select rs.cod_conta from registro_saque rs
where rs.cod_conta = cc.cod_conta and timestampdiff(month, rs.dt_saque, now()) >= 6);

## b) Listar o código da conta, ano, mês, o valor total de saques e o valor total de depositos. Para
## as contas onde não houveram saques imprimir a mensagem “Sem registro de saque”. Para as
## contas onde não houveram depositos imprimir a mensagem “Sem registro de depositos”.
## (Utilizar a função if, operadores de junção e operador UNION ALL).
(select cc.cod_conta, year(rs.dt_saque) ano, month(rs.dt_saque) mes, coalesce(concat('Saque: ', sum(rs.valor_saque)), 'Sem registros de saque') movimento
 from conta_corrente cc
          left join registro_saque rs on cc.cod_conta = rs.cod_conta and month(rs.dt_saque) = 3
 group by 1, 2)
union all
(select cc.cod_conta,
        year(rd.dt_deposito)                                                                 ano,
        month(rd.dt_deposito)                                                                mes,
        coalesce(concat('Deposito: ', sum(rd.valor_deposito)), 'Sem registros de depositos') movimento
 from conta_corrente cc
          left join registro_deposito rd on cc.cod_conta = rd.cod_conta and month(rd.dt_deposito) = 3
 group by 1, 2);

## c) Para o mês atual, listar o número da conta, nome do cliente e a quantidade de saques efetuados na conta. Para as contas onde não houveram saques a quantidade retornada deve ser zero. Utilizar os operadores de junção.
select cc.cod_conta, c.nome, count(rs.cod_saque) qtde_saques
from cliente c
         join conta_corrente cc on c.cod_cliente = cc.cod_cliente
         left join registro_saque rs on cc.cod_conta = rs.cod_conta
group by 1;

## d) Listar o nome do cliente, cpf e número da conta de todos os clientes que são titulares de contas com saldo superior a R$ 100.000,00.
select c.nome, c.CPF, cc.cod_conta
from cliente c
         join conta_corrente cc on c.cod_cliente = cc.cod_cliente
where cc.saldo >= 100000;

## 3) Dê o código SQL correspondente às consultas solicitadas. Utilize subconsultas.
## a) Liste os dados dos clientes que realizaram o maior valor de depósito no mês corrente. Obs.: Eliminar possíveis repetições.
select distinct c.* from cliente c
join conta_corrente cc on c.cod_cliente = cc.cod_cliente
where cc.cod_conta in (select rd.cod_conta from registro_deposito rd where month(rd.dt_deposito) = 3);

## b) b) Listar o cpf, nome, telefone, email e número da conta dos clientes que realizaram saques com valores acima da média durante o ano de 2023.
select c.CPF, c.nome, c.telefone, c.email, cc.cod_cliente from cliente c
join conta_corrente cc on c.cod_cliente = cc.cod_cliente
where (select sum(rd.valor_deposito) from registro_deposito rd where year(rd.dt_deposito) = 2023 and rd.cod_conta = cc.cod_conta) >
      (select avg(rd.valor_deposito) from registro_deposito rd where year(rd.dt_deposito) = 2023);

## c) Listar as informações dos clientes que efetuaram abertura de contas no mês de janeiro ou fevereiro.
select c.* from cliente c
join conta_corrente cc on c.cod_cliente = cc.cod_cliente
where month(cc.dt_hora_abertura) in (1, 2);

## d) Listar o número da conta, saldo e data de abertura de todas as contas criadas no ano de 2023 por clientes do sexo feminino.
select cc.cod_cliente, cc.saldo, cc.dt_hora_abertura from cliente c
join conta_corrente cc on c.cod_cliente = cc.cod_cliente
where year(cc.dt_hora_abertura) = 2023 and c.sexo = 'F';







