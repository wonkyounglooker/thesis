# If necessary, uncomment the line below to include explore_source.
# include: "won_thesis_movies.model.lkml"

view: keywords_ndt {
  derived_table: {
    explore_source: keywords {
      column: id {}
      column: keywords {}
      filters: {
        field: keywords.keywords
        value: "something"
      }
    }
  }
  dimension: id {
    type: number
  }
  dimension: keywords {}
}
