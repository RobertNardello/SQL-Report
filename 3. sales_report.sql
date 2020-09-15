select
  period
  ,sales
  -- sales in the previous month
  --,lag(sales, 1) over w as "Previous Month"
  -- percentage change in sales since the previous month
  ,round((sales - lag(sales, 1) over w)/(lag(sales, 1) over w), 2) as "MoM"
  -- sales in the same month, previous year
  --,lag(sales, 12) over w as "Previous Year"
  -- Percentage change in monthly sales since the same month in previous year
  ,round((sales - lag(sales, 12) over w)/(lag(sales, 12) over w), 2) as "YoY"
  -- Compound Monthly Growth Rate over previous 12 months
  ,round((sales/lag(sales, 12) over w)^(1.0/12)-1, 2) as "CMGR"
  -- total sales within the same calendar year as the current row
  ,sum(sales) over y as "Annual Sales"
from sales
window
  w as (order by period)
  ,y as (partition by date_trunc('year', period))