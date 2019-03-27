view: loss_rank {
  derived_table: {
    sql:
      SELECT id, title, budget, revenue, (budget-revenue) AS loss, RANK() OVER (ORDER BY (budget-revenue) DESC) AS rank
      FROM `mak_movies.movies`
      GROUP BY 1,2,3, 4, 5
      ORDER BY 6 DESC ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes

  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    case_sensitive: no
    hidden: yes
  }

  dimension: loss {
    type: number
    sql: ${TABLE}.budget-${TABLE}.revenue ;;
    hidden: yes
  }

  dimension: loss_rank {
    type: number
    sql:  ${TABLE}.rank ;;
  }
}
