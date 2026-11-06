
 CREATE TABLE dbo.CustomerSummary (
    customer_id INT,
    full_name NVARCHAR(150),
    total_orders INT,
    total_spendings DECIMAL(12,2)
) 

CREATE PROCEDURE dbo.UpdateCustomerSummary
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.CustomerSummary;

    INSERT INTO dbo.CustomerSummary (
        customer_id,
        full_name,
        total_orders,
        total_spendings
    )
    SELECT
        c.id,
        c.full_name,
        COUNT(o.id),
        SUM(o.total_amount)
    FROM dbo.customers c
    INNER JOIN dbo.orders o
        ON c.id = o.customer_id
    GROUP BY
        c.id,
        c.full_name;
END;
