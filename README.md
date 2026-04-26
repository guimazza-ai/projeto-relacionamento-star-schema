# Projeto de Desafio - Desenvolvimento de Modelagem Star Schema
Desafio de projeto de criação de tabelas Fato e Dimensional e desenvolvimento do relacionamento Star Schema.

## 📌 Descrição do Projeto
Este projeto como objetivo transformar a tabela única **Financial Sample** em um modelo dimensional baseado em **Star Schema**, separando os dados em tabelas **dimensão** e **fato**, aplicando boas práticas de modelagem para análise de vendas no Power BI.

---

## 🗂️ Estrutura do Modelo
O modelo foi construído a partir de uma tabela de origem (**Financial Sample**), criando as seguintes tabelas:

### 🔒 Tabela de Origem
- **Financials_origem**

  - Tabela original
  - Mantida oculta (backup)

### 📦 Tabelas Dimensão
- **D_Produtos**
  - ID_Produto  
  - Produto  
  - Média de Units Sold  
  - Média de Sales Value  
  - Mediana de Sales Value  
  - Valor Máximo de Venda  
  - Valor Mínimo de Venda  

- **D_Produtos_Detalhes**
  - ID_Produto  
  - Discount Band  
  - Média de Preço de Vendas
  - Média da Unidade Vendida
  - Média de preço de Fabricação 

- **D_Descontos**
  - ID_Produto  
  - Discount Band  
  - Média de Desconto  

- **D_Detalhes**
  - Contém atributos não contemplados nas demais dimensões, como:
    - Segment
    - Country
    - Soma de *Units Sold*
    - Soma de *Sales*
    - Valor Máximo de *COGS*
    - Valor Mínimo de *COGS*
  
- **D_Calendário**
  - Criada utilizando DAX com a função `CALENDAR()`
  - Coluna Mês com a função `MONTH()`
  - Coluna Ano com a função `YEAR()`

### 📊 Tabela Fato
- **F_Vendas**
  - SK_ID  
  - ID_Produto  
  - Produto  
  - Units Sold  
  - Sales Price  
  - Discount Band  
  - Segment  
  - Country  
  - Sales  
  - Profit  
  - Date  

---

## 🧮 Funções e Recursos Utilizados
- **DAX**
  - `CALENDAR()`
  - `MONTH()`
  - `YEAR()`

- **Power Query**
  - Remoção e renomeação de colunas
  - Criação de tabelas por referência
  - Reordenação das colunas
  - Agrupamento, usando:
    - Mínimo
    - Máximo
    - Média
    - Soma
    - Contagem
  - Mesclagem com diferentes tabelas
  - Configuração do tipo de dados
    
- **Modelagem Dimensional (Star Schema)**
<img width="1362" height="707" alt="image" src="https://github.com/user-attachments/assets/3c2efffd-f5fd-4f57-9acd-a7419b86b00d" />

## 🏆 Projeto

- [Modelagem Star Schema](https://github.com/guimazza-ai/projeto-relacionamento-star-schema/blob/main/Projeto/star_schema_project.pbix)

