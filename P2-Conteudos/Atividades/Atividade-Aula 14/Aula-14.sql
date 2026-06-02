---* EXERCICIO 1 *---
CREATE OR REPLACE PROCEDURE inserir_livro_autor_existente(
    p_titulo VARCHAR,
    p_id_autor INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
    -- Validação: Verifica se o autor NÃO existe na tabela autor
    IF NOT EXISTS (SELECT 1 FROM autor WHERE id_autor = p_id_autor) THEN 
        RAISE EXCEPTION 'Autor inexistente! Não é possível inserir o livro.';
    END IF; 
    
    -- Se o autor existir, faz o comando usando os nomes certos das suas colunas:
    INSERT INTO livro (titulo, id_autor) 
    VALUES (p_titulo, p_id_autor);
END;
$$;




---* EXERCICIO 2 *---
CREATE OR REPLACE PROCEDURE atualizar_paginas_livro(
    p_id_livro INTEGER,
    p_num_paginas INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validação da regra de negócio
    IF p_num_paginas <= 10 THEN
        RAISE EXCEPTION 'Erro: O número de páginas deve ser maior que 10!';
    END IF;

    -- Update usando os nomes idênticos aos da imagem 3
    UPDATE livro 
    SET num_paginas = p_num_paginas  
    WHERE id_livro = p_id_livro;       

END;
$$;

--x erro x--
CALL atualizar_paginas_livro (1, 8);
select *from livro

--x sucesso x--
CALL atualizar_paginas_livro (1, 150);
select *from livro


---* EXERCICIO 3 *---

CREATE OR REPLACE PROCEDURE excluir_autor_seguro(
    p_id_autor INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
   
    IF EXISTS (SELECT 1 FROM livro WHERE id_autor = p_id_autor) THEN
        RAISE EXCEPTION 'Erro: Não é possível excluir o autor porque ele possui livros cadastrados!';
    END IF;

    
    DELETE FROM autor 
    WHERE id_autor = p_id_autor; 
END;
$$;

CALL excluir_autor_seguro(1); 

---* EXERCICIO 4 *---

CREATE OR REPLACE FUNCTION relatorio_autor_paginas(
    p_id_autor INTEGER
)
RETURNS TABLE (
    nome_autor VARCHAR,
    media_paginas NUMERIC
) 
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN QUERY 
    SELECT 
        a.nome::VARCHAR, -- Ajusta o tipo para bater com o RETURNS TABLE
        ROUND(AVG(l.num_paginas), 2)::NUMERIC
    FROM autor a
    INNER JOIN livro l ON a.id_autor = l.id_autor
    WHERE a.id_autor = p_id_autor
    GROUP BY a.nome;
END;
$$;

SELECT * FROM relatorio_autor_paginas(1);


---* EXERCICIO 5 *---
CREATE OR REPLACE PROCEDURE inserir_livro_desafio(
    p_titulo VARCHAR,
    p_num_paginas INTEGER,
    p_id_autor INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validação 1: Título não pode ser vazio ou nulo
    IF p_titulo IS NULL OR TRIM(p_titulo) = '' THEN
        RAISE EXCEPTION 'Erro de validação: O título do livro não pode ser vazio!';
    ELSE
        -- Validação 2 (Aninhada): Páginas devem ser maiores que 0
        IF p_num_paginas <= 0 THEN
            RAISE EXCEPTION 'Erro de validação: O número de páginas deve ser maior que 0!';
        ELSE
            -- Validação 3 (Aninhada): O autor deve existir
            IF NOT EXISTS (SELECT 1 FROM autor WHERE id_autor = p_id_autor) THEN
                RAISE EXCEPTION 'Erro de validação: O autor informado não existe!';
            ELSE
                -- Se passou por TODOS os IFs, faz o INSERT com segurança
                INSERT INTO livro (titulo, num_paginas, id_autor)
                VALUES (p_titulo, p_num_paginas, p_id_autor);
                
                RAISE NOTICE 'Sucesso: Livro inserido corretamente!';
            END IF;
        END IF;
    END IF;

    COMMIT;
END;
$$;

--- EXERCICIO 6 ---
CALL inserir_livro_desafio('Design de Interfaces', -5, 1);
