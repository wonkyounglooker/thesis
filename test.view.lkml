view: test {
<<<<<<< HEAD
  derived_table: {
    sql:
  SELECT
  genres.id  AS genres_id
FROM mak_movies.names  AS names
LEFT JOIN `lookerdata.looker_scratch.LR_RZPAB1607056004480_cast_crew` AS cast_crew ON names.nconst = cast_crew.nconst
LEFT JOIN mak_movies.crew_ids  AS crew_ids ON crew_ids.tconst = cast_crew.tconst
LEFT JOIN mak_movies.movies  AS movies ON movies.imdbid = crew_ids.tconst
LEFT JOIN mak_movies.genres  AS genres ON movies.id = genres.movieid;;
}



dimension: id {
  type: number
  sql: ${TABLE}.id ;;
}

=======
  sql_table_name:  mak_movies.movies ;;
  label: "@{won_model}"

  dimension: belongs_to_collection {
    type: string
    sql: ${TABLE}.belongs_to_collection ;;
  }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
>>>>>>> branch 'master' of git@github.com:wonkyounglooker/thesis.git
}
