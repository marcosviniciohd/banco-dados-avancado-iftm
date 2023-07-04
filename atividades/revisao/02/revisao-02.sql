-- 1) Gerar o script SQL contendo o código necessário para realizar as seguintes
-- atividades:
-- Executar o script de criação da base de dados brasil. Obs.: Os valores do PIB estão representados em bilhões.
-- 1. De acordo com esses dados, dê a consulta SQL para gerar os seguintes relatórios:
-- a. Listar em ordem decrescente os 10 estados com maior PIB (Top 10) em 2010.
select  e.nome, pe.valor_pib from estado e, pib_estado pe order by pe.valor_pib desc limit 10;

-- b. Para todos os estados, listar o nome do estado e sua média de PIB.
select e.nome, avg(pe.valor_pib) from estado e, pib_estado pe where e.id = pe.id_estado group by e.nome;

-- c. Listar o ano e o PIB total do país para cada ano.
select ano_pib, sum(valor_pib) from pib_estado group by ano_pib;

-- d. O nome do estado e o percentual de aumento (ou decréscimo)
-- observado no PIB de 2015 em relação a 2010.
select e.nome,
   (pe.valor_pib - (select valor_pib from pib_estado where id_estado = e.id and ano_pib = 2010))
   / (select valor_pib from pib_estado where id_estado = e.id and ano_pib = 2010) * 100 as percentual from estado e,
   pib_estado pe where e.id = pe.id_estado and pe.ano_pib = 2015;

-- e. O nome do estado, quantidade de cidades, e o PIB por cidade (considerar a divisão igualitária entre as cidades do estado).
-- i. Considerando somente o ano de 2017.
select estado.nome, count(*), pe.valor_pib / count(*)
from estado
         join cidade c on estado.id = c.id_estado
         join pib_estado pe on estado.id = pe.id_estado
where pe.ano_pib = 2017
group by 1;

-- f. Listar o ano, a região, o valor do PIB correspondente a ela, bem como o menor e o maior valor do PIB para cada ano.
select regiao, sum(pe.valor_pib) * 100 / (select sum(pe2.valor_pib) from pib_estado pe2 where pe2.ano_pib = 2017)
from estado
         join pib_estado pe on estado.id = pe.id_estado
where ano_pib = 2017
group by 1;

-- g. Considerando o PIB do ano de 2017, listar a região e o percentual de
-- participação da região em relação ao PIB total do país.
select regiao, sum(pe.valor_pib) * 100 / (select sum(pe2.valor_pib) from pib_estado pe2 where pe2.ano_pib = 2017)
from estado
         join pib_estado pe on estado.id = pe.id_estado
where ano_pib = 2017
group by 1;

-- h. Listar as informações de todos os estados que tiveram PIB superior ao
-- PIB de Goiás no ano de 2015.
select *
from estado
         join pib_estado pe on estado.id = pe.id_estado
where ano_pib = 2015
and valor_pib >= (select pe2.valor_pib from pib_estado pe2 where pe2.ano_pib = 2015 and pe2.id_estado = 9);

-- i. Listar os estados que tiveram PIB abaixo da média no ano de 2017.
select *
from estado
         join pib_estado pe on estado.id = pe.id_estado
where ano_pib = 2017
  and valor_pib <= (select avg(pe2.valor_pib) from pib_estado pe2 where pe2.ano_pib = 2017);