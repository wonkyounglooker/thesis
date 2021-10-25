include: "*.view"
explore: countries {
  always_filter: {
    filters: [countries.country: "{{ _user_attributes['state'] }}"]
  }
}
