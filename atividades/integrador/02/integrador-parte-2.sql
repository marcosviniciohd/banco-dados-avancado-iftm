## 1- Criação de procedimentos:
## a. Crie procedimentos para fazer a inserção/atualização de dados nas tabelas do sistema (ao menos 1 por participante do grupo). Os procedimentos devem incluir a verificação dos campos obrigatórios, caso eles não sejam informados, emitir mensagem de erro.
DELIMITER $
create procedure sp_insert_funcionario (
    @nome varchar(100),
    @data_nasc date,
    @data_adm date,
    @sexo char(1),
    @email varchar(100),
    @cod_cargo int,
    @cod_depto int )
begin
    if @nome is null or @nome = '' then
        select 'O nome deve ser informado';
    elseif @data_nasc is null then
        select 'A data de nascimento deve ser informada';
    elseif @data_adm is null then
        select 'A data de admissão deve ser informada';
    elseif @sexo is null or @sexo = '' then
        select 'O sexo deve ser informado';
    elseif @email is null or @email = '' then
        select 'O email deve ser informado';
    elseif @cod_cargo is null then
        select 'O cargo deve ser informado';
    elseif @cod_depto is null then
        select 'O departamento deve ser informado';
    else
        insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto)
        values (@nome, @data_nasc, @data_adm, @sexo, @email, @cod_cargo, @cod_depto);
    end if;
end $
DELIMITER ;

CALL sp_insert_funcionario('Daniela Oliveira Carvalho', '1995-01-13', '2022-05-30', 'F', 'daniela.carvalho@gmail.com', 1, 1);
CALL sp_insert_funcionario('Marcos Vinício Fernandes', '1984-01-13', '2022-10-22', 'M', 'marcos.fernandes@gmail.com', 1, 2);


## b. Crie procedimentos para gerar relatórios sobre os dados do sistema utilizando funções agregadas e agrupamentos (ao menos 1 por participante do grupo) a partir de um ou mais parâmetros.
DELIMITER $
CREATE PROCEDURE relatorio (parametro1 INT, parametro2 date)
BEGIN
    SELECT f.nome, AVG(f.data_nasc), COUNT(*)
    FROM tb_funcionario f
    WHERE f.id = parametro1 AND f.data_nasc = parametro2
    GROUP BY f.data_adm;
END $
DElIMITER ;

CALL relatorio(1, '1995-01-13');
CALL relatorio(2, '1984-01-13');


DELIMITER $
create procedure sp_relatorio_funcionario (
    cod_cargo int,
    cod_depto int )
begin
    select f.nome, c.nome, d.nome from tb_funcionario f
    inner join tb_cargo c on f.cod_cargo = c.id
    inner join tb_departamento d on f.cod_depto = d.id
    where f.cod_cargo = cod_cargo and f.cod_depto = cod_depto;
end $
DELIMITER ;

CALL sp_relatorio_funcionario(1, 1);
CALL sp_relatorio_funcionario(1, 2);


## c. Crie um procedimento que gere um relatório a partir da junção de 2 ou mais tabelas (ao menos 1 por participante do grupo). Utilize operadores de junção.
DELIMITER $
create procedure sp_relatorio_funcionario_cargo (
    var_cod_cargo int,
    var_cod_depto int )
begin
    select f.nome, c.nome, d.nome from tb_funcionario f
    inner join tb_cargo c on f.cod_cargo = c.id
    inner join tb_departamento d on f.cod_depto = d.id
    where f.cod_cargo = var_cod_cargo and f.cod_depto = var_cod_depto;
end $
DELIMITER ;

CALL sp_relatorio_funcionario_cargo(1, 1);
CALL sp_relatorio_funcionario_cargo(2, 2);
CALL sp_relatorio_funcionario_cargo(3, 2);

## 2- Criação de funções
## a. Crie funções para realizar alguma funcionalidade válida no contexto do sistema.
## i. Aplicação: Formatação de dados, cálculos gerais com valores
## ou datas, mapeamentos de dados, etc.
## Obs.: Cada elemento do grupo deve criar ao menos uma função
## específica, a outra função será avaliada para o grupo todo.
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $
create function f_funcionario (var_cod_funcionario int)
returns varchar(100)
begin
    declare var_nome varchar(100);
    select nome into var_nome from tb_funcionario where id = var_cod_funcionario;
    return var_nome;
