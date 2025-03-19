WITH stg_orders AS (
    SELECT 
        o.orderid,
        o.employeeid,
        o.customerid,
        o.orderdate
    FROM {{ source('northwind', 'Orders') }} o
),

stg_order_details AS (
    SELECT 
        od.orderid,
        od.productid,
        od.quantity,
        od.unitprice,
        od.discount,
        (od.quantity * od.unitprice) AS extendedpriceamount,
        (od.quantity * od.unitprice * od.discount) AS discountamount,
        (od.quantity * od.unitprice * (1 - od.discount)) AS soldamount
    FROM {{ source('northwind', 'Order_Details') }} od
)

SELECT
    o.employeeid,
    o.customerid,
    o.orderdate,
    od.productid,
    o.orderid,
    od.quantity,
    od.extendedpriceamount,
    od.discountamount,
    od.soldamount
FROM stg_orders o
JOIN stg_order_details od ON o.orderid = od.orderid
