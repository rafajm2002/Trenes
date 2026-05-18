with 

source as (

    select * from {{ source('ingesta', 'retrasos') }}

),

renamed as (

    select
        delay_id as id_retraso,
        trip_id as id_viaje,
        delay_minutes as minutos_retraso,
        delay_reason as motivo_retraso,
        weather_related as relacion_meteorologica

    from source

)

select * from renamed