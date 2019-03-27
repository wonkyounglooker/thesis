view: production_countries {
  sql_table_name: mak_movies.production_countries ;;

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

  dimension: production_country {
    type: string
    sql: ${TABLE}.production_country ;;
  }

  measure: count {
    type: count
    drill_fields: [id, movies.id]
  }
}
