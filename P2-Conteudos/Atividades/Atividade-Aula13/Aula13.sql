-- EXERCICIO 1--
create view vw_titulo_num_paginas_livro as
	select titulo, num_paginas from livro

select * from vw_titulo_num_paginas_livro

-- EXERCICIO 2--
create view vw_mais_de_uma_obra as
	select autor.nome,
	count(livro.id_livro) as total_livros
	from autor
	join livro on autor.id_autor = livro.id_autor
	group by autor.id_autor, autor.nome 
	having count(livro.id_livro)>1;

select * from vw_mais_de_uma_obra


-- EXERCICIO 3--
create view vw_livros_acima_da_media as
	select titulo, num_paginas from livro
	where num_paginas > (select avg(num_paginas) from livro);

select * from vw_livros_acima_da_media

-- EXERCICIO 4--
create view vw_livro_detalhes as
	select autor.nome as autor,
	livro.titulo, 
	livro.ano_publicacao from livro
	join autor on livro.id_autor = autor.id_autor;

select * from vw_livro_detalhes

-- EXERCICIO 5--
create view vw_resumo_autores as
	select autor.nome as autor,
		count(livro.id_livro) as total_livros,
		max(livro.num_paginas) as maior_numero_paginas
	from autor
	left join livro on autor.id_autor = livro.id_autor
	group by autor.id_autor, autor.nome;

select * from vw_resumo_autores