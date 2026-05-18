select 
    count(*) as viajes,
    count(r.id_viaje) as matches
from stg__viajes v
left join stg__retrasos r
    on v.id_viaje = r.id_viaje