# should include only actors and actresses
# category originally includes directors, writers, producers, editors, composer,
#   self, cinematographer, etc.
view: cast_crew {
#   sql_table_name: `lookerdata.mak_movies.cast_crew` ;;
  derived_table: {
    sql: SELECT *
         FROM `lookerdata.mak_movies.cast_crew` AS cast_crew
         WHERE category IN ("actor","actress")
          AND category IS NOT NULL;;

    datagroup_trigger: won_thesis_movies_default_datagroup
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: characters {
    type: string
    sql: ${TABLE}.characters ;;
  }

  dimension: job {
    type: string
    sql: ${TABLE}.job ;;
  }

  dimension: nconst {
    type: string
    sql: ${TABLE}.nconst ;;
  }


  dimension: ordering {
    type: string
    sql: ${TABLE}.ordering ;;
    hidden: yes
  }

  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: test_movies {
    sql: ${movies.title} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
