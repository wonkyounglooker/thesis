connection: "lookerdata_standard_sql"

# include all the views
include: "*.view"

datagroup: won_thesis_movies_default_datagroup {
  sql_trigger: SELECT CURDATE() ;;
  max_cache_age: "1 hour"
}

persist_with: won_thesis_movies_default_datagroup

explore: affinity_movies_appearance_affinity {
  label: "Affinity"
  view_label: "Affinity"

  join: affinity_total_movies {
    type: cross
    relationship: many_to_one
  }
}

explore: movies {
  always_filter: {
    filters: {
      field: imdb_ratings.num_votes
      value: ">=5000"
    }
  }

  join: keywords_clean {
    sql_on: ${movies.id} = ${keywords_clean.movieid} ;;
    relationship:  one_to_many
    type:  left_outer
  }
  join: imdb_ratings {
    sql_on: ${movies.imdbid} = ${imdb_ratings.tconst} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: genres {
    sql_on: ${movies.id} = ${genres.movieid};;
    relationship: one_to_many
    type:  left_outer
  }
  join: revenue_rank {
    sql_on: ${movies.id} = ${revenue_rank.id} ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: loss_rank {
    sql_on: ${movies.id} = ${loss_rank.id} ;;
    relationship: one_to_many
    type:  left_outer
  }

#   join: top_set {
#     sql_on: ${movies.title} = ${top_set.title} ;;
#     relationship: one_to_one
#     type: inner
#   }

  join: crew_ids {
    sql_on: ${movies.imdbid} = ${crew_ids.tconst} ;;
    relationship:  many_to_many
    type: left_outer
  }

  join: cast_crew {
    sql_on: ${crew_ids.tconst} = ${cast_crew.tconst} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: names {
    sql_on: ${names.nconst} = ${cast_crew.nconst} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: director_movie_mapping {
    sql_on: ${movies.imdbid} = ${director_movie_mapping.imdbid} ;;
    relationship:one_to_one
    fields: [] #hidden from the users
    type:  left_outer
  }

  join: directors {
    sql_on: ${director_movie_mapping.director_id} = ${directors.director_id} ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: names {
  label: "People"

#   always_filter: {
#     filters: {
#       field: imdb_ratings.num_votes
#       value: ">=5000"
#     }
#   }

  join: cast_crew {
    sql_on: ${names.nconst} = ${cast_crew.nconst} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: crew_ids {
    sql_on: ${crew_ids.tconst} = ${cast_crew.tconst} ;;
    relationship:  many_to_many
    type: left_outer
  }

  join: movies {
    sql_on: ${movies.imdbid} = ${crew_ids.tconst} ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: genres {
    sql_on: ${movies.id} = ${genres.movieid};;
    relationship: one_to_many
    type:  left_outer
  }

  join: imdb_ratings {
    sql_on: ${movies.imdbid} = ${imdb_ratings.tconst} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: director_movie_mapping {
    sql_on: ${movies.imdbid} = ${director_movie_mapping.imdbid} ;;
    relationship:one_to_one
    fields: [] #hidden from the users
  }

  join: directors {
    sql_on: ${director_movie_mapping.director_id} = ${directors.director_id} ;;
    relationship: many_to_one
  }

  join: revenue_rank {
    sql_on: ${movies.id} = ${revenue_rank.id} ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: loss_rank {
    sql_on: ${movies.id} = ${loss_rank.id} ;;
    relationship: one_to_many
    type:  left_outer
  }
}
