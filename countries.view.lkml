# Can't run this table in the sql runner
view: countries {
  sql_table_name: mak_movies.countries ;;

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

  measure: count {
    type: count
    drill_fields: [id]
  }
}
