# olist-delivery-analysis
# Notes

## Decisions
- Analysis covers 2017-01 to 2018-08
  2016 is sparse (no orders in 2016-11), excluded. also 2018-09 excluded because there is just one order.
- Revenue = item price


## Data quality notes
- order_reviews has duplicate reviews per order (99,224 rows vs 98,673 unique order_id). Plan for Q4: aggregate to one row per order (e.g. AVG(review_score) GROUP BY order_id) before joining.

## Q1 Monthly revenue: observations

- Strong growth in 2017: orders rose from 787 (2017-01) to 7,421 (2017-11); revenue from 120k to 1.00M.
  *Source: 01_monthly_revenue.sql*

- 2018 is a plateau: monthly orders stay between ~6,100 and ~7,200 and revenue between ~840k and ~1.0M. Revenue in 2018-08 (849k) is ~14.5% below the 2018-05 level (993k).
  *Source: 01_monthly_revenue.sql, 01c_yearly_ranges.sql*

- Same-period comparison (Jan-Aug): orders 22,562 in 2017 vs 53,530 in 2018 (+137%); revenue 3.08M vs 7.34M (+138%).
  *Source: 01b_year_comparison.sql*

- Average revenue per order stays in a narrow range (125-153) with no clear trend, so growth is almost entirely volume-driven, not basket-size-driven. (2017-01 has only 787 orders, so its average is less reliable.)
  *Source: 01_monthly_revenue.sql, 01c_yearly_ranges.sql*

- Peak month: 2017-11 (1,003,862.14; 7,421 orders), but 2018-04 and 2018-05 are within ~1%.
  *Source: 01a_peak_months.sql*

- Hypothesis (not provable with this data): the Nov 2017 spike is Black Friday / year-end season.

- Open question: why did growth stop in 2018? Worth checking delivery performance (Q3/Q4).


## Q2 ...
