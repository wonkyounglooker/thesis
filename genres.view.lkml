view: genres {
  sql_table_name: mak_movies.genres ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: genre {
    label: "Girl Grade"
    view_label: "Membership"
    group_label: "Member Segmentation"
    type: string
    sql: ${TABLE}.genre ;;
    case_sensitive: no
  }

  dimension: test_dimension {
    type: string
    sql: coalesce(${TABLE}.genre, "Not applicable") ;;
  }

measure: genre_list {
  type: list
  list_field: genre
}

  filter: genre_selector {
    type: string
  }

  dimension: movieid {
    type: number
    value_format_name: id
    # hidden: yes
    sql: ${TABLE}.movieid ;;
  }

  measure: genres_count {
    type: count
    drill_fields: [id, movies.id]
    value_format_name: "usd"
    html: <a href="{{link}}">{{ rendered_value }}</a> ;;
  }

}
