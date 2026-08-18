# Walmart Sales Data Analysis

## Sobre o Projeto

Este projeto tem como objetivo explorar e analisar dados de vendas do Walmart para identificar padrões de vendas, desempenho dos produtos, comportamento dos clientes e diferenças entre as filiais.

A análise foi realizada utilizando **MySQL**, aplicando conceitos de SQL para responder a diferentes perguntas de negócio e obter insights a partir dos dados.

O projeto faz parte do meu portfólio pessoal e tem como objetivo também praticar e desenvolver habilidades em **SQL e análise de dados**.

---

## Objetivos do Projeto

Os principais objetivos deste projeto são:

- Analisar o desempenho das diferentes filiais.
- Identificar as linhas de produtos com melhor desempenho.
- Analisar tendências de vendas ao longo do tempo.
- Identificar os métodos de pagamento mais utilizados.
- Analisar o comportamento dos diferentes tipos de clientes.
- Comparar o desempenho das filiais.
- Analisar as avaliações dadas pelos clientes.
- Identificar padrões relacionados a dias da semana e horários.
- Praticar conceitos de SQL aplicados à análise de dados.

---

## Sobre os Dados

O dataset utilizado neste projeto foi obtido no Kaggle e contém informações sobre transações de vendas realizadas em três filiais do Walmart, localizadas nas cidades de **Mandalay, Yangon e Naypyitaw**.

O conjunto de dados possui **1.000 registros e 17 colunas**, contendo informações sobre vendas, produtos, clientes, métodos de pagamento, datas e avaliações.

### Dicionário de Dados

| Coluna | Descrição | Tipo de Dado |
|---|---|---|
| `invoice_id` | Identificador da nota fiscal da venda | VARCHAR(30) |
| `branch` | Filial onde a venda foi realizada | VARCHAR(5) |
| `city` | Cidade onde a filial está localizada | VARCHAR(30) |
| `customer_type` | Tipo de cliente | VARCHAR(30) |
| `gender` | Gênero do cliente | VARCHAR(10) |
| `product_line` | Linha de produtos adquirida | VARCHAR(100) |
| `unit_price` | Preço unitário do produto | DECIMAL(10, 2) |
| `quantity` | Quantidade de produtos vendidos | INT |
| `VAT` | Imposto sobre o valor agregado da compra | FLOAT(6, 4) |
| `total` | Valor total da compra | DECIMAL(10, 2) |
| `date` | Data em que a compra foi realizada | DATE |
| `time` | Horário em que a compra foi realizada | TIME |
| `payment_method` | Método de pagamento utilizado | VARCHAR(20) |
| `cogs` | Custo dos produtos vendidos | DECIMAL(10, 2) |
| `gross_margin_percentage` | Percentual de margem bruta | FLOAT(11, 9) |
| `gross_income` | Renda bruta obtida na venda | DECIMAL(10, 2) |
| `rating` | Avaliação dada pelo cliente | FLOAT(2, 1) |

---

## Tecnologias Utilizadas

- **MySQL**
- **SQL**
- **CSV**
- **Git**
- **GitHub**

---

# Processo de Análise

## 1. Preparação dos Dados

A primeira etapa consistiu na criação do banco de dados e da tabela que armazenaria os dados das vendas.

As principais atividades realizadas foram:

- Criação do banco de dados.
- Criação da tabela `sales`.
- Definição dos tipos de dados das colunas.
- Importação dos dados do arquivo CSV.
- Verificação dos dados.
- Verificação de valores nulos.

Como parte da criação da tabela, as colunas foram definidas como `NOT NULL` quando necessário, evitando a inserção de valores nulos nesses campos.

---

## 2. Engenharia de Dados

Foram criadas novas colunas a partir das informações existentes no dataset para facilitar a análise temporal das vendas.

### `time_of_day`

Foi criada a coluna `time_of_day` para classificar as vendas de acordo com o período do dia:

- Morning
- Afternoon
- Evening

Essa classificação permite analisar em qual período do dia ocorre a maior quantidade de vendas.

### `day_name`

Foi criada a coluna `day_name` para identificar o dia da semana em que cada transação ocorreu.

Essa informação permite analisar quais dias apresentam maior volume de vendas em cada filial.

### `month_name`

Foi criada a coluna `month_name` para identificar o mês em que cada transação ocorreu.

Essa informação permite analisar as variações de vendas e lucro ao longo dos meses.

---

## 3. Análise Exploratória dos Dados (EDA)

Após a preparação dos dados, foram utilizadas consultas SQL para realizar uma análise exploratória do dataset.

As consultas foram utilizadas para investigar:

- Desempenho dos produtos.
- Desempenho das filiais.
- Tendências de vendas.
- Comportamento dos clientes.
- Métodos de pagamento.
- Receita.
- Impostos.
- Avaliações dos clientes.
- Distribuição das vendas por horário e dia da semana.

---

# Perguntas de Negócio

As consultas SQL foram desenvolvidas para responder às seguintes perguntas.

## Análise Geral

1. Quantas cidades diferentes existem no dataset?
2. Em qual cidade cada filial está localizada?

---

## Análise de Produtos

1. Quantas linhas de produtos diferentes existem no dataset?
2. Qual é o método de pagamento mais utilizado?
3. Qual é a linha de produtos mais vendida?
4. Qual é a receita total por mês?
5. Qual mês apresentou o maior COGS?
6. Qual linha de produtos apresentou a maior receita?
7. Qual cidade apresentou a maior receita?
8. Qual linha de produtos apresentou o maior valor de VAT?
9. Classificar cada linha de produtos como **"Good"** ou **"Bad"**, considerando a média das vendas como referência.
10. Qual filial vendeu uma quantidade de produtos superior à média?
11. Qual é a linha de produtos mais comum para cada gênero?
12. Qual é a avaliação média de cada linha de produtos?

---

## Análise de Vendas

1. Quantas vendas foram realizadas em cada período do dia para cada dia da semana?
2. Qual tipo de cliente gera a maior receita?
3. Qual cidade apresenta o maior percentual de VAT?
4. Qual tipo de cliente paga o maior valor de VAT?

---

## Análise de Clientes

1. Quantos tipos de clientes diferentes existem?
2. Quantos métodos de pagamento diferentes existem?
3. Qual é o tipo de cliente mais comum?
4. Qual tipo de cliente realiza mais compras?
5. Qual é o gênero predominante entre os clientes?
6. Qual é a distribuição de gênero em cada filial?
7. Em qual período do dia os clientes fornecem as maiores avaliações?
8. Em qual período do dia os clientes fornecem as maiores avaliações em cada filial?
9. Qual dia da semana apresenta a maior avaliação média?
10. Qual dia da semana apresenta a maior avaliação média em cada filial?

---

# Conceitos de SQL Utilizados

Durante o desenvolvimento do projeto, foram utilizados diversos conceitos de SQL, incluindo:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `CASE`
- Subqueries
- Funções de agregação
- `SUM()`
- `AVG()`
- `COUNT()`
- `MAX()`
- `MIN()`
- Funções de data e hora
- Funções de texto
- `ALTER TABLE`
- `UPDATE`
- Classificação de dados
- Agregação e comparação de dados

---

# Estrutura do Projeto

```text
Walmart-Sales-Data-Analysis/
│
├── data/
│   └── WalmartSalesData.csv
│
├── sql/
│   └── WalmartData.sql
│
└── README.md
---
## Autor
Cristina Yuki Yokomizo

🤝 Contribuições são sempre bem-vindas!
