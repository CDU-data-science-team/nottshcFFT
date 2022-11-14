#' Clean comments
#'
#' @description specifically for the comments in Best. Removes any records with
#' hardcoded 'N/A' and any blank rows. Ensures only unique comments are retained
#' and recodes emoticons/emojis (only those that have been added to function).
#'
#' @param data created from using function \code{\link{recode_scores}}
#'
#' @return data frame
#' @export
comments_clean <- function(data) {

  # Duplicates occur because of date recorded differences
  comments <- data %>%
    dplyr::filter(
      recoded == "Best",
      !is.na(answer),
      stringr::str_detect("answer", "N/A") == FALSE,
      stringr::str_length(answer) > 1 # Remove blank lines
    ) %>%
    dplyr::distinct() %>%
    dplyr::mutate(assessment_date = lubridate::ymd(assessment_date)) %>%
    dplyr::select(
      -"question",
      "outcomes"
    ) %>%
    dplyr::rename(
      TeamC = "team_c", # renamed to match SQL tables
      Date = "assessment_date",
      Time = "time"
    ) %>%
    dplyr::mutate(
      answer = dplyr::case_when(
        answer == "" ~ NA_character_,
        # removing NAs in unite replaces comments with ""
        TRUE ~ answer
      ),
      # removing emoticons/emojis that cause errors on upload
      answer = stringr::str_replace_all(
        answer, "â€™",
        "'"
      ),
      answer = stringr::str_replace_all(
        answer, "ðŸ˜¢",
        ""
      ),
      answer = stringr::str_replace_all(
        answer, "ðŸ™‚,",
        ""
      ),
      answer = stringr::str_replace_all(
        answer, "ðŸ‘Œ",
        ""
      ),
      answer = stringr::str_replace_all(
        answer, "ðŸ™",
        "Slightly Frowning Face emoji"
      ),
      answer = stringr::str_replace_all(
        answer, "ðŸ¤•",
        "Sad emoji"
      ),
      answer = stringr::str_replace_all(
        answer, "ðŸ’“",
        "'"
      ),
    ) %>%
    dplyr::rename(Best = answer)

  # Removed ðŸ˜¢ and ðŸ™ as unclear what this is and a BI task opened
  # about utf-8 issues

  comments
}
