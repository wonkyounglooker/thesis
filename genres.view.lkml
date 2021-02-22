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
    sql: 1=1;;
    html: {{ _user_attributes['sf_test'] }} ;;
  }

  measure: genres_count {

    type: count
    drill_fields: [id, movies.id]
    value_format_name: "usd"
    html: <a href="{{link}}">{{ rendered_value }}</a> ;;
  }

<<<<<<< HEAD
  measure: movied_count {
    type: count_distinct
    sql: ${movieid} ;;
  }

  measure: division {
    type: number
    sql: CASE WHEN (${genres_count}/${movied_count}) >2 then 'yes'
    ELSE null END;;
  }
=======
>>>>>>> branch 'master' of git@github.com:wonkyounglooker/thesis.git
}
