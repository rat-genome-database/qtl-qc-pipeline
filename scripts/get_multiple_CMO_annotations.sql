SELECT q.rgd_id, qtl_symbol, COUNT(*) as count, 
  LISTAGG(ot.term) WITHIN GROUP (ORDER BY ot.term) as Terms,
  LISTAGG(fa.term_acc) WITHIN GROUP (ORDER BY fa.term_acc) as Ontology_IDs 
FROM full_annot fa, qtls q, ont_terms ot
WHERE
fa.ANNOTATED_OBJECT_RGD_ID = q.RGD_ID
and fa.TERM_ACC like 'CMO:%' 
and fa.TERM_ACC = ot.TERM_ACC
group by q.rgd_id, qtl_symbol
having count(*) > 1 
