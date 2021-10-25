- dashboard: won_download_test
  title: won_download test
  layout: newspaper
  # preferred_viewer: dashboards-next
  preferred_viewer: dashboards
  filters_bar_collapsed: false
  elements:
  - title: New Tile
    name: New Tile
    model: won_thesis_movies
    explore: movies
    type: looker_column
    fields: [names.name, movies.count_movies]
    filters:
      cast_crew.category: "-NULL"
      genres.genre: ''
    sorts: [movies.count_movies desc 0, names.name]
    limit: 50000
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      movies.count_movies: "#f06363"
    hidden_fields: []
    y_axes: []
    defaults_version: 1
    row:
    col:
    width:
    height:
  filters:
  - name: Genre
    title: Genre
    type: field_filter
    model: won_thesis_movies
    explore: movies
    field: genres.genre
