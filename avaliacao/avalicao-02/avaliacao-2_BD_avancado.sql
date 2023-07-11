use evenIFTM;

DELIMITER $
create procedure sp_inserir_incricao(var_cpf char(11), var_code_atividade INT, var_data_inscricao datetime)
    BEGIN
        if not exists (select * from Usuario where cpf = var_cpf) then
            insert into Usuario (cpf) values (var_cpf);
            insert into Atividade (cod_atividade) values (var_code_atividade);
            insert into Inscricao (dt_inscricao) values (var_data_inscricao);
        end if;
    END $
DELIMITER ;

## Exemplo de chamada do procedimento
call sp_inserir_incricao('12345678901', 2, current_date());


-- Faça o procedimento sp_listar_atividades para listar o nome da atividade, categoria da atividade e valor de inscrição de acordo com o ano de realização.  O procedimento receberá como entrada o ano de realização e caso essa informação seja null, listar todas as atividades cadastradas.
DELIMITER $
create procedure sp_listar_atividades(var_ano_realizacao year)
    BEGIN
        if (var_ano_realizacao) is null then
            select * from Atividade;
        else
            select titulo, cod_categoria, valor_ingresso from Atividade where dt_realizacao = var_ano_realizacao;
        end if;
    END $$
DELIMITER ;

## Exemplo de chamada do procedimento
call sp_listar_atividades(null);


-- Crie a função func_to_Date que irá receber como dado de entrada um conjunto de caracteres correspondente a uma data no padrão brasileiro  e irá retornar uma data padrão (date).  Ex. entrada: 12/05/2021 Saída: 2021-05-12
DELIMITER $
create function func_to_Date(var_data varchar(10))
    returns date
    BEGIN
        return str_to_date(var_data, '%d/%m/%Y');
    END $
DELIMITER ;

## Exemplo de chamada da função
select func_to_Date('12/05/2021');

-- Crie uma função chamada func_nro_mes que receba como entrada o número mês e retorne o nome do mês correspondente. Caso seja um número de mês inválido, retornar  Número inválido.
DELIMITER $
create function func_nro_mes(var_mes int)
    returns varchar(20)
    BEGIN
        if var_mes = 1 then
            return 'Janeiro';
        elseif var_mes = 2 then
            return 'Fevereiro';
        elseif var_mes = 3 then
            return 'Março';
        elseif var_mes = 4 then
            return 'Abril';
        elseif var_mes = 5 then
            return 'Maio';
        elseif var_mes = 6 then
            return 'Junho';
        elseif var_mes = 7 then
            return 'Julho';
        elseif var_mes = 8 then
            return 'Agosto';
        elseif var_mes = 9 then
            return 'Setembro';
        elseif var_mes = 10 then
            return 'Outubro';
        elseif var_mes = 11 then
            return 'Novembro';
        elseif var_mes = 12 then
            return 'Dezembro';
        else
            return 'Número inválido';
        end if;
    END $$
DELIMITER ;

-- Crie o trigger tr_valida_data que antes da inserção de uma atividade verifique se a data de inicio das inscrições não é maior que a data de término das inscrições. Se for, gerar um erro.
DELIMITER $
create trigger tr_valida_data
    before insert on Atividade
    for each row
    BEGIN
        if new.dt_inicio_inscricao > new.dt_fim_inscricao then
            signal sqlstate '45000' set message_text = 'Data de inicio das inscrições não pode ser maior que a data de término das inscrições';
        end if;
    END $$
DELIMITER ;

-- Crie um trigger tr_valida_idade que antes da inserção na tabela usuario verifique se o usuário que está sendo cadastrado atende a restrição de ter idade mínima de 12 anos.  Caso seja menor de 12 anos gerar um erro.
DELIMITER $
create trigger tr_valida_idade
    before insert on Usuario
    for each row
    BEGIN
        if (year(curdate()) - year(new.dt_nasc)) < 12 then
            signal sqlstate '45000' set message_text = 'Usuário não pode ter menos de 12 anos';
        end if;
    END $$
DELIMITER ;

