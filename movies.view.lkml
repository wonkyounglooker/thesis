view: movies {
  sql_table_name: mak_movies.movies ;;
# derived_table: {
#   sql: SELECT * FROM mak_movies.movies
#   WHERE EXTRACT(YEAR FROM release_date) = {% parameter liquid_parameter_test %};;
# }

# parameter: won_date_parameter {
#   type: string
#   allowed_value: {
#     label: "last week"
#     value: "last week"
#   }
# }
dimension: dimensionalized_count {
}


filter: won_num_filter {
  type: number
}

filter: string_filter {
  type: string
}

dimension: get_filter_value {
  type: number
  sql: {{ won_num_filter._value }} ;;
}

parameter: won_string_parameter {
  type: string
  suggest_dimension: genres.genre
  suggest_explore: names
}

filter: won_templated_filter {
  type: date
  datatype: date
}

parameter: liquid_parameter_test {
  type: number
}

dimension: date_diff {
  sql: DATE_DIFF(${release_date}, CAST({% date_start won_templated_filter %} AS DATE), day) ;;
}

dimension: access_grant_dimension {
  type: string
  # required_access_grants: [won_access_test]
  sql: ${imdbid} ;;
  html:
   {% if won_templated_filter._is_filtered %}
      {% if won_string_parameter._parameter_value == "Drama"  %}
        "some value"
      {% endif %}
   {% elsif get_filter_value._is_filtered %}
      {% if won_string_parameter._parameter_value == "Western" %}
          "some other value"
      {% endif %}
    {% else %}
      "else case"
    {% endif %} ;;
}

measure: referencing_access_grant_dimension {
  type: sum
  sql: ${budget} ;;
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
    # sql: ${TABLE}.belongs_to_collection ;;
    sql:
'<p class=MsoNormal><o:p>&nbsp;'    ;;
# html: {{ value | strip_html }} ;;
    html: {% assign words =  value | escape | replace: "&lt;", "µ" |  replace: "&gt;", "µ" | split: 'µ'  %}

    {% assign i = 0 %}

    {% for word in words %}

    {% assign m = i | modulo: 2 %}

    {% if m == 0 %}

    {{ word }}

    {% endif %}

    {% assign i = i | plus: 1 %}

    {% endfor %}

    ;;
  }

  dimension: belongs_to_collection_second {
    type:  string
    sql: ${belongs_to_collection} ;;
    html: {{ value | replace: "&nbsp:", " " }} ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
    value_format_name: usd_0
    html: <p style="font-size:20px">{{ value}}</p> ;;

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
    order_by_field: loss_rank.loss_rank
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.overview ;;
  }

  dimension: popularity {
    type: number
    sql: ${TABLE}.popularity ;;
  }

  dimension: class_name {
    type: string
    sql: ${TABLE}.original_title ;;
    drill_fields: [revenue, popularity]
    link: {
      label: "by Asset Subclass"
      url: "{% assign vis_config =
      '{
      \"x_axis_gridlines\":true,
      \"y_axis_gridlines\":true,
      \"show_view_names\":false,
      \"show_y_axis_labels\":true,
      \"show_y_axis_ticks\":true,
      \"y_axis_tick_density\":\"default\",
      \"y_axis_tick_density_custom\":5,
      \"show_x_axis_label\":true,
      \"show_x_axis_ticks\":true,
      \"y_axis_scale_mode\":\"linear\",
      \"x_axis_reversed\":false,
      \"y_axis_reversed\":false,
      \"plot_size_by_field\":false,
      \"trellis\":\"\",
      \"stacking\":\"\",
      \"limit_displayed_rows\":false,
      \"legend_position\":\"center\",
      \"point_style\":\"circle_outline\",
      \"show_value_labels\":false,
      \"label_density\":25,
      \"x_axis_scale\":\"auto\",
      \"y_axis_combined\":true,
      \"show_null_points\":true,
      \"interpolation\":\"linear\",
      \"series_types\":{},
      \"x_axis_datetime_label\":\"%b '%y\",
      \"type\":\"looker_line\",
      \"ordering\":\"none\",
      \"show_null_labels\":false,
      \"show_totals_labels\":false,
      \"show_silhouette\":false,
      \"totals_color\":\"#808080\",
      \"defaults_version\":1,
      \"hidden_fields\": [
      \"sim_tick.total_nav\"
      ]}'%}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis"
    }
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

#   dimension: won_logo_test {
#     sql: "https://images.app.goo.gl/6w3ShV8zLitvZb3h6" ;;
#   html: <img src="{{ value }}>" ;;
#   }

  dimension: production_companies {
    type: string
    sql: ${TABLE}.production_companies ;;
    html: <font color="#42a338 ">{{ rendered_value }}</font> ;;
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
      hour,
      week_of_year
    ]
#     convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }

