view: director_movie_mapping {
  derived_table: {
    sql: select movies.imdbid, directors.director_id
          from `lookerdata.mak_movies.movies` as movies
          join `lookerdata.mak_movies.directors` as directors
          on movies.imdbid = directors.movie_id
          group by 1,2
          ;;
    datagroup_trigger: won_thesis_movies_default_datagroup
  }

  dimension: imdbid {}

  dimension: director_id {}
}
