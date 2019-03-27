view: affinity_movies_appearance_affinity {
  derived_table: {
    indexes: ["cast_a"]
    sql:
      WITH movie_id_getter AS
            (SELECT mc1.names_name AS cast_a,
            mc2.names_name AS cast_b,
            mc1.movies_title AS movie_title,
            mc1.movies_poster_path AS movie_poster_path,
            mc1.movies_release_date AS movie_release
            FROM ${affinity_movies_cast_crew.SQL_TABLE_NAME} AS mc1
            JOIN ${affinity_movies_cast_crew.SQL_TABLE_NAME} AS mc2
              ON mc1.movies_id = mc2.movies_id
              AND mc1.names_nconst <> mc2.names_nconst -- ensures we don't match on the same cast in the same movie, which would corrupt our frequency metrics on this self-join
              WHERE {% condition affinity_timeframe %} mc1.movies_release_year {% endcondition %}
              AND {% condition affinity_timeframe %} mc2.movies_release_year {% endcondition %}
              GROUP BY cast_a, cast_b, movie_title, movie_poster_path, movie_release
            )

      SELECT prop.cast_a,
             prop.cast_b,
             movie_id_getter.movie_title AS movie_title,
             movie_id_getter.movie_poster_path AS movie_poster_path,
             movie_id_getter.movie_release AS movie_release,
             joint_movie_count,
             tmc1.cast_crew_movies_count AS cast_a_movie_count,
             tmc2.cast_crew_movies_count AS cast_b_movie_count
      FROM (SELECT mc1.names_name AS cast_a,
            mc2.names_name AS cast_b,
            COUNT(*) AS joint_movie_count
            FROM ${affinity_movies_cast_crew.SQL_TABLE_NAME} AS mc1
            JOIN ${affinity_movies_cast_crew.SQL_TABLE_NAME} AS mc2
              ON mc1.movies_id = mc2.movies_id
              AND mc1.names_nconst <> mc2.names_nconst -- ensures we don't match on the same cast in the same movie, which would corrupt our frequency metrics on this self-join
--              AND mc1.names_nconst > mc2.names_nconst -- Does this get rid of the duplicates (Daniel & Rupert, Rupert & Daniel)?
              WHERE {% condition affinity_timeframe %} mc1.movies_release_year {% endcondition %}
              AND {% condition affinity_timeframe %} mc2.movies_release_year {% endcondition %}
              GROUP BY cast_a, cast_b
            ) as prop
      JOIN ${affinity_total_movie_cast_crew.SQL_TABLE_NAME} as tmc1 ON prop.cast_a = tmc1.names_name
      JOIN ${affinity_total_movie_cast_crew.SQL_TABLE_NAME} as tmc2 ON prop.cast_b = tmc2.names_name
      JOIN movie_id_getter AS movie_id_getter ON CONCAT(movie_id_getter.cast_a,movie_id_getter.cast_b) = CONCAT(prop.cast_a,prop.cast_b)
      ORDER BY cast_a, joint_movie_count DESC, cast_b
      ;;

#      datagroup_trigger: won_thesis_movies_default_datagroup
  }

  filter: affinity_timeframe {
    type: date
  }

  dimension_group: movie_release {
    type: time
    timeframes: [
      raw,
      date,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.movie_release ;;
  }

  dimension: cast_a {
    type: string
    sql: ${TABLE}.cast_a ;;
    case_sensitive: no
  }

  dimension: movie_title {
    type: string
    sql: ${TABLE}.movie_title ;;
    hidden: yes
    case_sensitive: no

  }

  dimension: cast_b {
    type: string
    sql: ${TABLE}.cast_b ;;
    case_sensitive: no

  }

#   dimension: joint_movie_count {
#     description: "How many times cast A and B were in the same movie"
#     type: number
#     sql: ${TABLE}.joint_movie_count ;;
#     value_format: "#"
#   }

 dimension: movie_poster {
   sql:  ${TABLE}.movie_poster_path ;;
    html:
    <img src="http://image.tmdb.org/t/p/w185/{{ value }}" /> ;;
 }

  measure: joint_movie_count {
    description: "How many times cast A and B were in the same movie"
    type: count
    sql: ${TABLE}.joint_movie_count ;;
    value_format: "#"
    drill_fields: [movie_title, movie_release_year, movie_poster]
  }

  dimension: cast_a_movie_count {
    description: "Total number of movies with cast A in them, during specified timeframe"
    type: number
    sql: ${TABLE}.cast_a_movie_count ;;
    value_format: "#"
  }

  dimension: cast_b_movie_count {
    description: "Total number of movies with cast B in them, during specified timeframe"
    type: number
    sql: ${TABLE}.cast_b_movie_count ;;
    value_format: "#"
  }



  #  Frequencies
  measure: cast_a_movie_with_b_frequency {
    description: "How frequently movies have cast B as a percent of Cast A's total movies"
    type: number
    sql: 1.0*${joint_movie_count}/${cast_a_movie_count} ;;
    value_format: "#.00%"
  }

#   dimension: cast_b_movie_frequency {
#     description: "How frequently movies have cast B as a percent of total movies"
#     type: number
#     sql: 1.0*${cast_b_movie_count}/${affinity_total_movies.count} ;;
#     value_format: "#.00%"
#   }

#   dimension: joint_movie_frequency {
#     description: "How frequently movies have both cast A and B as a percent of total movies"
#     type: number
#     sql: 1.0*${joint_movie_count}/${affinity_total_movies.count} ;;
#     value_format: "#.00%"
#   }

  # Affinity Metrics

#   dimension: add_on_frequency {
#     description: "How many times both cast are casted when Cast A is casted"
#     type: number
#     sql: 1.0*${joint_movie_count}/${cast_a_movie_count} ;;
#     value_format: "#.00%"
#   }

#   dimension: lift {
#     description: "The likelihood that casting Cast A drove the casting of Cast B"
#     type: number
#     sql: 1*${joint_movie_frequency}/(${cast_a_movie_frequency} * ${cast_b_movie_frequency}) ;;
#     value_format: "#,##0.#0"
#   }

#   ## Do not display unless users have a solid understanding of  statistics and probability models
#   dimension: jaccard_similarity {
#     description: "The probability both items would be purchased together, should be considered in relation to total order count, the highest score being 1"
#     type: number
#     sql: 1.0*${joint_order_count}/(${product_a_order_count} + ${product_b_order_count} - ${joint_order_count}) ;;
#     value_format: "#,##0.#0"
#   }
#
#   # Aggregate Measures - ONLY TO BE USED WHEN FILTERING ON AN AGGREGATE DIMENSION (E.G. BRAND_A, CATEGORY_A)
#
#
#   measure: aggregated_joint_order_count {
#     description: "Only use when filtering on a rollup of product items, such as brand_a or category_a"
#     type: sum
#     sql: ${joint_order_count} ;;
#   }
# }



}
