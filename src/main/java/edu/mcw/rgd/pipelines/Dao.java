package edu.mcw.rgd.pipelines;

import edu.mcw.rgd.dao.AbstractDAO;
import edu.mcw.rgd.dao.spring.StringListQuery;

import java.util.List;

/**
 * Created by mtutaj on 1/14/2021
 * <p>
 * All database code lands here
 */
public class Dao {

    AbstractDAO adao = new AbstractDAO();

    public List<String> getMultipleVTAnnotations() throws Exception {
        String header = "RGD_ID\tQTL_SYMBOL\tCOUNT\tTERMS\tONTOLOGY_IDS\n";

        String sql =
        "SELECT q.rgd_id || CHR(9) || qtl_symbol || CHR(9) || COUNT(*) || CHR(9) ||"+
        "  LISTAGG(ot.term) WITHIN GROUP (ORDER BY ot.term) || CHR(9) ||"+
        "  LISTAGG(fa.term_acc) WITHIN GROUP (ORDER BY fa.term_acc) "+
        "FROM full_annot fa, qtls q, ont_terms ot "+
        "WHERE fa.ANNOTATED_OBJECT_RGD_ID = q.RGD_ID"+
        "  AND fa.TERM_ACC like 'VT:%'"+
        "  AND fa.TERM_ACC = ot.TERM_ACC "+
        "GROUP BY q.rgd_id, qtl_symbol HAVING COUNT(*) > 1";

        return StringListQuery.execute(adao, sql);
    }

}
