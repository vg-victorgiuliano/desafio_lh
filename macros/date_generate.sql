{% macro date_spine_macro(starting_date, ending_date) %}
WITH date_spine AS (
  {{ dbt_utils.date_spine(
    datepart="day",
    start_date = starting_date,
    end_date = ending_date
  ) }}
)
SELECT *
FROM date_spine
{% endmacro %}