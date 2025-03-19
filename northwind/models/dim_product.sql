-- models/dim_product.sql
SELECT
    {{ dbt_utils.generate_surrogate_key(['p.ProductID']) }} AS supplierkey,
    p.ProductID AS productid,
    p.ProductName AS productname,
    p.SupplierID AS supplierid,
    c.CategoryName AS categoryname,
    c.Description AS categorydescription
FROM {{ source('northwind', 'Products') }} p
LEFT JOIN {{ source('northwind', 'Categories') }} c
    ON p.CategoryID = c.CategoryID
