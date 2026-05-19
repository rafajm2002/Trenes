with 

source as (

    select * from {{ source('ingesta', 'estaciones') }}

),

renamed as (

    select
        _id as id_estacion,
        TRIM(CAST(CODIGO AS VARCHAR)) AS codigo_estacion,
        DESCRIPCION AS nombre_estacion,
        LATITUD AS latitud,
        LONGITUD AS longitud,
        DIRECION AS direccion,
        CP as cp,
        POBLACION AS municipio,
        PROVINCIA AS provincia,
        PAIS AS pais,
        CERCANIAS AS cercanias, 
        FEVE AS feve,
        COMUN AS comun

    from source

)

select * from renamed