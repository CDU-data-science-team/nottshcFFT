#' Cleaning Scores
#'
#' @param data data frame for scores_old and scores_new data derived from the
#' function \code{\link{recode_scores}}.
#'
#' @return data frame
#' @export
scores_cleaned <- function(data) {
  scores_load <- data %>%
    dplyr::filter(recoded != "Best") %>%
    dplyr::distinct() %>%
    dplyr::group_by(
      patient_id,
      # Due to duplicates but different scores recorded needs rn
      assessment_date,
    ) %>%
    dplyr::mutate(
      rn_pivot = dplyr::row_number(),
      assessment_date = lubridate::ymd(assessment_date),
    ) %>%
    dplyr::select(
      "patient_id",
      "assessment_date",
      "time",
      "formtype",
      "addedby",
      "team_c",
      "rn_pivot",
      "recoded",
      "outcomes"
    ) %>%
    tidyr::pivot_wider(patient_id:rn_pivot,
      values_from = outcomes,
      names_from = recoded
    ) %>%
    dplyr::select(-rn_pivot) %>%
    dplyr::mutate(dplyr::across(
      tidyr::any_of(c(
        "Therapist",
        "Listening",
        "InvCare",
        "Service"
      )),
      as.numeric
    )) %>%
    dplyr::rename(
      TeamC = team_c, # renamed to match SQL tables
      Date = assessment_date,
      Time = time
    )

  scores_load
}
