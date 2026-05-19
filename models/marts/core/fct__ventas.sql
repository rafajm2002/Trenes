{{ config(materialized = 'table') }}

WITH fct_ventas AS (
    SELECT
        v.*,
        eo.codigo_estacion AS codigo_estacion_origen,
        eo.nombre_estacion AS estacion_origen,
        eo.municipio AS municipio_origen,
        eo.provincia AS provincia_origen,
        ed.codigo_estacion AS codigo_estacion_destino,
        ed.nombre_estacion AS estacion_destino,
        ed.municipio AS municipio_destino,
        ed.provincia AS provincia_destino,
        p.* exclude(id_pasajero)
    FROM {{ ref('stg__ventas') }} v
    LEFT JOIN {{ ref('dim__estaciones') }} eo ON v.id_estacion_origen = eo.id_estacion
    LEFT JOIN {{ ref('dim__estaciones') }} ed ON v.id_estacion_destino = ed.id_estacion
    LEFT JOIN {{ ref('dim__pasajeros') }} p ON v.id_pasajero = p.id_pasajero
    LEFT JOIN {{ ref('dim__tiempo') }} dt ON v.fecha_compra = dt.fecha_dia
)

SELECT * FROM fct_ventas