view: affinity_movies_cast_crew {
  derived_table: {
    sql:
    SELECT
      movies.id AS movies_id,
      movies.title  AS movies_title,
      movies.poster_path AS movies_poster_path,
      movies.release_date AS movies_release_date,
      movies.revenue  AS movies_revenue,
      names.nconst AS names_nconst,
      names.name  AS names_name,
      names.birth_year  AS names_birth_year,
      names.death_year  AS names_death_year,
      CASE
          WHEN
          names.death_year LIKE '%N' AND names.birth_year NOT LIKE '%N'
            THEN EXTRACT (year from current_date()) - cast(names.birth_year AS int64)
          WHEN names.death_year NOT LIKE '%N' AND names.birth_year NOT LIKE '%N'
            then CAST(names.death_year AS int64)-cast(names.birth_year as int64)
          ELSE NULL
        END AS names_age
    FROM mak_movies.names  AS names
    LEFT JOIN ${cast_crew.SQL_TABLE_NAME} AS cast_crew ON names.nconst = cast_crew.nconst
    LEFT JOIN mak_movies.crew_ids  AS crew_ids ON crew_ids.tconst = cast_crew.tconst
    LEFT JOIN mak_movies.movies  AS movies ON movies.imdbid = crew_ids.tconst
    LEFT JOIN mak_movies.imdb_ratings  AS imdb_ratings ON movies.imdbid = imdb_ratings.tconst

    WHERE ((cast_crew.category IS NOT NULL)) AND (imdb_ratings.vote_count  >= 5000)
    GROUP BY 1,2,3,4,5,6,7,8,9
    ;;

    datagroup_trigger: won_thesis_movies_default_datagroup
    indexes: ["movies_id", "movies_release_date"]


  }

  dimension: movies_title {}

  dimension: movies_release_date {
  }
  dimension: movies_revenue {}
  dimension: names_name {}
  dimension: names_birth_year {}
  dimension: names_death_year {}
  dimension: names_age {}
}
