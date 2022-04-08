view: dt_totals2 {
  derived_table: {
    explore_source: if_ra_fact_invc_purch_hist {
      column: facility {
        field: if_ra_dim_cust_acct.facility
      }
      column: gx_name_drill {
        field: if_ra_dim_item.gx_name_drill
      }
      column: lbl_name_drill {
        field: if_ra_dim_ndc.lbl_name_drill
      }
      column: ndc_num_drill {
        field: if_ra_dim_ndc.ndc_num_drill
      }
      column: gx_flg {
        field: if_ra_dim_item.gx_flg
      }
      column: inflation {
        field: if_ra_fact_invc_purch_hist.inflation
      }
    }
  }

  dimension: facility {
    type: string
    hidden: yes
  }
  dimension: gx_name_drill {
    type: string
    hidden: yes
  }
  dimension: lbl_name_drill {
    type: string
    hidden: yes
  }
  dimension: ndc_num_drill {
    type: string
    hidden: yes
  }
  dimension: gx_flg {
    type: yesno
    hidden: yes
  }
  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(TO_CHAR(${facility}),TO_CHAR(${gx_name_drill}),TO_CHAR(${lbl_name_drill}),TO_CHAR(${ndc_num_drill}),TO_CHAR(${gx_flg}));;
  }
  dimension: inflation {
    type: number
    hidden: yes
  }
  measure: inflation_sum {
    type: sum
    sql: ${inflation} ;;
    value_format_name: usd
  }
}
