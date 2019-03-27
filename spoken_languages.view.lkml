view: spoken_languages {
  sql_table_name: mak_movies.spoken_languages ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movieid {
    type: number
    value_format_name: id
    # hidden: yes
    sql: ${TABLE}.movieid ;;
  }

  dimension: spoken_language {
    type: string
    sql: ${TABLE}.spoken_language ;;
  }

  measure: count {
    type: count
    drill_fields: [id, movies.id]
  }
}
