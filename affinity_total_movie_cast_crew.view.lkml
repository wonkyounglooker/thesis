view: affinity_total_movie_cast_crew {
  derived_table: {

    sql:
    SELECT names.name AS names_name,
      COUNT(CONCAT(names.name, CAST(movies.id AS string))) AS cast_crew_movies_count -- count of movies with a cast crew member
    FROM mak_movies.names  AS names
    LEFT JOIN ${cast_crew.SQL_TABLE_NAME} AS cast_crew ON names.nconst = cast_crew.nconst
    LEFT JOIN mak_movies.crew_ids  AS crew_ids ON crew_ids.tconst = cast_crew.tconst
    LEFT JOIN mak_movies.movies  AS movies ON movies.imdbid = crew_ids.tconst
    LEFT JOIN mak_movies.imdb_ratings  AS imdb_ratings ON movies.imdbid = imdb_ratings.tconst

    WHERE (cast_crew.category IS NOT NULL) AND (imdb_ratings.vote_count  >= 5000)
    GROUP BY 1
    ;;

    datagroup_trigger: won_thesis_movies_default_datagroup
  }
}
