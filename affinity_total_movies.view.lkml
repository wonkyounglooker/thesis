view: affinity_total_movies {
  derived_table: {
    sql: SELECT COUNT(*) AS count
        FROM mak_movies.movies AS movies
    ;;

  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
     view_label: "Movie Appearance Affinity"
     label: "Total Movie Count"
  }
}
