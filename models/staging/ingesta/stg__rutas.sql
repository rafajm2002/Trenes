with 

source as (

    select * from {{ source('ingesta', 'viajes') }}

),

renamed as (

    select
        id_ruta,
        service as servicio,
        TRIM(CAST(origin_station_id as VARCHAR)) as id_estacion_origen,
        origin_station_name as nombre_estacion_origen,
        TRIM(CAST(destination_station_id as VARCHAR)) as id_estacion_destino,
        destination_station_name as nombre_estacion_destino,
        num_stops as num_paradas,
        distance_km_total as distancia_total_km,
        cast(duration_min_total as int) as duracion_total_min,
        avg_speed_kmh as velocidad_media_kmh,
        frequency_daily as frecuencia_diaria,

    from source

),

deduplicated as (

    select *
    from renamed
    qualify row_number() over (
        partition by id_ruta
        order by id_ruta
    ) = 1

)

select *
from deduplicated