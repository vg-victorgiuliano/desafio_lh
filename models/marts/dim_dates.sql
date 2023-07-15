with generated_dates as(
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date = "cast('2005-05-24' as date)",
        end_date = "cast('2007-05-14' as date)"
  ) }}
),

exploded_dates as(
    select
        date_day as sk_date
        , extract(day from date_day) as day
        , extract(month from date_day) as month
        , extract(quarter from date_day) as quarter
        , extract(year from date_day) as year
        , extract(dayofweek from date_day) as weekday
    from generated_dates
),

final as(
    select 
        sk_date
        , day
        , month
        , case 
            when month = 1 then 'Jan'
            when month = 2 then 'Feb'
            when month = 3 then 'Mar'
            when month = 4 then 'Apr'
            when month = 5 then 'May'
            when month = 6 then 'Jun'
            when month = 7 then 'Jul'
            when month = 8 then 'Aug'
            when month = 9 then 'Sep'
            when month = 10 then 'Oct'
            when month = 11 then 'Nov'
            when month = 12 then 'Dec'
            end as month_abbreviation
        , weekday
        , case 
            when weekday = 1 then 'Sunday'
            when weekday = 2 then 'Monday'
            when weekday = 3 then 'Tuesday'
            when weekday = 4 then 'Wednesday'
            when weekday = 5 then 'Thursday'
            when weekday = 6 then 'Friday'
            when weekday = 7 then 'Saturday'
            end as day_of_week
        , quarter
        , year
    from exploded_dates
)
select * from final