{{ config(materialized = 'table') }}

WITH fct_viajes AS (
    SELECT
        v.*,
        r.* exclude(id_ruta),
        t.* exclude(id_tren),
        rt.* exclude(id_viaje)
    FROM {{ ref('stg__viajes') }} v
    LEFT JOIN {{ ref('dim__rutas') }} r ON v.id_ruta = r.id_ruta
    LEFT JOIN {{ ref('dim__trenes') }} t ON v.id_tren = t.id_tren
    LEFT JOIN {{ ref('dim__retrasos') }} rt ON v.id_viaje = rt.id_retraso
    LEFT JOIN {{ ref('dim__tiempo') }} dt ON v.fecha_viaje = dt.fecha_dia
)

SELECT * FROM fct_viajes