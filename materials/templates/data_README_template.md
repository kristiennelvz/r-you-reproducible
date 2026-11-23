# Data README

## Project

Title: [Short project title]

Contact: [Name, email]

Last updated: [YYYY-MM-DD]

## Raw data (`data/raw/`)

Files in `data/raw/` are kept exactly as received and are read-only. All changes are made in code (`analysis/harmonise_metadata.qmd`).

| File | Source (who / where it came from) | Date received | Description |
|---|---|---|---|
| siteA_capetown_metadata.csv | [e.g. Site A study coordinator, by email] | [YYYY-MM-DD] | [Sample metadata, Cape Town] |
| siteB_johannesburg_metadata.csv | | | |
| siteB_codebook.txt | | | |
| siteC_durban_metadata.tsv | | | |
| sequencing_run_sheet.csv | | | |

## Processed data (`data/processed/`)

Created by `analysis/harmonise_metadata.qmd`. Do not edit by hand: rerun the analysis instead.

| File | Created by | Description |
|---|---|---|
| metadata_harmonised.csv | analysis/harmonise_metadata.qmd | [One row per sample, MIxS-style column names] |

## Variables

See `docs/data_dictionary.csv` for every variable, its units and allowed values.

## Known issues and decisions

[Record anything a future user should know, e.g. "One age value (340) was queried with Site A and set to missing until confirmed."]

## Ethics and sharing

[Ethics approval number, consent restrictions, and whether the data can be shared openly or only on request / controlled access.]
