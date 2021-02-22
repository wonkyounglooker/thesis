view: test {
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

}
