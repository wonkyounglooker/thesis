view: sql_runner_query {
  derived_table: {
    sql: SELECT
        genres.genre  AS genres_genre,
        COUNT(DISTINCT movies.id ) AS movies_count_movies
      FROM mak_movies.movies  AS movies
      LEFT JOIN mak_movies.imdb_ratings  AS imdb_ratings ON movies.imdbid = imdb_ratings.tconst
      LEFT JOIN mak_movies.genres  AS genres ON movies.id = genres.movieid

      WHERE
        (imdb_ratings.vote_count  >= 5000)
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: genres_genre {
    type: string
    sql: ${TABLE}.genres_genre ;;
  }

  dimension: movies_count_movies {
    type: number
    sql: ${TABLE}.movies_count_movies ;;
  }

  set: detail {
    fields: [genres_genre, movies_count_movies]
  }
}
