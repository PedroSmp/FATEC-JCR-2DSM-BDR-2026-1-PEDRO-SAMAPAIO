alter table livro 
add column quantidade integer;

UPDATE livro SET quantidade = 5 WHERE id_livro = 1;
UPDATE livro SET quantidade = 3 WHERE id_livro = 2;
UPDATE livro SET quantidade = 0 WHERE id_livro = 3;
UPDATE livro SET quantidade = 8 WHERE id_livro = 4;
UPDATE livro SET quantidade = 0 WHERE id_livro = 5;
UPDATE livro SET quantidade = 2 WHERE id_livro = 6;
UPDATE livro SET quantidade = 1 WHERE id_livro = 7;
UPDATE livro SET quantidade = 0 WHERE id_livro = 8;
UPDATE livro SET quantidade = 4 WHERE id_livro = 9;
UPDATE livro SET quantidade = 0 WHERE id_livro = 10;
UPDATE livro SET quantidade = 3 WHERE id_livro = 11;
UPDATE livro SET quantidade = 2 WHERE id_livro = 12;
UPDATE livro SET quantidade = 1 WHERE id_livro = 13;
UPDATE livro SET quantidade = 0 WHERE id_livro = 14;

SELECT id_livro, titulo, quantidade 
FROM livro;



 -- EXERCICIO 1 --
 create or replace function bloquear_exclusao()
 returns trigger language plpgsql as $$ begin

 if old.quantidade > 0 then 
 raise exception 'Não é possível excluir livro';
 end if;

 return old;

 end; $$;

 create trigger trg_bloq_exclusao
 before delete on livro 
 for each row
 execute function bloquear_exclusao();
 delete from livro where id_livro = 1;
 delete from livro where id_livro = 14;


 -- EXERCICIO 2 --

 create table log_livro(id_log serial primary key, 
 titulo varchar (255),
 data_exclusao timestamp,
 mensagem varchar(255)
 );

 create or replace function log_excl_livro()
 returns trigger language plpgsql as $$ begin

 insert into log_livro(titulo, data_exclusao,mensagem)
 values (old.titutlo, now(), 'Livro removido do sistema!');

 return old;
 end; $$;

 create trigger trg_log_excl
 after delete on livro 
 for each row
 execute function log_excl_livro();
 delete from livro where id_livro = 15;

 select * from livro;


 -- EXERCICIO 3 --

 create or replace function validade_limit_estq()
 returns trigger language plpgsql as $$ begin 

 if new.quantidade > 100 then raise exception 'A quantidade não pode ser maior que 100';
 end if;

 return new;
 end; $$;

 create trigger trg_valid_limit
 before update on livro 
 for each row
 execute function validade_limit_estq()

 update livro 
 set quantidade = 20
 where id_livro = 1;

 update livro 
 set quantidade = 120
 where id_livro = 1;
 
 
