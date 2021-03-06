view: names {
  sql_table_name: mak_movies.names ;;

 dimension: test_date {
  # sql: ${movies.release_date};;
  sql:  SELECT
                                -- subscribers_converted_from_free_to_paid_period.subscriber_payment_type,
                                --TO_CHAR(DATE_TRUNC('day', subscribers_converted_from_free_to_paid_period.date_ts_from),'YYYY-MM-DD') AS transaction_day,
                                ${movies.release_date} AS test_date
                              FROM ${movies.SQL_TABLE_NAME} AS movies_view;;
 }

  dimension: birth_year {
    type: string
    sql: ${TABLE}.birth_year ;;
  }

  dimension: death_year {
    type: string
    sql: ${TABLE}.death_year ;;
  }

  dimension: known_for {
    type: string
    sql: ${TABLE}.known_for ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    case_sensitive: no
  }

  dimension: nconst {
    type: string
    sql: ${TABLE}.nconst ;;
    primary_key: yes
  }

  dimension: primary_profession {
    type: string
    sql: ${TABLE}.primary_profession ;;
    case_sensitive: no
  }

  dimension: age {
    type: number
     sql:
    CASE
      WHEN
      ${death_year} LIKE '%N' AND ${birth_year} NOT LIKE '%N'
        THEN EXTRACT (year from current_date()) - cast(${birth_year} AS int64)
      WHEN ${death_year} NOT LIKE '%N' AND ${birth_year} NOT LIKE '%N'
        then CAST(${death_year} AS int64)-cast(${birth_year} as int64)
      ELSE NULL
    END;;
  }

  dimension: field_from_movies {
    sql: ${movies.title} ;;
  }
#   dimension: imdb_person_image {
#     type: string
#     sql: ${TABLE}.nconst;;
#     html: <img src="https://www.imdb.com/name/{{ value }}" /> ;;
#     html:  <a href="https://www.imdb.com/name/{{ ['movies.imdbid'] }}">
#           <img src="http://image.tmdb.org/t/p/w185/{{ value }}" />
#           </a> ;;
#   }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
