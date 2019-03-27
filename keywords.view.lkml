# The dimension keywords is in JSON
# [{'id': 10148, 'name': 'tribe'}, {'id': 10787, 'name': 'jungle'}, {'id': 12617, 'name': 'airplane crash'}]
view: keywords {
  sql_table_name: mak_movies.keywords ;;

  # count(*) != count(distinct id)
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.keywords ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
