view: writers {
  sql_table_name: mak_movies.writers ;;

  set: exclude {
    fields: [writer_id,birth_year]
  }

  dimension: writer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.writer_id ;;
  }

  dimension: birth_year {
    type: string
    sql: ${TABLE}.birth_year ;;
  }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movie_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.movie_id ;;
  }

  dimension: names_name {
    type: string
    sql: ${TABLE}.names_name ;;
  }

  measure: count_writers {
    type: count
    drill_fields: [writer_id, names_name, movies.id]
  }
}
