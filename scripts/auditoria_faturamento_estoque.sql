-- ============================================================================
-- PROJETO: AUDITORIA OPERACIONAL E REGRAS DE NEGÓCIO EM ERP
-- Autor: Cristiano Silva
-- Descrição: Queries analíticas para prevenção de glosas contratuais 
--            e controle de estoque crítico/ponto de pedido (MatMed).
-- ============================================================================

-- 1. IDENTIFICAÇÃO DE DIVERGÊNCIAS ENTRE ITENS FATURADOS E TABELA DE CONVÊNIO
-- Objetivo: Detectar contas com valores cobrados diferentes da tabela negociada
SELECT 
    f.id_atendimento,
    f.data_atendimento,
    c.nome_convenio,
    p.codigo_procedimento,
    p.descricao_procedimento,
    f.valor_cobrado,
    tc.valor_tabela,
    (f.valor_cobrado - tc.valor_tabela) AS diferenca_valor
FROM faturamento_itens f
INNER JOIN convenios c ON f.id_convenio = c.id_convenio
INNER JOIN procedimentos p ON f.id_procedimento = p.id_procedimento
INNER JOIN tabela_precos_convenio tc ON tc.id_convenio = c.id_convenio 
                                     AND tc.id_procedimento = p.id_procedimento
WHERE f.valor_cobrado <> tc.valor_tabela
  AND f.status_conta = 'EM_ABERTO'
ORDER BY f.data_atendimento DESC;

-- 2. MONITORAMENTO DE PONTO DE PEDIDO E ESTOQUE CRÍTICO (MATMED)
-- Objetivo: Listar suprimentos com saldo abaixo da margem de segurança
SELECT 
    e.id_item,
    e.codigo_item,
    e.descricao_item,
    e.categoria, -- Material / Medicamento
    e.quantidade_atual,
    e.estoque_minimo,
    e.ponto_de_pedido,
    (e.ponto_de_pedido - e.quantidade_atual) AS sugestao_compra,
    e.unidade_medida
FROM controle_estoque e
WHERE e.quantidade_atual <= e.ponto_de_pedido
  AND e.item_ativo = 'S'
ORDER BY (e.quantidade_atual - e.estoque_minimo) ASC;
