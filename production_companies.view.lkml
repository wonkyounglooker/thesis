view: production_companies {
  sql_table_name: mak_movies.production_companies ;;

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

  dimension: production_company {
    type: string
    sql: ${TABLE}.production_company ;;
  }

  measure: count {
    type: count
    drill_fields: [id, movies.id]
  }
}
