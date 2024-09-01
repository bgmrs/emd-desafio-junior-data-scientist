# Desafio Técnico - Cientista de Dados Júnior

## Descrição

Desafio técnico para a vaga de Cientista de Dados Júnior no campo de soluções de tecnologia e de Governo Digital para área pública no Rio de Janeiro!.

As perguntas do desafio estão detalhadas nos arquivos `perguntas_sql.md` e `perguntas_api.md`

## Tópicos Atingidos:

 - Análise de Dados em SQL
 - Análise de Dados em Python
 - Integração e Consumo de APIs
 - Desenvolvimento de Visualização de Dados Informativa
 - Desenvolvimento de Modelo de Aprendizado de Máquina

## Conjunto de Dados

Os conjuntos de dados utilizados neste desafio:

- **Chamados do 1746:** Dados relacionados a chamados de serviços públicos na cidade do Rio de Janeiro.
- **Bairros do Rio de Janeiro:** Dados sobre os bairros da cidade do Rio de Janeiro - RJ.
- **Ocupação Hoteleira em Grandes Eventos no Rio**: Dados contendo o período de duração de alguns grandes eventos que ocorreram no Rio de Janeiro em 2022 e 2023 e a taxa de ocupação hoteleira da cidade nesses períodos.
- **Biblioteca `basedosdados`**: base de dados abertos da Prefeitura do Rio de Janeiro
- **Public Holiday API**: API para consulta de datas e informações de feriados 
- **Open-Meteo Historical Weather API**: API para consulta de dados meteorológicos
- **WMO Code (Descriptions)**: Descrições de códigos de interpretação do tempo
- **Ocorrências**: Uma ocorrência na cidade do Rio de Janeiro é um acontecimento que exije um acompanhamento e, na maioria das vezes, uma ação da PCRJ
- **Procedimentos Operacionais Padrão (POP)**: Um POP é um procedimento que será usado para solucionar um evento. Um evento é uma ocorrência na cidade do Rio de Janeiro que exija um acompanhamento e na maioria das vezes uma ação da PCRJ 

## Instruções de Uso dos Códigos

 - ### Acesso ao GCP: 

Você precisará de acesso ao Google Cloud Platform (GCP) para utilizar o BigQuery e consultar os dados públicos disponíveis no projeto `datario`. Além disso, vamos utilizar a biblioteca `basedosdados` em Python para acessar os dados do BigQuery.

Tutorial para acessar dados no BigQuery, desde a criação da conta no GCP até consultar os dados utilizando SQL e Python: [Como acessar dados no BigQuery](https://docs.dados.rio/tutoriais/como-acessar-dados/)

Todas as APIs utilizadas no desafio são públicas e possuem documentações com exemplos.

 - ### Análise SQL: 

Todas as questões do arquivo `perguntas_sql.md` foram resolvidas com SQL no BigQuery, e as respostas estão documentadas em `analise_sql.sql` dentro da pasta `analise_sql_python`.

Acesso:

Executando o Arquivo SQL no BigQuery:
   1. Acesse o BigQuery no console do GCP.
   2. Clique em "Compose new query" (compor nova consulta).
   3. No editor de consulta, cole o conteúdo do arquivo `analise_sql.sql` diretamente

As questões de `perguntas_sql.md` também foram resolvidas com Python e Pandas no Google Colab, com as respostas em `analise_python.ipynb` dentro da pasta `analise_sql_python`.

Acesso:

Importe o Notebook no Google Colab:
   1. Na página inicial do [Colab](https://colab.research.google.com/), clique em "File" > "Open notebook".
   2. No menu que aparece, clique na aba "GitHub".
   3. Cole o [URL](https://github.com/bgmrs/emd-desafio-junior-data-scientist/blob/main/analise_sql_python/analise_python.ipynb) do repositório
   4. Selecione o notebook na lista de resultados e clique em "Open".

 - ### Análise API:

As questões do arquivo `perguntas_api.md` foram resolvidas com Python, com as respostas em `analise_api.ipynb`.

Acesso: Importe o [Notebook](https://github.com/bgmrs/emd-desafio-junior-data-scientist/blob/main/analise_api/analise_api.ipynb) no Google Colab. Para rodar este notebook é necessário fazer upload do arquivo json 'descriptions' em Files no Colab, localizado dentro da pasta `analise_api`

 - ### Dashboard: 

A visualização informativa dos dados das tabelas e APIs foi criada usando o Looker Studio. Um print da visualização esta dentro da pasta `dashboard`.

Acesso: [Acesse a Dashboard](https://lookerstudio.google.com/s/nRdJMZ9lrXs)

 - ### Modelo de Aprendizado de Máquina: 

Adicionalmente, foi desenvolvido um modelo de aprendizado de máquina não supervisionado utilizando K-means para clusterizar os milímetros de pluviosidade registrados nos últimos 24 anos na cidade do Rio de Janeiro.

Acesso: Importe o [Notebook](https://github.com/bgmrs/emd-desafio-junior-data-scientist/blob/main/machine_learning/analise_ml.ipynb) no Google Colab

---
