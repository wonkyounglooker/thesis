view: genres {
  sql_table_name: mak_movies.genres ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
    case_sensitive: no
  }

  filter: genre_selector {
    type: string
  }

  dimension: movieid {
    type: number
    value_format_name: id
    # hidden: yes
    sql: ${TABLE}.movieid ;;
  }

  measure: genres_count {
    type: count
    drill_fields: [id, movies.id]
  }

}
