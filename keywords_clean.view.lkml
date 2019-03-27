# SELECT *
# FROM `lookerdata.mak_movies.keywords_clean`
# WHERE id IN (SELECT MAX(id) FROM `lookerdata.mak_movies.keywords_clean` GROUP BY keyword)

# keywords NOT in JSON. Cleaned-up version
view: keywords_clean {
  sql_table_name: mak_movies.keywords_clean ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: movieid {
    type: number
    value_format_name: id
    # hidden: yes
    sql: ${TABLE}.movieid ;;
  }

  measure: count_keywords {
    type: count
    drill_fields: [id, movies.id]
  }
}
