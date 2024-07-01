CREATE VIEW office.order_retail_vs_quoted
AS
SELECT Order_Details.OrderNumber, dbo.Products.Productname, dbo.Products.RetailPrice, Order_Details.QuotedPrice
FROM office.Order_Details
JOIN dbo.Products
ON office.Order_Details.ProductNumber = dbo.Products.ProductNumber;