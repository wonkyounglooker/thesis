view: movies {
#   sql_table_name: mak_movies.movies ;;
derived_table: {
  sql: SELECT * FROM mak_movies.movies ;;
}


parameter: won_date_parameter {
  type: string
  allowed_value: {
    label: "last week"
    value: "last week"
  }
}

filter: won_num_filter {
  type: number
}

parameter: won_string_parameter {
  type: string
  suggest_dimension: genres.genre
}

filter: won_templated_filter {
  type: date
  datatype: date
}

dimension: date_diff {
  sql: DATE_DIFF(${release_date}, CAST({% date_start won_templated_filter %} AS DATE), day) ;;
}

dimension: liquid_test {
  type: string
  sql: ${imdbid} ;;
#   html:
#   <div align="center">{{rendered_value}}</div>
#
#       {% if imdb_ratings.avg_rating._value > 5000 %}<div align="center">
#         <b>FOUNDATIONS PORTFOLIO</b></div>
#       {% else %}<div align="center"><b>GRADUATION PORTFOLIO</b></div>
#       {% endif %}
#       <div align="center">{{ imdb_ratings.tconst._value }}</div>
#
#       <div align="center">Growth - {{ imdb_ratings.num_votes._value }}</div>
#        <div align="center">Performance Level - {{ imdb_ratings.avg_rating._value }}</div>;;
link: {
  label: "won Look url test"
#   Looker 1776 doesn't have a filter set on the genres.genre field. We can still pass it in the URL
  url: "https://dcl.dev.looker.com/looks/1776?&f[genres.genre]=Drama"
}
}

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
#     html: <img src="{{ value }}" width="140" height="190"/> ;;
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
      month_num,
      quarter,
      fiscal_quarter,
      fiscal_year,
      year,
      day_of_week,
      hour_of_day,
      week_of_year
    ]
#     convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }

  dimension: test_hour_of_day {
#     type: date_hour_of_day
    sql: ${release_hour_of_day} ;;
    html: {{ rendered_value | date: "%I %p" }} ;;
  }

  dimension: won_liquid_test {
    sql: {% date_end release_date %} ;;
  }

  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    default_value: "Date"
  }

  dimension: dynamic_timeframe {
    type: string
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Week' THEN ${movies.release_week}
    WHEN{% parameter timeframe_picker %} = 'Month' THEN ${movies.release_month}
    END ;;
  }

  parameter: genre_random {
    type: string
  }

  dimension: return_parameter_value {
    sql: COALESCE(${genres.genre}, {% parameter genre_random %}) ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    value_format_name:usd_0
  }

measure: won_test_measure {
  type: number
  sql: ${revenue}*${count_movies};;
}

  measure: dynamic_revenue_tier {
    type: number
    sql: TRUNC(${TABLE}.revenue / (max(${TABLE}.revenue)*0.1), 0) * (max(${TABLE}.revenue)*0.1) ;;
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
#     hidden: yes
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

  measure: won_test_measure2 {
    type: number
    sql: AVG(ABS(${vote_count}-${budget})) ;;
  }

  parameter: days {
    type: number
  }

dimension: day_old {
  type: number
  sql: date_diff(CURRENT_DATE, DATE(TIMESTAMP '2018-08-07 00:00:00'), DAY) ;;
}

measure: dummy_measure {
  type: sum
  sql: ${vote_count} ;;
}

  measure: count_movies {
    type: count
    drill_fields: [revenue_rank.revenue_rank, movies.title, movies.release_year, movies.movies_poster]
    link: {
      label: "Drill Into Movies"
      url: "{{ link }}&sorts=revenue_rank.revenue_rank"
    }
}

  measure: won_count {
    type: count
    html: <a type="button" style="background-color:blue"target="_blank" href="{{link}}" class="btn btn-primary btn-lg btn-block">{{value}}</a>;;
    #btn btn-primary btn-lg btn-block
    drill_fields: [detail*]
}

  measure: sum_popularity {
    type: sum
    sql: ${TABLE}.popularity ;;
    link: {
      label: "Drill Into Movies"
      url: "https://dcl.dev.looker.com/explore/won_thesis_movies/movies?fields=movies.title,movies.release_year,movies.movies_poster, movies.sum_popularity&f[genres.genre]={{ genres.genre._value }}&f[movies.release_year]={{ movies.release_year._value }}&f[imdb_ratings.num_votes]=>=5000&sorts=movies.sum_popularity desc&limit=500&query_timezone=America/New_York"
    }
  }

measure: yesno {
  type: yesno
  sql: ${sum_popularity}>50 OR ${count_movies}>100  ;;
}

measure: max_drill_test {
  type: max
  sql:  ${revenue} ;;
  drill_fields: [genres.id]
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
