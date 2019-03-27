# tiers?
view: imdb_ratings {
  sql_table_name: mak_movies.imdb_ratings ;;

  dimension: avg_rating {
    type: number
    sql: ${TABLE}.avg_rating ;;
  }

  # imdbid in movies
  dimension: tconst {
    type: string
    primary_key: yes
    sql: ${TABLE}.tconst ;;
  }

  dimension: num_votes {
    type: number
    sql: ${TABLE}.vote_count ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_of_num_of_votes {
    type: sum
    sql: ${TABLE}.vote_count ;;
#     html: <a href="https://dcl.dev.looker.com/explore/won_thesis_movies/movies?fields=movies.title,imdb_ratings.sum_of_num_of_votes,movies.release_year&f[genres.genre]={{ genres.genre._value }}&f[movies.release_year]={{ movies.release_year._value }}&f[imdb_ratings.num_votes]=>=5000&sorts=genres.genre 0,movies.release_year&limit=500&column_limit=50&query_timezone=America/New_York">
#           {{ value }}
#           </a>;;
    link: {
      label: "Drill Movies"
      url: "https://dcl.dev.looker.com/explore/won_thesis_movies/movies?fields=movies.title,imdb_ratings.sum_of_num_of_votes,movies.release_year, movies.movies_poster&f[genres.genre]={{ genres.genre._value }}&f[movies.release_year]={{ movies.release_year._value }}&f[imdb_ratings.num_votes]=>=5000&sorts=imdb_ratings.sum_of_num_of_votes desc&limit=500&column_limit=50&query_timezone=America/New_York"
    }
  }
}
