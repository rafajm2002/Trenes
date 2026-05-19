with 

source as (

    select * from {{ source('ingesta', 'viajes') }}

),

renamed as (

    select       
        id_viaje,
        id_ruta,
        id_tren,
        fecha as fecha_viaje,
        hora_salida,
        hora_llegada,        
        distancia_km,
        duracion_min,
        tipo_servicio,
        loaded_synced as fecha_carga

    from source

)

select * from renamed