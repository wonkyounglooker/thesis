view: crew_ids {
  sql_table_name: mak_movies.crew_ids ;;

  # ex)   nm0085156,  nm0005690
  dimension: directors {
    type: string
    sql: ${TABLE}.directors ;;
  }

  # ex) tt0000009, tt0000036
  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
    primary_key: yes
  }

  # ex) nm0085156,  nm0410331
  dimension: writers {
    type: string
    sql: ${TABLE}.writers ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
