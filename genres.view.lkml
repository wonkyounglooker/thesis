view: genres {
  sql_table_name: mak_movies.genres ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: genre {
    type: string
    group_label: "Test"
    group_item_label: "Genre dimension"
    sql: ${TABLE}.genre ;;
    case_sensitive: no
  }

  filter: genre_selector {
    type: string
  }

  dimension: movieid {
    type: number
    value_format_name: id
    # hidden: yes
    sql: 1=1;;
    html: {{ _user_attributes['sf_test'] }} ;;
  }

  measure: genres_count {

    type: count
    drill_fields: [id, movies.id]
  }

  measure: movied_count {
    type: count_distinct
    sql: ${movieid} ;;
  }

  measure: division {
    type: number
    sql: CASE WHEN (${genres_count}/${movied_count}) >2 then 'yes'
    ELSE null END;;
  }
}
