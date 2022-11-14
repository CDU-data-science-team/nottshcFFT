# Many of these relate to code used on the SQL server side
# where .data$colm and .db_data$colm will not work
# Many of the column names are used in the get_() functions so are treated like
# functions by lintr

utils::globalVariables(c(
  "recoded",
  # comments.R
  "answer",
  "patient_id",
  "formtype",
  "team_c",
  "rn_pivot",
  "outcomes",
  # scores_cleaned.R
  "assessment_date",
  "time",
  # filter_ch_mh.R
  "fftCategory",
  # filter_recorded.R
  "responses",
  "n",
  # save_files.R
  "file_string"
))
