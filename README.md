# 60-Day Supply Chain Data Analyst Roadmap

Daily work log for my transition into supply chain analytics.
Tools: Excel, SQL, Power BI, Python (Pandas).

## Progress
Day 1: Cleaned a 500-row parts master dataset. Removed [20] duplicates, fixed [8] issues. See 01_parts_clean.xlsx and the Cleaning_Log.xlsx

Day 2: Pulled supplier and lead time into orders using XLOOKUP; 25 unmatched part numbers found and fixed. See 02_Lookup.xlsx

Day 3: Built supplier, category and plant summaries using SUMIFS, COUNTIFS and AVERAGEIFS; added UNIT_COST and SPEND columns; reconciled totals to source data.

Day 4: Split part numbers, built month/quarter fields, and created dynamic FILTER/UNIQUE lists.

Day 5: Built PivotTables for supplier spend, category-month trends and plant delivery performance with slicers; totals reconciled to source.

Day 6: Cleaned and merged parts and orders with Power Query (merge, append, unpivot); automated refresh and reconciled totals.

Day 7: Built an Excel supply chain dashboard (KPIs, PivotCharts, slicers) from the Power Query-cleaned orders data.

Day 8: Loaded parts and orders into MySQL and wrote filter queries with SELECT, WHERE, LIKE, IN, BETWEEN.

Day 9: Summarised parts and orders with GROUP BY and HAVING (category, supplier, plant, year); results matched the Excel dashboard.
