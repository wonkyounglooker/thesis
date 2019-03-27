view: revenue_rank {
  derived_table: {
    sql:
      SELECT id, title, revenue, RANK() OVER (ORDER BY revenue DESC) AS rank
      FROM `mak_movies.movies` AS movies
      LEFT JOIN `mak_movies.imdb_ratings`  AS imdb_ratings ON movies.imdbid = imdb_ratings.tconst
      WHERE (imdb_ratings.vote_count  >= 5000)
      GROUP BY 1,2,3
      ORDER BY 4 ASC ;;
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

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    hidden: yes
  }

  dimension: revenue_rank {
    type: number
    sql:  ${TABLE}.rank ;;
  }
}
