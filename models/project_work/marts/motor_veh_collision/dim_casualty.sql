
WITH casualty AS (
    SELECT DISTINCT 
         CAST(number_of_persons_injured AS INT) AS number_of_persons_injured 
        ,CAST(number_of_persons_killed AS INT)  AS number_of_persons_killed
    FROM {{ref('staging_tbl_veh_collision')}}
    WHERE number_of_persons_killed IS NOT NULL 
        OR number_of_persons_injured  IS NOT NULL

)

,dim_casualty AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['number_of_persons_injured', 'number_of_persons_killed']) }} AS casualty_key
        ,number_of_persons_injured 
        ,number_of_persons_killed
    FROM casualty
)

SELECT *
FROM dim_casualty
