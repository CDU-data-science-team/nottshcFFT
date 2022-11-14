.onAttach <- function(libname, pkgname) {
  version <- read.dcf(
    file = system.file("DESCRIPTION", package = pkgname),
    fields = "Version"
  )

  # define object with all team members
  nottshc_ds_team_names <- c("Lori", "Chris", "Zoe")

  # randomly pick one team member (based on probability)
  nottshc_ds_team_praise <- sample(nottshc_ds_team_names,
    size = 1,
    prob = c(0.5, 0.5, 0.5)
  )

  cli::cli_h1(paste0(
    nottshc_ds_team_praise, ", ",
    stringr::str_to_lower(praise::praise())
  ))

  cli::cli_text(paste0("This is ", pkgname, " ", version))
  cli::cli_text(paste0(pkgname, " is currently in development -
                       please report any bugs or ideas at:"))
  cli::cli_text("https://github.com/CDU-data-science-team/nottshcFFT/issues")

  cli::cli_h1("Connection required to NOTTSHC servers:")
  cli::cli_alert_info(
    "Microsoft SQL server to download - contact AI"
  )
  cli::cli_alert_info(
    "MySQL server to upload - contact CDU"
  )
}
