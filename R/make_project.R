# Catch-up script: builds the workshop project structure in one go.
#
# In the workshop we build this structure step by step (see README.md,
# "Session 2"). If you fall behind or something goes wrong, run:
#
#   source("R/make_project.R")
#
# It never overwrites files you have already created.

root <- getwd()
if (!file.exists(file.path(root, "r-you-reproducible.Rproj"))) {
  stop("Please open the r-you-reproducible project in RStudio first ",
       "(double-click r-you-reproducible.Rproj), then run this script again.")
}

# 1. Folders
folders <- c("data/raw", "data/processed", "analysis", "docs", "output")
for (f in folders) dir.create(file.path(root, f), recursive = TRUE, showWarnings = FALSE)

# 2. Copy the raw data (as received) into data/raw and make it read-only
raw_files <- list.files(file.path(root, "materials", "raw-data"), full.names = TRUE)
for (f in raw_files) {
  dest <- file.path(root, "data", "raw", basename(f))
  if (!file.exists(dest)) file.copy(f, dest)
}
Sys.chmod(list.files(file.path(root, "data", "raw"), full.names = TRUE), mode = "0444")

# 3. Templates (only if they do not exist yet)
copy_if_missing <- function(from, to) {
  if (!file.exists(to)) file.copy(from, to) else message("Kept your existing ", to)
}
copy_if_missing(file.path(root, "materials", "templates", "data_README_template.md"),
                file.path(root, "data", "README.md"))
copy_if_missing(file.path(root, "materials", "templates", "data_dictionary_template.csv"),
                file.path(root, "docs", "data_dictionary.csv"))
copy_if_missing(file.path(root, "materials", "templates", "harmonise_metadata.qmd"),
                file.path(root, "analysis", "harmonise_metadata.qmd"))

message("\nProject ready:")
message("  data/raw/                      raw files (read-only)")
message("  data/README.md                 describe where the data came from")
message("  docs/data_dictionary.csv       describe every variable")
message("  analysis/harmonise_metadata.qmd  the analysis; open it and click Render")