end $
DELIMITER ;

select f_funcionario(1);
select f_funcionario(2);
select f_funcionario(3);


SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER |
CREATE FUNCTION calcular_idade (data_nascimento DATE)
RETURNS INT
BEGIN
    DECLARE idade INT;
    SET idade = FLOOR(DATEDIFF(CURDATE(), data_nascimento) / 365.25);
    RETURN idade;
END |
DELIMITER ;

select calcular_idade('1995-01-13');
select calcular_idade('1984-01-13');
select calcular_idade('1990-01-13');



SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $
create function f_soma_salario (var_cod_cargo int)
returns decimal(10,2)
begin
    declare var_soma_salario decimal(10,2);
    select sum(salario) into var_soma_salario from tb_cargo where tb_cargo.id = var_cod_cargo;
    return var_soma_salario;
end $
DELIMITER ;

select f_soma_salario(1);
select f_soma_salario(2);
select f_soma_salario(3);

## 3- Criação de triggers
##a. Crie triggers que realizem alguma funcionalidade válida no contexto do sistema.
## i. Aplicação: Verificação de restrição e regras de negócios,
## atualização automática de um campo da tabela mediante
## determinada condição, backup dos dados excluídos/atualizados
## para realização de auditoria, etc.

DELIMITER $
create trigger tg_insert_funcionario before insert on tb_funcionario for each row
begin
    if new.nome is null or new.nome = '' then
        signal sqlstate '45000' set message_text = 'O nome deve ser informado';
    elseif new.data_nasc is null then
        signal sqlstate '45000' set message_text = 'A data de nascimento deve ser informada';
    elseif new.data_adm is null then
        signal sqlstate '45000' set message_text = 'A data de admissão deve ser informada';
    elseif new.sexo is null or new.sexo = '' then
        signal sqlstate '45000' set message_text = 'O sexo deve ser informado';
    elseif new.email is null or new.email = '' then
        signal sqlstate '45000' set message_text = 'O email deve ser informado';
    elseif new.cod_cargo is null then
        signal sqlstate '45000' set message_text = 'O cargo deve ser informado';
    elseif new.cod_depto is null then
        signal sqlstate '45000' set message_text = 'O departamento deve ser informado';
    end if;
end;
DELIMITER ;

insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto) values ('', '1995-01-13', '2022-05-30', 'F', 'daniela@gmail.com', 1, 1);
insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto) values ('Daniela', null, '2022-05-30', 'F', '', 1, 1);
insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto) values ('Daniela', '1995-01-13', null, 'F', '', 1, 1);
insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto) values ('Daniela', '1995-01-13', '2022-05-30', '', '', 1, 1);



DELIMITER $
create trigger tg_insert_cargo before insert on tb_cargo for each row
begin
    if new.nome is null or new.nome = '' then
        signal sqlstate '45000' set message_text = 'O nome deve ser informado';
    elseif new.salario is null then
        signal sqlstate '45000' set message_text = 'O salário deve ser informado';
    elseif new.salario < (select salario from tb_cargo where id = new.id) then
        signal sqlstate '45000' set message_text = 'O salário deve ser maior que o salário mínimo do cargo';
    end if;
end;
DELIMITER ;

insert into tb_cargo (nome, salario) values ('', 1000);
insert into tb_cargo (nome, salario) values ('Engenheiro de Dados', 1000);




DELIMITER $
create trigger tg_backup_funcionario after insert on tb_funcionario for each row
begin
    insert into tb_funcionario_backup
    (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto)
    values (new.nome, new.data_nasc, new.data_adm, new.sexo, new.email, new.cod_cargo, new.cod_depto);
end;
DELIMITER ;

insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto) values ('Dalila', '1996-05-30', '2022-05-30', 'F', 'dalila@gmail.com', 4, 4);
insert into tb_funcionario (nome, data_nasc, data_adm, sexo, email, cod_cargo, cod_depto) values ('Antonio Juventino', '1953-12-31', '2002-08-15', 'M', 'antonio@gmail.com', 5, 5);
select * from tb_funcionario_backup;