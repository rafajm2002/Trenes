{{
    config(
        materialized = 'table'
    )
}}

WITH base_dates AS (

    {{
        dbt.date_spine(
            'day',
            "DATE('2000-01-01')",
            "DATE('2030-01-01')"
        )
    }}

),

final AS (

    SELECT
        CAST(date_day AS DATE) AS fecha_dia,

        YEAR(date_day) AS anio,
        MONTH(date_day) AS mes_numero,

        CASE MONTH(date_day)
            WHEN 1 THEN 'enero'
            WHEN 2 THEN 'febrero'
            WHEN 3 THEN 'marzo'
            WHEN 4 THEN 'abril'
            WHEN 5 THEN 'mayo'
            WHEN 6 THEN 'junio'
            WHEN 7 THEN 'julio'
            WHEN 8 THEN 'agosto'
            WHEN 9 THEN 'septiembre'
            WHEN 10 THEN 'octubre'
            WHEN 11 THEN 'noviembre'
            WHEN 12 THEN 'diciembre'
        END AS mes,

        DAY(date_day) AS dia,

        DAYOFWEEK(date_day) AS dia_semana_numero,

        CASE DAYOFWEEK(date_day)
            WHEN 0 THEN 'domingo'
            WHEN 1 THEN 'lunes'
            WHEN 2 THEN 'martes'
            WHEN 3 THEN 'miércoles'
            WHEN 4 THEN 'jueves'
            WHEN 5 THEN 'viernes'
            WHEN 6 THEN 'sábado'
        END AS dia_semana,

        WEEK(date_day) AS semana,
        QUARTER(date_day) AS trimestre,

        CASE
            WHEN DAYOFWEEK(date_day) IN (0,6)
            THEN TRUE
            ELSE FALSE
        END AS es_fin_de_semana

    FROM base_dates
)

SELECT *
FROM final
WHERE fecha_dia > DATEADD(year, -4, CURRENT_DATE())
  AND fecha_dia < DATEADD(day, 30, CURRENT_DATE())