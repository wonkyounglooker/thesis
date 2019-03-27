view: top_set {
  sql_table_name: mak_movies.top_set ;;

  dimension: actors {
    type: string
    sql: ${TABLE}.Actors ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: director {
    type: string
    sql: ${TABLE}.Director ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.Genre ;;
  }

  dimension: metascore {
    type: number
    sql: ${TABLE}.Metascore ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.Rank ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.Rating ;;
  }

  dimension: revenue__millions_ {
    type: number
    sql: ${TABLE}.Revenue__Millions_ ;;
  }

  dimension: runtime__minutes_ {
    type: number
    sql: ${TABLE}.Runtime__Minutes_ ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.Title ;;
  }

  dimension: votes {
    type: number
    sql: ${TABLE}.Votes ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
