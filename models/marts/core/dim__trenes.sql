{{ config(materialized = 'table') }}

WITH tren AS (
    SELECT
        t.id_tren,
        d.* EXCLUDE (id_descripcion),
    FROM {{ ref('stg__trenes') }} t
    INNER JOIN {{ ref('stg__tren_descripcion') }} d ON d.id_descripcion = t.id_descripcion
)

SELECT * FROM tren