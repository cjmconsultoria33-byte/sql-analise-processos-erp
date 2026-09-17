# Auditoria de Processos e Regras de Negócio em ERP (SQL)

Este repositório reúne consultas analíticas desenvolvidas para validação de integridade de dados, conciliação operacional e controle em sistemas ERP.

---

### 🎯 Problemas de Negócio Mapeados
* **Prevenção de Glosas e Divergências de Faturamento:** Identificação antecipada de procedimentos faturados fora da tabela negociada com operadoras/convênios.
* **Controle de Suprimentos Críticos (MatMed):** Monitoramento dinâmico de itens de estoque operando abaixo da margem mínima e ponto de pedido.

---

### 🛠️ Tecnologias & Comandos
* **Linguagem:** SQL (ANSI / Oracle / PostgreSQL / SQL Server)
* **Estruturas aplicadas:** `INNER JOIN`, filtros condicionais compostos, regras de agregação e cálculos de margem em tempo real.

---

### 📂 Estrutura do Repositório
* `/scripts/auditoria_faturamento_estoque.sql`: Scripts comentados prontos para execução em banco de dados relacional.
