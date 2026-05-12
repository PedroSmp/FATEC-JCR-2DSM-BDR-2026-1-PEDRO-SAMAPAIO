--EXERCICIO 1--
select autor.nome,
	(select count(*)
		from livro 
		where livro.id_autor = autor.id_autor) as total_livros 
from autor;	

with contagemLivros as (
	select id_autor, count(*) as total_livros
	from livro
	group by id_autor
)
select 
	autor.nome,
	contagemLivros.total_livros
from autor 
left join contagemLivros on autor.id_autor = contagemLivros.id_autor;


--EXERCICIO 2
with pagina_por_autor as (
	select id_autor, sum(num_paginas) as total_paginas
	from livro 
	group by id_autor 
)
select 
	autor.nome,
	pagina_por_autor.total_paginas
from autor 
join pagina_por_autor on autor.id_autor = pagina_por_autor.id_autor
where pagina_por_autor.total_paginas > (select avg(num_paginas) from livro);

-- EXERCICIO 3
select 
	a.nome, 
	(select sum(l.num_paginas)
	from livro l
	where l.id_autor = a.id_autor) as total_paginas
from autor a;

select
	a.nome,
	resumo.total_paginas
from autor a 
left join (
	select id_autor, sum(num_paginas) as total_paginas 
	from livro 
	group by id_autor
) as resumo on a.id_autor = resumo.id_autor;

	



