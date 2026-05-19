with source as (

    select * from {{ source('ingesta', 'ventas') }}

),

renamed as (

    select
        passenger_id as id_pasajero,
        initcap(trim(nombre)) as nombre,
        initcap(trim(apellidos)) as apellidos,
        upper(trim(dni)) as dni,
        fecha_nacimiento,
        regexp_replace(telefono, '\\s+', '') as telefono,
        lower(trim(email)) as email,
        id_municipio as ciudad,

    from source

),

deduplicated as (

    select *
    from renamed
    qualify row_number() over (
        partition by id_pasajero
        order by id_pasajero
    ) = 1

)

select
    id_pasajero,
    nombre,
    apellidos,
    dni,
    fecha_nacimiento,
    telefono,
    email,
    ciudad
from deduplicated