# convert start day of the week to a Satruday - Sunday model, because this is the CCC team payroll cycle
  dimension: ticket_creation_payroll_week {
    label: "Created Week"
    # description: "Payroll week with a start date on Sunday"
    group_label: "Payroll Week"
    type: date
    datatype: date
    convert_tz: no
    sql: case when ${release_day_of_week} = 'Sunday' then ${release_date}
            when ${release_day_of_week} = 'Monday' then DATE_SUB(${release_date}, interval 1 day)
            when ${release_day_of_week} = 'Tuesday' then DATE_SUB(${release_date}, interval 2 day)
            when ${release_day_of_week} = 'Wednesday' then DATE_SUB(${release_date}, interval 3 day)
            when ${release_day_of_week} = 'Thursday' then DATE_SUB(${release_date}, interval 4 day)
            when ${release_day_of_week} = 'Friday' then DATE_SUB(${release_date}, interval 5 day)
            when ${release_day_of_week} = 'Saturday' then DATE_SUB(${release_date}, interval 6 day)
        end;;
    # sql: case when ${release_day_of_week} = 'Sunday' then ${release_date}
    #         when ${release_day_of_week} = 'Monday' then ${release_date} - interval '1 day'
    #         when ${release_day_of_week} = 'Tuesday' then ${release_date} - interval '2 day'
    #         when ${release_day_of_week} = 'Wednesday' then ${release_date} - interval '3 day'
    #         when ${release_day_of_week} = 'Thursday' then ${release_date} - interval '4 day'
    #         when ${release_day_of_week} = 'Friday' then ${release_date} - interval '5 day'
    #         when ${release_day_of_week} = 'Saturday' then ${release_date} - interval '6 day'
    #     end;;
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

  parameter: genre_random {
    type: string
  }

  dimension: return_parameter_value {
    sql: COALESCE(${genres.genre}, {% parameter genre_random %}) ;;
  }

parameter: currency {
  type: string
  allowed_value: {
    label: "USD"
    value: "USD"
  }
  allowed_value: {
    label: "GBP"
    value: "GBP"
  }
  allowed_value: {
    label: "EUR"
    value: "EUR"
  }
  allowed_value: {
    label: "CAD"
    value: "CAD"
  }
}

dimension: currency_parameter_value {
  type: string
  sql:  {{ currency._parameter_value }};;
}

  dimension: revenue {
    type: number
    label: "test"
     sql: ${TABLE}.revenue ;;

  }

measure: won_test_measure {
  type: number
  sql: ${revenue}*${count_movies};;
}

  measure: dynamic_revenue_tier {
    type: number
    sql: TRUNC(${TABLE}.revenue / (max(${TABLE}.revenue)*0.1), 0) * (max(${TABLE}.revenue)*0.1) ;;
  }
# #change it back to measure
  measure: revenue_sum {
    type: sum
    # type: number
    sql: ${TABLE}.revenue ;;
#     html:
#     {% if value == null %}
# <p style="color: white; background-color: black">{{ rendered_value }}</p>
# {% else %}
# <p style="color: white; background-color: black;>{{ rendered_value }}</p>
# {% endif %} ;;

  }


  set: won_set {
    fields:[movies.ALL_FIELDS*]
  }
  measure: revenue_sum_number {
    type: number
    sql: ${revenue_sum} ;;
    html: {{ revenue_sum._rendered_value }} ;;
    drill_fields: [won_set*]
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

  measure: new_count_measure {
    type: count
    drill_fields: [revenue_rank.revenue_rank, movies.title, movies.release_year, movies.movies_poster]
  }
  measure: count_movies {
    type: count
#     html: <p style="color:red;">{{ value }}</p> ;;
    # drill_fields: [revenue_rank.revenue_rank, movies.title, movies.release_year, movies.movies_poster]
    link: {
      label: "Drill Into Movies"
      url: "{{ new_count_measure._link }}&sorts=revenue_rank.revenue_rank"
    }
}

measure: 2016_count_movies{
  type: count
  filters: [release_year: "2016"]
}

measure: 2017_count_movies {
  type: count
  filters: [release_year: "2017"]
}

measure: 2016_2017_count_diff {
  type: number
  sql:  (${2017_count_movies}/NULLIF(${2016_count_movies},0))-1;;
}

  measure: won_count {
    type: count
    html: <a type="button" style="background-color:blue"target="_blank" href="{{link}}" class="btn btn-primary btn-lg btn-block">{{value}}</a>;;
    #btn btn-primary btn-lg btn-block
#     drill_fields: [detail*]
    drill_fields: [won_set*]
    # filters: [release_date: "after today"]
}

  measure: sum_popularity {
    type: sum
    sql: ${TABLE}.popularity ;;
    # html:
    # {% if _user_attributes['favorite_state'] == "california" %}
    #   <a href="https://dcl.dev.looker.com/explore/won_thesis_movies/movies?fields=movies.title,movies.release_year,movies.movies_poster, movies.sum_popularity&f[genres.genre]={{ genres.genre._value }}&f[movies.release_year]={{ movies.release_year._value }}&f[imdb_ratings.num_votes]=>=5000&sorts=movies.sum_popularity desc"</a>
    # {% else %}
    #   <a href="https://dcl.dev.looker.com/explore/won_thesis_movies/movies?fields=release_year,movies.movies_poster, movies.sum_popularity&f[genres.genre]={{ genres.genre._value }}&f[movies.release_year]={{ movies.release_year._value }}&f[imdb_ratings.num_votes]=>=5000&sorts=movies.sum_popularity desc"</a>
    # {% endif %} ;;

    # link: {
    #   label: "Drill Into Movies"
    #   url: "https://dcl.dev.looker.com/{{ _user_attributes['favorite_state'] }}?Genre={{ genres.genre._value | url_encode }}"
    #   # url: "/dashboards/285?{{ 'Test%' | url_encode }}={{ 4 | url_encode }}"

    # }
    link: {
      label: "won_drilling_test"
      url: "https://dcl.dev.looker.com/dashboards-next/1053?Video(Yes/No)=Yes"

    }
  }

measure: list_test{
  type: list
  list_field: genres.genre
  order_by_field: count_movies
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
