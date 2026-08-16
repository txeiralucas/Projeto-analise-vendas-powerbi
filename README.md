# Análise de Vendas — Sample Sales Data

Projeto de análise de dados, unindo SQL e Power BI, para explorar padrões de vendas em um dataset de vendas de veículos em miniatura (Sample Sales Data, Kaggle).

![Preview do Dashboard](Projeto%201%20-%20Power%20BI.png)

---

## 🎯 Objetivo

Responder perguntas de negócio reais a partir de dados brutos de vendas, cobrindo:
- Qual é a saúde geral do negócio (faturamento, volume, ticket médio)?
- Quais produtos e categorias performam melhor?
- Quais clientes e regiões concentram mais receita?
- Como as vendas evoluem ao longo do tempo?

## 🛠️ Processo

O projeto foi construído em duas fases:

### 1. Análise exploratória em SQL
Antes de qualquer visualização, explorei o dataset via SQL (SQLiteOnline), estruturando a investigação em 4 blocos: visão geral do negócio, produtos, clientes e geografia. Essa etapa serviu para formular hipóteses e entender a estrutura dos dados antes de partir para modelagem.

📄 Queries completas em [`analises_vendas.sql`](https://github.com/txeiralucas/Projeto-analise-vendas-powerbi/blob/main/analises_vendas.sql)

### 2. Modelagem e Dashboard em Power BI
A partir da tabela única original, construí um **modelo estrela** completo:
- `Dim_Cliente`, `Dim_Produto` e `Dim_Data` (dimensões)
- `Fato_Vendas` (tabela fato com métricas e chaves)
- Relacionamentos 1:N entre as dimensões e a fato
- 9 medidas DAX, incluindo Time Intelligence (`SAMEPERIODLASTYEAR`) para comparações ano a ano

O dashboard final consolida tudo em uma única página, com KPIs, tendência temporal, e rankings de produto, cliente e território.

**Veja a interatividade em ação:**

![Demonstração do Dashboard](Dashboard%20power%20bi.gif)

## 📊 Principais Insights

- **Classic Cars** é a linha de produto líder em faturamento, à frente de Vintage Cars e Motorcycles
- **EMEA** é a região com maior faturamento — superando a América do Norte (NA) mesmo com os EUA sendo o maior país isolado, por concentrar vários países europeus fortes
- O desconto médio aplicado nas vendas **caiu de ~12,6% (2003) para ~5% (2005)**, sugerindo uma política de preços mais rígida ao longo do tempo
- Euro Shopping Channel é o cliente com maior volume de compras acumulado

## 🐛 Desafio técnico: qualidade de dados

Durante a construção do modelo, identifiquei que a coluna `ORDERDATE` vinha da fonte original em **formatos de data inconsistentes** (mistura de `M/D/YYYY` e `MM/DD/YYYY`). Isso causava conversões erradas em datas ambíguas (ex: um pedido de 12/janeiro/2005 sendo lido como 1º/dezembro/2005), distorcendo a distribuição de vendas por mês.

**Solução aplicada**: reconstruí a coluna de data em Power Query a partir das colunas auxiliares `YEAR_ID` e `MONTH_ID` (numéricas e sem ambiguidade), comparando-as com os componentes do texto original para determinar corretamente qual valor era o dia. Isso eliminou a distorção e validou a consistência do modelo.

Também identifiquei e documentei, de forma transparente no próprio dashboard, que os dados de 2005 estão disponíveis apenas até maio — o que afeta comparações de crescimento anual envolvendo esse ano.

## 🧰 Tecnologias

- **SQL** (SQLiteOnline) — exploração de dados
- **Power BI Desktop** — modelagem, DAX e visualização
- **Power Query (M)** — transformação e limpeza de dados
- **DAX** — medidas, incluindo Time Intelligence

## 📁 Estrutura do repositório

```
├── README.md
├── analises_vendas.sql          # Queries da fase de exploração em SQL
├── Projeto 1.pbix                # Arquivo do dashboard Power BI
└── Projeto 1 - Power BI.png      # Print do dashboard final
```

---
