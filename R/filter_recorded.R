#' Filtering by recorded type
#'
#' @param data data frame called df
#' @param type String, either "ch" for community health or "mh" for mental
#' health. Will default to the first if not determined so will be "ch". Includes
#' function \code{\link{filter_ch_mh}} to separate data accordingly.
#'
#' @return data frame
#' @export
filter_recorded <- function(data,
                            type = c("ch", "mh")) {

  # Check function arguments
  type <- match.arg(type)

  df <- data %>%
    dplyr::mutate(responses = dplyr::case_when(
      addedby == "SMS" ~ "SMS/text",
      TRUE ~ "Other"
    ))

  if (type == "ch") {
    df <- df %>%
      dplyr::mutate(responses = dplyr::case_when(
        is.na(addedby) ~ "Online survey",
        addedby == "jisc" ~ "Online survey",
        stringr::str_detect(addedby, "[.]") == TRUE ~
          "Paper/postcard",
        TRUE ~ responses
      )) %>%
      dplyr::mutate(responses = factor(responses, levels = c(
        "SMS/text",
        "Smartphone app/tablet/kiosk",
        "Paper/postcard",
        "Telephone survey",
        "Online survey",
        "Other"
      )))
    df
  }

  if (type == "mh") {
    df <- df %>%
      dplyr::mutate(responses = dplyr::case_when(
        is.na(addedby) ~ "Online survey after discharge",
        addedby == "jisc" ~ "Online survey after discharge",
        stringr::str_detect(addedby, "[.]") == TRUE ~
          "Paper/postcard after discharge",
        TRUE ~ responses
      )) %>% # need to check if before or after discharge
      dplyr::mutate(responses = factor(responses,
        levels = c(
          "SMS/text",
          "Smartphone app/tablet/kiosk before or at point of discharge",
          "Smartphone app/tablet after discharge",
          "Paper/postcard before or at point of discharge",
          "Paper/postcard after discharge",
          "Telephone survey after discharge",
          "Online survey after discharge",
          "Other"
        )
      ))
    df
  }

  df <- nottshcFFT::filter_ch_mh(df, type)

  df %>%
    dplyr::count(responses) %>%
    tidyr::complete(responses, fill = list(n = 0)) %>%
    tidyr::pivot_wider(
      names_from = responses,
      values_from = n,
      values_fill = list(n = 0)
    )
}
