select q.rgd_id, qtl_symbol, count(*) as count, to_char(wm_concat(ot.term)) as Terms, to_char(wm_concat(fa.term_acc)) as Ontology_IDs 
from FULL_ANNOT fa, QTLS q, ONT_TERMS ot
where
fa.ANNOTATED_OBJECT_RGD_ID = q.RGD_ID
and fa.TERM_ACC like 'VT:%' 
and fa.TERM_ACC = ot.TERM_ACC
group by q.rgd_id, qtl_symbol
having count(*) > 1 
