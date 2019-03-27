view: directors {
  derived_table: {
    sql:
      SELECT
      row_number() over (order by names.name) as id,
      director_id,
      names.name as director_name,
      names.primary_profession AS primary_profession
      from `lookerdata.mak_movies.movies` as movies
      join `lookerdata.mak_movies.directors` as directors
      on directors.movie_id = movies.imdbid
      join `lookerdata.mak_movies.names` as names
      on directors.director_id = names.nconst
      group by 2,3,4
       ;;
      datagroup_trigger: won_thesis_movies_default_datagroup
  }
#
#       case when names.birth_year like '%N' then null else names.birth_year end as birth_year,
#       case when names.death_year like '%N' then null else names.death_year end as death_year,
#       min(movies.release_date) as first_movie


  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # ex) nm9969565, nm9969557
  dimension: director_id {
    #primary_key: yes
    type: string
    sql: ${TABLE}.director_id ;;
  }

  # ex)   tt8692980, tt8693790
  # imdbid in movies
  dimension: movie_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.movie_id ;;
  }

  # From Names - Are they necessary?
  dimension: director_name {
    type: string
    sql:  ${TABLE}.director_name ;;
  }

  dimension: director_primary_profession {
    type: string
    sql:  ${TABLE}.primary_profession ;;
  }

  measure: count {
    type: count
    drill_fields: [director_id, movies.id]
  }
}
