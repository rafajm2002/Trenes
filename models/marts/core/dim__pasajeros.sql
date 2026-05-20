{{ config(materialized = 'table') }}

select
    p.id_pasajero,
    p.nombre,
    p.apellidos,
    p.dni,
    p.fecha_nacimiento,
    p.telefono,
    p.email,
    p.id_municipio,

    m.codigo_postal,
    m.nombre_municipio,
    m.nombre_provincia,
    m.nombre_comunidad,
    m.cod_provincia

from {{ ref('stg__pasajeros') }} p

left join {{ ref('dim__municipios') }} m
    on p.id_municipio = m.id_municipio