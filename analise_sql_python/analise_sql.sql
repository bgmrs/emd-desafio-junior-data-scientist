-- Localização de chamados do 1746: Utilize a tabela de Chamados do 1746 e a tabela de Bairros do Rio de Janeiro para as perguntas de 1-5.


-- 1. Quantos chamados foram abertos no dia 01/04/2023?

select count(distinct id_chamado) as quantidade_chamados from datario.adm_central_atendimento_1746.chamado where FORMAT_DATE('%d/%m/%Y', data_inicio) = '01/04/2023'

-- R: Foram abertos 1756 chamados neste dia

-- 2. Qual o tipo de chamado que teve mais teve chamados abertos no dia 01/04/2023?

select tipo, count(tipo) as quantidade_tipo from datario.adm_central_atendimento_1746.chamado where FORMAT_DATE('%d/%m/%Y', data_inicio) = '01/04/2023' group by 1 order by 2 desc limit 1

-- R: O tipo de chamado com mais chamados abertos neste dia foi 'Estacionamento irregular'

-- 3. Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?

select 
  b.nome, 
  count(c.id_chamado) as quantidade_chamados,
from 
  datario.adm_central_atendimento_1746.chamado as c 
  inner join datario.dados_mestres.bairro as b 
  on c.id_bairro = b.id_bairro
where FORMAT_DATE('%d/%m/%Y', data_inicio) = '01/04/2023' 
group by 1
order by 2 desc 
limit 3

-- R: Os bairros são: Campo Grande, Tijuca e Barra da Tijuca

-- 4. Qual o nome da subprefeitura com mais chamados abertos nesse dia?

select 
  subprefeitura, 
  count(id_chamado) as quantidade_chamados,
from 
  datario.adm_central_atendimento_1746.chamado as c 
  inner join datario.dados_mestres.bairro as b 
  on c.id_bairro = b.id_bairro
where FORMAT_DATE('%d/%m/%Y', data_inicio) = '01/04/2023' 
group by 1
order by 2 desc 
limit 1

-- R: Zona Norte

-- 5. Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim, por que isso acontece?

select 
  count(id_chamado) as quantidade_chamados_sem_bairro
from 
  datario.adm_central_atendimento_1746.chamado as c 
  left join datario.dados_mestres.bairro as b 
  on c.id_bairro = b.id_bairro
where 
  b.id_bairro is null
  and FORMAT_DATE('%d/%m/%Y', data_inicio) = '01/04/2023'

-- R: Existem 73 chamados abertos neste dia que não foram associados a um bairro ou subprefeitura. É comum casos de dados faltantes em datasets, ou até mesmo a tabela pode não conter todos os bairros possíveis


--Chamados do 1746 em grandes eventos: Utilize a tabela de Chamados do 1746 e a tabela de Ocupação Hoteleira em Grandes Eventos no Rio para as perguntas de 6-10. Para todas as perguntas considere o subtipo de chamado "Perturbação do sossego".


-- 6. Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 até 31/12/2023 (incluindo extremidades)?

select count(id_chamado) as quantidade_chamado from datario.adm_central_atendimento_1746.chamado where data_inicio BETWEEN '2022-01-01' AND '2023-12-31' and subtipo = 'Perturbação do sossego'

-- R: Foram abertos 42830 chamados deste subtipo neste dia

-- 7. Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).

SELECT 
 id_chamado
FROM 
  datario.adm_central_atendimento_1746.chamado AS c
  JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS e
  ON DATE(c.data_inicio) BETWEEN DATE(e.data_inicial) AND DATE(e.data_final)
WHERE 
  e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
  AND c.subtipo = 'Perturbação do sossego'

-- R: 1214 chamados

-- 8. Quantos chamados desse subtipo foram abertos em cada evento?

SELECT 
  count(distinct id_chamado) as quantidade_chamados,
  e.evento
FROM 
  datario.adm_central_atendimento_1746.chamado AS c
  JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS e
  ON DATE(c.data_inicio) BETWEEN DATE(e.data_inicial) AND DATE(e.data_final)
WHERE 
  e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
  AND c.subtipo = 'Perturbação do sossego'
group by 2
order by 1 desc

-- R: Rock in Rio: 834, Carnaval: 241, Reveillon: 139

-- 9. Qual evento teve a maior média diária de chamados abertos desse subtipo?

SELECT 
  distinct e.evento,
  ROUND(SUM(COUNT(c.id_chamado)) OVER (PARTITION BY e.evento)/SUM(DATE_DIFF(e.data_final, e.data_inicial, DAY) + 1) OVER (PARTITION BY e.evento),2) AS media_diaria
FROM 
  datario.adm_central_atendimento_1746.chamado AS c
  JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS e
  ON DATE(c.data_inicio) BETWEEN DATE(e.data_inicial) AND DATE(e.data_final)
WHERE 
  c.subtipo = 'Perturbação do sossego'
  AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
GROUP BY e.evento, e.data_inicial, e.data_final
ORDER BY 2 DESC

-- R: Rock in Rio com uma média de 119 chamados diários

-- 10. Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023.

WITH eventos as (
  SELECT 
    e.evento,
    DATE_DIFF(e.data_final, e.data_inicial, DAY) + 1 AS dias_evento,
    count(id_chamado) as quantidade_chamados
  FROM 
    datario.adm_central_atendimento_1746.chamado AS c
    JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS e
    ON DATE(c.data_inicio) BETWEEN DATE(e.data_inicial) AND DATE(e.data_final)
  WHERE 
    c.subtipo = 'Perturbação do sossego'
    AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
  GROUP BY e.evento, e.data_inicial, e.data_final)
select evento as durante, round(sum(quantidade_chamados)/sum(dias_evento),2) as media_diaria from eventos group by 1
UNION ALL
SELECT 
    '2023-12-31 a 2022-01-01',
    ROUND((count(id_chamado)) / (DATE_DIFF('2023-12-31', '2022-01-01', DAY) + 1),2) as media_diaria
  FROM datario.adm_central_atendimento_1746.chamado AS c
  WHERE 
    c.subtipo = 'Perturbação do sossego'
    and c.data_inicio BETWEEN DATE('2022-01-01') AND DATE('2023-12-31')
order by 2 desc

-- R: As médias diárias de chamados são: Reveillon com 46.33, Carnaval com 60.25, Rock in Rio com 119.14 e 2023-12-31 a 2022-01-01 com 58.67. Dada as médias, podemos observar que apenas no período de Reveillon a média de chamados não superou todo o período de 01/01/2022 até 31/12/2023
