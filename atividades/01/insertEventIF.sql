insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('marcosviniciohd', 'M', '1986-04-04', 'marcosviniciohd@hotmail.com', '12345678910');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('marilianfernandes', 'F', '1984-10-20', 'marilia@gmail.com', '22345678910');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('danielaooc', 'F', '1995-01-13', 'daniela@gmail.com', '55545678910');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('viniciusedu', 'M', '2009-12-12', 'vinicius_edu@gmail.com', '10101212121');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('marinanovais', 'F', '2012-01-24', 'marinanovais@gmail.com', '24241212121');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('hewyllennovaisap', 'F', '2004-11-24', 'hewyllenap@gmail.com', '24111212121');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('doroteiacampos', 'F', '1938-07-10', 'doroteiacampos@gmail.com', '10071212121');
insert into Usuario (nome_user, sexo, dt_nasc, email, cpf) VALUES ('nataliciocampos', 'M', '1967-10-25', 'nataliciocampos@gmail.com', '25101212121');
select * from Usuario;
-- ########################################################################################################################################################################

insert into Categoria (nome_categoria) values ('Ensino');
insert into Categoria (nome_categoria) values ('Pesquisa');
insert into Categoria (nome_categoria) values ('Extensão');
select * from Categoria;

-- ########################################################################################################################################################################
insert into Atividade (titulo, carga_horaria, tipo_atividade, dt_inicio_inscricao, dt_fim_inscricao, dt_realizacao, valor_ingresso, cod_categoria) values ('Workshop', 40, 'Palestra', '2023-04-03 07:00:00', '2023-04-15 00:00:00', '2023-04-20 19:00:00', 15.00, 3);
insert into Atividade (titulo, carga_horaria, tipo_atividade, dt_inicio_inscricao, dt_fim_inscricao, dt_realizacao, valor_ingresso, cod_categoria) values ('Curso de robótica', 30, 'Palestra', '2023-04-03 07:00:00', '2023-04-15 00:00:00', '2023-04-20 19:00:00', 50.00, 1);
insert into Atividade (titulo, carga_horaria, tipo_atividade, dt_inicio_inscricao, dt_fim_inscricao, dt_realizacao, valor_ingresso, cod_categoria) values ('Atividade fora do campus', 15, 'Roda de Conversa', '2023-04-03 07:00:00', '2023-04-15 00:00:00', '2023-04-20 09:00:00', 15.00, 2);
insert into Atividade (titulo, carga_horaria, tipo_atividade, dt_inicio_inscricao, dt_fim_inscricao, dt_realizacao, valor_ingresso, cod_categoria) values ('Curso sobre desenvolvimento de jogos', 40, 'Mesa Redonda', '2023-04-03 07:00:00', '2023-04-15 00:00:00', '2023-04-20 19:00:00', 100.00, 1);
insert into Atividade (titulo, carga_horaria, tipo_atividade, dt_inicio_inscricao, dt_fim_inscricao, dt_realizacao, valor_ingresso, cod_categoria) values ('Palestra sobre a sindrome do impostor', 10, 'Palestra', '2023-04-03 07:00:00', '2023-04-15 00:00:00', '2023-04-20 19:00:00', 00.00, 3);
select * from Atividade;
-- ########################################################################################################################################################################

insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 1, 1);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 09:00:00', 1, 2);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 11:00:00', 1, 3);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 2, 1);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 17:00:00', 2, 2);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 15:00:00', 2, 4);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 18:00:00', 3, 1);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 19:00:00', 3, 4);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 4, 4);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 4, 1);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 4, 3);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 5, 4);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 13:00:00', 5, 3);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 15:00:00', 6, 4);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 23:00:00', 6, 2);
insert into Inscricao (dt_inscricao, cod_user, cod_atividade) values ('2023-04-04 00:00:00', 6, 1);
select * from Inscricao;
-- ########################################################################################################################################################################



