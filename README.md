# qtl-qc-pipeline

QC pipeline that identifies QTLs with multiple CMO or VT annotations.

## Overview

Reports QTLs that have more than one CMO (Clinical Measurement Ontology) or VT (Vertebrate Trait)
annotation. These cases may indicate curation issues that need review.

## Logic

1. Query `FULL_ANNOT` joined with `QTLS` and `ONT_TERMS` for QTLs having multiple CMO annotations
2. Query the same tables for QTLs having multiple VT annotations
3. Log results as tab-delimited lines: RGD_ID, QTL_SYMBOL, COUNT, TERMS, ONTOLOGY_IDS

## Logging

- `status` — pipeline progress and summary counts
- `multi_cmo` — detailed list of QTLs with multiple CMO annotations
- `multi_vt` — detailed list of QTLs with multiple VT annotations

## Build and run

Requires Java 17. Built with Gradle:
```
./gradlew clean assembleDist
```