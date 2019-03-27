# primary keys? imdbId or movieId
view: links {
  sql_table_name: mak_movies.links ;;

  dimension: imdb_id {
    type: number
    sql: ${TABLE}.imdbId ;;
  }

  dimension: movie_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.movieId ;;
  }

  dimension: tmdb_id {
    type: number
    sql: ${TABLE}.tmdbId ;;
  }

#   measure: count {
#     type: count
#     drill_fields: [movies.id]
#   }
}
