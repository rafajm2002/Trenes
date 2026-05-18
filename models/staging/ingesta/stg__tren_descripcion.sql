with source as (

    select * from {{ source('ingesta', 'viajes') }}

),

renamed as (

    select

        id_descripcion,
        modelo,
        proposito,

        -- ancho de vía (limpieza de m + coma decimal)
        regexp_replace(
            replace(trim(split_part(ancho_via, '-', 1)), ',', '.'),
            '[^0-9\.]',
            ''
        )::float as ancho_via_m,

        -- velocidad máxima (quita Km/h y espacios)
        regexp_replace(velocidad_maxima, '[^0-9]', '')::int as velocidad_max_kmh,

        motores,

        -- potencia total
        regexp_replace(replace(potencia_total, ',', '.'), '[^0-9\.]', '')::float as potencia_total_kw,

        -- tensión
        regexp_replace(tension, '[^0-9]', '')::int as tension_kv,

        -- masa sin carga
        regexp_replace(replace(masa_sin_carga, ',', '.'), '[^0-9\.]', '')::float as masa_sin_carga_t,

        -- longitud total
        regexp_replace(replace(longitud_total, ',', '.'), '[^0-9\.]', '')::float as longitud_total_m,

        -- plazas sentadas (primer valor si viene tipo "123/105")
        try_to_number(trim(split_part(plazas_sentadas, '/', 1)))::int as plazas_sentadas,

        senalizacion,
        constructor,
        unidades_construidas::int as unidades_construidas

    from source

),

deduplicated as (

    select *
    from renamed
    qualify row_number() over (
        partition by id_descripcion
        order by id_descripcion
    ) = 1

)

select *
from deduplicated