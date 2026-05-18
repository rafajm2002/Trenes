with 

source as (

    select * from {{ source('ingesta', 'viajes') }}

),

renamed as (

    select       
        trip_id as id_viaje,
        route_id as id_ruta,
        id_tren,
        departure as hora_salida,
        arrival as hora_llegada,
        cast(departure as date) as fecha_viaje,
        distance_km as distancia_km,
        cast(duration_min as int) as duracion_min,
        service_type as tipo_servicio,
        loaded_synced as fecha_carga

    from source

)

select * from renamed