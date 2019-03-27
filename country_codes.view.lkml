view: country_codes {
  sql_table_name: mak_movies.country_codes ;;

  # primary key
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  measure: country_code_count {
    type: count
    drill_fields: [id]
  }
}
