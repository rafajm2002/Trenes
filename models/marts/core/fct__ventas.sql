{{ config(materialized = 'table') }}

WITH fct_ventas AS (
    SELECT
        v.*,
        e.* exclude(id_estacion),
        p.* exclude(id_pasajero)
    FROM {{ ref('stg__ventas') }} v
    LEFT JOIN {{ ref('dim__estaciones') }} e ON v.id_estacion_origen = e.id_estacion
    LEFT JOIN {{ ref('dim__pasajeros') }} p ON v.id_pasajero = p.id_pasajero
    LEFT JOIN {{ ref('dim__tiempo') }} dt ON v.fecha_viaje = dt.fecha_dia
)

SELECT * FROM fct_ventas