# R You Reproducible? Workshop setup check
#
# How to run: open r-you-reproducible.Rproj in RStudio, open this file and
# click "Source" (top right of the script panel). Or type in the Console:
#
#   source("check_setup.R")
#
# The script checks R, the R packages and Quarto, offers to install anything
# that is missing, and renders a tiny test document. If the last line says
# "ALL CHECKS PASSED", you are ready for the workshop.

packages <- c("here", "readr", "dplyr", "tidyr", "stringr", "lubridate",
              "janitor", "knitr", "rmarkdown")
min_r <- "4.3.0"

ok <- TRUE
say <- function(status, msg) cat(sprintf("[%s] %s\n", status, msg))

cat("\n=== R You Reproducible? setup check ===\n\n")

# 1. R version -----------------------------------------------------------------
if (getRversion() >= min_r) {
  say("OK", paste("R version", getRversion()))
} else {
  say("UPDATE", sprintf("R version %s is older than %s. Please install the latest R from https://cran.r-project.org",
                        getRversion(), min_r))
  ok <- FALSE
}

# 2. RStudio -------------------------------------------------------------------
rs <- tryCatch(as.character(RStudio.Version()$version), error = function(e) NA)
if (!is.na(rs)) {
  say("OK", paste("RStudio version", rs))
} else {
  say("NOTE", "Not running inside RStudio (that is fine if you use another editor, but the workshop uses RStudio).")
}

# 3. Packages ------------------------------------------------------------------
missing_pkgs <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_pkgs) > 0) {
  say("MISSING", paste("Packages:", paste(missing_pkgs, collapse = ", ")))
  answer <- if (interactive()) readline("Install the missing packages now? [y/n] ") else "n"
  if (tolower(substr(answer, 1, 1)) == "y") {
    install.packages(missing_pkgs)
    missing_pkgs <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
  } else {
    cat("    To install them yourself, run:\n")
    cat(sprintf('    install.packages(c(%s))\n', paste0('"', missing_pkgs, '"', collapse = ", ")))
  }
}
if (length(missing_pkgs) == 0) {
  say("OK", paste("All", length(packages), "R packages are installed"))
} else {
  say("MISSING", paste("Still missing:", paste(missing_pkgs, collapse = ", ")))
  ok <- FALSE
}

# 4. Quarto --------------------------------------------------------------------
find_quarto <- function() {
  q <- Sys.which("quarto")
  if (nzchar(q)) return(unname(q))
  # RStudio ships its own copy of Quarto; look next to RStudio's pandoc
  pandoc_dir <- Sys.getenv("RSTUDIO_PANDOC")
  if (nzchar(pandoc_dir)) {
    exe <- if (.Platform$OS.type == "windows") "quarto.exe" else "quarto"
    candidates <- c(file.path(pandoc_dir, "..", exe),
                    file.path(pandoc_dir, "..", "..", exe),
                    file.path(pandoc_dir, "..", "..", "bin", exe),
                    file.path(pandoc_dir, "..", "quarto", "bin", exe))
    hit <- candidates[file.exists(candidates)]
    if (length(hit) > 0) return(normalizePath(hit[1]))
  }
  ""
}

quarto_bin <- find_quarto()
if (nzchar(quarto_bin)) {
  qv <- tryCatch(system2(quarto_bin, "--version", stdout = TRUE, stderr = TRUE)[1], error = function(e) NA)
  say("OK", paste("Quarto version", qv))
} else {
  say("MISSING", "Quarto not found. Install RStudio 2023.06 or newer (Quarto is included), or install Quarto from https://quarto.org/docs/get-started/")
  ok <- FALSE
}

# 5. Test render ---------------------------------------------------------------
if (nzchar(quarto_bin) && length(missing_pkgs) == 0) {
  test_dir <- file.path(tempdir(), "quarto_test")
  dir.create(test_dir, showWarnings = FALSE)
  test_qmd <- file.path(test_dir, "test.qmd")
  writeLines(c("---", "title: Setup test", "---", "", "```{r}", "summary(cars)", "```"), test_qmd)
  res <- tryCatch(
    system2(quarto_bin, c("render", shQuote(test_qmd), "--quiet"), stdout = TRUE, stderr = TRUE),
    error = function(e) conditionMessage(e)
  )
  if (file.exists(file.path(test_dir, "test.html"))) {
    say("OK", "Test document rendered with Quarto")
  } else {
    say("PROBLEM", "Quarto could not render the test document. Message:")
    cat(paste("    ", res), sep = "\n")
    ok <- FALSE
  }
}

# 6. Workshop files ------------------------------------------------------------
if (file.exists("materials/raw-data/siteA_capetown_metadata.csv")) {
  say("OK", "Workshop data found")
} else {
  say("NOTE", "Workshop data not found. Make sure you opened r-you-reproducible.Rproj (the working directory should be the workshop folder).")
}

cat("\n")
if (ok) {
  cat("ALL CHECKS PASSED. You are ready for the workshop!\n\n")
} else {
  cat("SOME CHECKS FAILED. Fix the items above, or use Posit Cloud (see SETUP.md).\n")
  cat("If you are stuck, email ami-info@sun.ac.za with a screenshot of this output.\n\n")
}
