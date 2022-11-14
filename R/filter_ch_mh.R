# Filter data for CH or MH submission----
#'
#' Filter data by CH or MH
#'
#' @description Score counts are required for CH (Community Health) and MH
#' (Mental Health) but have different categories. This function does the counts
#' according to whether its ch or mh.
#' @param data data frame called responses
#' @param type String, either "ch" for community health or "mh" for mental
#' health. Will default to the first if not determined so will be "ch".
#'
#' @return data frame
#' @export
filter_ch_mh <- function(data,
                         type = c("ch", "mh")) {

  # Check function arguments
  type <- match.arg(type)

  if (type == "ch") {
    df <- data %>%
      dplyr::filter(fftCategory %in% c(
        "Community inpatient services",
        "Community nursing services",
        "Rehabilitation and therapy services",
        "Specialist services (CH)",
        "Children and family services",
        "Community healthcare other"
      ))
  }

  if (type == "mh") {
    df <- data %>%
      dplyr::filter(fftCategory %in% c(
        "Primary care",
        "Secondary care community services",
        "Acute services",
        "Specialist services (MH)",
        "Secure and forensic services" # check in next month
        , "Child and adolescent mental health services",
        "Mental health other" # check in next month
      ))

    df
  }

  df
}
