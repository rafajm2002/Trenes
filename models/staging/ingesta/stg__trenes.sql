with 

source as (

    select * from {{ source('ingesta', 'viajes') }}

),

renamed as (

    select
        id_tren,
        id_descripcion

    from source

),

deduplicated as (

    select *
    from renamed
    qualify row_number() over (
        partition by id_tren
        order by id_tren
    ) = 1

)

select *
from deduplicated