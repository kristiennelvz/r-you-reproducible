# Setup instructions

There are two ways to take part. **Option A** (installing on your own laptop) is best, because you keep a working setup afterwards. **Option B** (Posit Cloud) runs in your web browser and needs no installation, so use it if you cannot install software (e.g. on a managed work laptop) or if Option A fails.

Please complete one of the options **before the workshop**. Downloads can be slow on venue Wi-Fi.

---

## Option A: Install on your laptop

### Step 1. Install R

R is the programming language we use.

- Go to **https://cran.r-project.org** and choose your operating system:
  - **Windows:** click *Download R for Windows*, then *base*, then the *Download R-x.x.x for Windows* link. Run the installer and accept the default options.
  - **macOS:** click *Download R for macOS* and choose the installer that matches your Mac (Apple silicon M1/M2/M3/M4, or older Intel Macs). To check which you have, click the Apple menu, then *About This Mac*.
  - **Linux:** follow the instructions for your distribution on the same page.
- You need **R 4.3 or newer**. If you already have R, check your version by typing `R.version.string` in the R Console. If it is older, install the new version (your old packages will need to be reinstalled).

### Step 2. Install RStudio Desktop

RStudio is the program we use to write and run R code. It also includes **Quarto**, which we use to create reports, so you do not need to install Quarto separately.

- Go to **https://posit.co/download/rstudio-desktop/** and download the free RStudio Desktop installer for your system (step 2 on that page).
- Install it with the default options.
- If you already have RStudio, update it if it is older than version 2023.06 (*Help > Check for Updates* in RStudio).

**Using another editor (e.g. Positron or VS Code)?** You are welcome to, but then install Quarto separately from **https://quarto.org/docs/get-started/**. The workshop instructions are written for RStudio.

### Step 3. Download the workshop materials

- On the GitHub page of this repository, click the green **Code** button, then **Download ZIP**.
- Unzip (extract) the file. On Windows, right-click the ZIP file and choose *Extract All*; do not work inside the ZIP file.
- Put the unzipped folder somewhere easy to find, e.g. *Documents*. Avoid folders synced by OneDrive/Dropbox/iCloud if you can, because syncing can lock files while you work.

### Step 4. Open the project and run the setup check

1. In the unzipped folder, double-click **`r-you-reproducible.Rproj`**. RStudio opens, with the workshop folder as the working directory.
2. In the *Files* panel (bottom right), click **`check_setup.R`** to open it.
3. Click **Source** (top right of the script panel).
4. If packages are missing, the script asks *"Install the missing packages now? [y/n]"*. Type `y` in the Console and press Enter. Installation takes a few minutes. If RStudio asks *"Do you want to install from sources the packages which need compilation?"*, answer **No**.
5. The script ends with either:
   - **`ALL CHECKS PASSED`**: you are ready.
   - **`SOME CHECKS FAILED`**: read the lines marked `[MISSING]`, `[UPDATE]` or `[PROBLEM]`, fix them and run the check again. If you are stuck, email a screenshot of the output to **ami-info@sun.ac.za**, or switch to Option B.

The packages used in the workshop are: `here`, `readr`, `dplyr`, `tidyr`, `stringr`, `lubridate`, `janitor`, `knitr` and `rmarkdown`. To install them yourself, paste this into the Console:

```r
install.packages(c("here", "readr", "dplyr", "tidyr", "stringr", "lubridate", "janitor", "knitr", "rmarkdown"))
```

---

## Option B: Posit Cloud (no installation)

Posit Cloud runs RStudio in your web browser. The free plan includes a limited number of project hours per month, which is plenty for this workshop. You only need a web browser and an internet connection.

### Step 1. Create a free account

- Go to **https://posit.cloud** and click **Sign Up**.
- Choose the **Free** plan and sign up with your email address, Google or GitHub account.

### Step 2. Create the workshop project

1. Once logged in, you are in *Your Workspace*. Click **New Project** (top right), then **New Project from Git Repository**.
2. Paste the address of this repository: **`https://github.com/[ACCOUNT]/r-you-reproducible`** and click **OK**.
3. Wait a minute while Posit Cloud sets up the project. RStudio opens in your browser, with the workshop files in the *Files* panel (bottom right).

### Step 3. Install the packages and run the setup check

Each Posit Cloud project starts with an empty package library, so you need to install the packages once in this project.

1. In the *Files* panel, click **`check_setup.R`**, then click **Source**.
2. When asked *"Install the missing packages now? [y/n]"*, type `y` in the Console and press Enter. This takes a few minutes.
3. Run the check again (click **Source**). It should end with **`ALL CHECKS PASSED`**.

Do this before the workshop, so the packages are ready.

### Tips for Posit Cloud

- Your project is saved automatically. Next time, log in at https://posit.cloud and open the project from *Your Workspace*.
- Close the browser tab when you are done. Projects that are left open use up your monthly hours.
- To keep your work after the workshop, select files in the *Files* panel and choose *More > Export* to download them.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| "Package ... is not available" | Check your internet connection. In RStudio, go to *Tools > Global Options > Packages* and choose a different CRAN mirror (e.g. "Global (CDN)"), then try again. |
| Package installation fails at work | Your network may block downloads. Try from home, use a mobile hotspot, or use Posit Cloud. |
| No permission to install software | Ask your IT department, or use Posit Cloud. |
| "Quarto not found" | Update RStudio to the latest version (Quarto is included), then restart RStudio and run the check again. |
| The check says workshop data are not found | Open the project by double-clicking `r-you-reproducible.Rproj`, not by opening `check_setup.R` directly. |

Still stuck? Email **ami-info@sun.ac.za** with a screenshot of the error message.
