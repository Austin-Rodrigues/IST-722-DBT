WITH f_sales AS (
    SELECT * FROM {{ ref('fact_sales') }}
),
d_employee AS (
    SELECT * FROM {{ ref('dim_employee') }}
),
d_customer AS (
    SELECT * FROM {{ ref('dim_customer') }}
),
d_product AS (
    SELECT * FROM {{ ref('dim_product') }}
),
d_date AS (
    SELECT * FROM {{ ref('dim_date') }}
)

SELECT
    fs.orderid,
    fs.orderdate,
    d_date.year,
    d_date.month,
    d_customer.COMPANYNAME AS customername,
    d_employee.EMPLOYEENAMEFIRSTLAST AS employeename,
    d_product.productname,
    d_product.categoryname,
    d_product.categorydescription,
    fs.quantity,
    fs.extendedpriceamount,
    fs.discountamount,
    fs.soldamount
FROM f_sales fs
LEFT JOIN d_employee 
    ON CAST(fs.employeeid AS STRING) = d_employee.employeekey
LEFT JOIN d_customer 
    ON fs.customerid = d_customer.customerkey
LEFT JOIN d_product 
    ON fs.productid = d_product.productid
LEFT JOIN d_date 
    ON fs.orderdate = d_date.datekey
