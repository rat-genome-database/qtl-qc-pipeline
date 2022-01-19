package edu.mcw.rgd.pipelines;

import edu.mcw.rgd.dao.AbstractDAO;
import edu.mcw.rgd.dao.spring.StringListQuery;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.List;

/**
 * Created by mtutaj on 1/14/2021
 * <p>
 * All database code lands here
 */
public class Dao {

    AbstractDAO adao = new AbstractDAO();

    Logger logMultiCMO = LogManager.getLogger("multi_cmo");
    Logger logMultiVT = LogManager.getLogger("multi_vt");

    static final String HEADER = "RGD_ID\tQTL_SYMBOL\tCOUNT\tTERMS\tONTOLOGY_IDS";

    public List<String> getMultipleCMOAnnotations() throws Exception {

        String sql =
                "SELECT q.rgd_id || CHR(9) || qtl_symbol || CHR(9) || COUNT(*) || CHR(9) ||"+
                        "  LISTAGG(ot.term, ',') WITHIN GROUP (ORDER BY ot.term) || CHR(9) ||"+
                        "  LISTAGG(fa.term_acc, ',') WITHIN GROUP (ORDER BY fa.term_acc) "+
                        "FROM full_annot fa, qtls q, ont_terms ot "+
                        "WHERE fa.ANNOTATED_OBJECT_RGD_ID = q.RGD_ID"+
                        "  AND fa.TERM_ACC like 'CMO:%'"+
                        "  AND fa.TERM_ACC = ot.TERM_ACC "+
                        "GROUP BY q.rgd_id, qtl_symbol HAVING COUNT(*) > 1";

        List<String> multis = StringListQuery.execute(adao, sql);
        if( !multis.isEmpty() ) {
            logMultiCMO.debug(HEADER);
            for( String line: multis ) {
                logMultiCMO.debug(line);
            }
        }
        return multis;
    }

    public List<String> getMultipleVTAnnotations() throws Exception {

        String sql =
        "SELECT q.rgd_id || CHR(9) || qtl_symbol || CHR(9) || COUNT(*) || CHR(9) ||"+
        "  LISTAGG(ot.term, ',') WITHIN GROUP (ORDER BY ot.term) || CHR(9) ||"+
        "  LISTAGG(fa.term_acc, ',') WITHIN GROUP (ORDER BY fa.term_acc) "+
        "FROM full_annot fa, qtls q, ont_terms ot "+
        "WHERE fa.ANNOTATED_OBJECT_RGD_ID = q.RGD_ID"+
        "  AND fa.TERM_ACC like 'VT:%'"+
        "  AND fa.TERM_ACC = ot.TERM_ACC "+
        "GROUP BY q.rgd_id, qtl_symbol HAVING COUNT(*) > 1";

        List<String> multis = StringListQuery.execute(adao, sql);
        if( !multis.isEmpty() ) {
            logMultiVT.debug(HEADER);
            for( String line: multis ) {
                logMultiVT.debug(line);
            }
        }
        return multis;
    }

}
