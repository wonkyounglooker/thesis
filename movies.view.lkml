view: movies {
  sql_table_name: mak_movies.movies ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  #type: yesno ?
  # True or False
  dimension: adult {
    type: string
    sql: ${TABLE}.adult ;;
    hidden: yes
  }

  dimension: belongs_to_collection {
    type: string
    sql: ${TABLE}.belongs_to_collection ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
    value_format_name: usd_0
  }

  # [{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}
  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
    hidden: yes
  }

  dimension: homepage {
    type: string
    sql: ${TABLE}.homepage ;;
  }

  # tconst in imdb_ratings
  dimension: imdbid {
    type: string
    sql: ${TABLE}.imdbid ;;
  }

  dimension: original_language {
    type: string
    sql: ${TABLE}.original_language ;;
    hidden:  yes
  }

  dimension: original_title {
    type: string
    sql: ${TABLE}.original_title ;;
    case_sensitive: no
    hidden: yes
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.overview ;;
  }

  dimension: popularity {
    type: number
    sql: ${TABLE}.popularity ;;
  }

  dimension: poster_path {
    type: string
    sql: ${TABLE}.poster_path ;;
  }

  dimension: movies_poster {
    sql:  ${TABLE}.poster_path ;;
#     html: <img src="http://image.tmdb.org/t/p/w185/{{ value }}" /> ;;
    html: <img src="http://image.tmdb.org/t/p/w185/{{ value }}" height=250/> ;;
  }

  dimension: production_companies {
    type: string
    sql: ${TABLE}.production_companies ;;
  }

  dimension: production_countries {
    type: string
    sql: ${TABLE}.production_countries ;;
    hidden: yes
  }

  dimension_group: release {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }

  dimension: latest_data_only{
    type: yesno
    sql: ${release_date} = current_date() ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    value_format_name:usd_0
  }

  measure: revenue_sum {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  dimension: revenue_minus_budget {
    type: number
    sql: ${TABLE}.revenue - ${TABLE}.budget ;;
    value_format_name: usd_0
  }

  dimension: runtime {
    type: number
    sql: ${TABLE}.runtime ;;
  }

  dimension: spoken_languages {
    type: string
    sql: ${TABLE}.spoken_languages ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tagline {
    type: string
    sql: ${TABLE}.tagline ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    case_sensitive: no
  }

  dimension: video {
    type: yesno
    sql: ${TABLE}.video ;;
    hidden: yes
  }

  # not accurate -
  dimension: vote_average {
    type: number
    sql: ${TABLE}.vote_average ;;
    hidden: yes
  }

  # not accurate
  dimension: vote_count {
    type: number
    sql: ${TABLE}.vote_count ;;
    hidden: yes
  }

  measure: count_movies {
    type: count
    drill_fields: [revenue_rank.revenue_rank, movies.title, movies.release_year, movies.movies_poster]
    link: {
      label: "Drill Into Movies"
      url: "{{ link }}&sorts=revenue_rank.revenue_rank"
    }
  }

  measure: sum_popularity {
    type: sum
    sql: ${TABLE}.popularity ;;
    link: {
      label: "Drill Into Movies"
      url: "https://dcl.dev.looker.com/explore/won_thesis_movies/movies?fields=movies.title,movies.release_year,movies.movies_poster, movies.sum_popularity&f[genres.genre]={{ genres.genre._value }}&f[movies.release_year]={{ movies.release_year._value }}&f[imdb_ratings.num_votes]=>=5000&sorts=movies.sum_popularity desc&limit=500&query_timezone=America/New_York"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      collections.count,
      directors.count,
      keywords_clean.count,
      links.count,
      production_companies.count,
      production_countries.count,
      spoken_languages.count,
      writers.count
    ]
  }
}
