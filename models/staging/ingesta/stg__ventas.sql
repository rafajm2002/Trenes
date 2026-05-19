with 

source as (

    select * from {{ source('ingesta', 'ventas') }}

),

renamed as (

    select
        id_sale as id_venta,
        trip_id as id_viaje,
        passenger_id as id_pasajero,
        tipo,
        num_tickets_vendidos,
        importe,
        canal,
        fecha_origen,
        fecha_destino,
        fecha_compra,
        id_estacion_origen,
        id_estacion_destino,

    from source

)

select * from renamed