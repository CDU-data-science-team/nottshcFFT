#' Clean Scores
#' @description function to clean SQL code from Scores and Scores2 code, makes
#' SQL column names snake_case, select only necessary columns and recode the
#' long questions to match the MySQL column names of Listening, InvCare,
#' Service, Therapist and Best. Also filters out all questions
#' that are NA as a result of recoding.
#'
#' @param data data frame for Scores and Scores2 data
#'
#' @return data frame
#' @export
recode_scores <- function(data) {
  scores_recode <- data %>%
    janitor::clean_names() %>%
    dplyr::select(
      "patient_id",
      "assessment_date",
      "time",
      "formtype",
      "addedby",
      "question",
      "answer",
      "team_c"
    ) %>%
    dplyr::mutate(
      recoded = dplyr::case_when(
        str_detect(
          question,
          "Did staff listen to you and treat your concerns seriously?"
        )
        == TRUE ~ "Listening",
        str_detect(
          question,
          "Did you feel involved in making choices about your treatment and care?"
        )
        == TRUE ~ "InvCare",
        str_detect(
          question,
          "How satisfied were you with your assessment"
        )
        == TRUE ~ "Service", # From assessment
        str_detect(
          question,
          "Did you have confidence in your therapist and his / her skills and techniques?"
        )
        == TRUE ~ "Therapist",
        str_detect(
          question,
          "Please use this space to tell us about your experience of our service"
        )
        == TRUE ~ "Best", # From treatment (Best was previously coded R name)
        str_detect(
          question,
          "Please use this space to tell us about your experience of our service so far"
        )
        == TRUE ~ "Best", # From assessment
        TRUE ~ NA_character_
      ),
      outcomes = dplyr::case_when(
        answer %in% c("Completely Satisfied", "At all times") ~ 5,
        answer %in% c("Mostly Satisfied", "Most of the time") ~ 4,
        answer %in% c("Sometimes", "Neither Satisfied nor Dis-satisfied") ~ 3,
        answer == "Not Satisfied" ~ 2,
        # Not sure what this is as not been used yet
        answer %in% c("Never", "Not at All Satisfied") ~ 1
      )
    ) %>%
    dplyr::filter(!is.na(recoded))

  scores_recode
}
