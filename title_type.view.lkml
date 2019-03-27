view: title_type {
  sql_table_name: mak_movies.title_type ;;

  dimension: end_year {
    type: string
    sql: ${TABLE}.end_year ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: is_adult {
    type: string
    sql: ${TABLE}.is_adult ;;
  }

  dimension: orig_title {
    type: string
    sql: ${TABLE}.orig_title ;;
  }

  dimension: runtime {
    type: string
    sql: ${TABLE}.runtime ;;
  }

  dimension: start_year {
    type: string
    sql: ${TABLE}.start_year ;;
  }

  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: title_type {
    type: string
    sql: ${TABLE}.title_type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
