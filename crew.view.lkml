# Not touched
view: crew {
  sql_table_name: mak_movies.crew ;;

   #ex) tt0000009, tt0000036
  # probably primary key - COUNT(*) = COUNT(DISTINCT )
  dimension: string_field_0 {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

   # ex) nm0085156,  nm0005690
  dimension: string_field_1 {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  # ex) nm0085156,  nm0410331
  dimension: string_field_2 {
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
