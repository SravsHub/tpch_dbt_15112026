select * 
from 
{{ ref('stg_lineitems') }} 
where discount < 0 
   or discount > 0.10