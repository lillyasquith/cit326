
--5.Create a view that combines (joins) data from two tables for dbo

CREATE VIEW customers_products AS

SELECT a.FirstName, a.MiddleInitial, a.LastName,c.ProductID, c.Name, c.Price
FROM dang_final_Project.user_schema1.Customers AS a
  JOIN dang_final_Project.user_schema2.Sales AS b
  ON a.CustomerID = b.CustomerID
  JOIN dang_final_Project.user_schema2.Products AS c
  ON b.ProductID = c.ProductID


--5.Create a view that combines (joins) data from two tables for user_schema1
SELECT a.FirstName, a.MiddleInitial, a.LastName, c.ProductID, c.Name, c.Price
FROM user_schema1.Customers AS a 
INNER JOIN user_schema2.Sales AS b 
ON a.CustomerID = b.CustomerID 
INNER JOIN user_schema2.Products AS c 
ON b.ProductID = c.ProductID

--6.	Create a new database level role.This role should include the following privileges:
	--a.	SELECT on the schema from step 4b.
	--b.	SELECT on the view from step 5b.
	--c.	SELECT on a table of your choice that is NOT inside the schema from 4b.
	--d.	Then, create a list of all the needed DCL (grant commands) from steps a through c and assign all of these privileges to this role. 
USE dang_final_Project
GO
CREATE ROLE [new_buddy_role]
GO
USE dang_final_Project
GRANT SELECT ON [user_schema1].[Customers] TO [new_buddy_role]
GO
USE dang_final_Project
GRANT SELECT ON [user_schema1].[Employees] TO [new_buddy_role]
GO
USE dang_final_Project
GRANT SELECT ON [user_schema1].[customers_products] TO [new_buddy_role]
GO
USE dang_final_Project
GRANT SELECT ON [user_schema2].[Products] TO [new_buddy_role]
GO

--Assigning them to role 'new_buddy_role'
ALTER ROLE [new_buddy_role] ADD MEMBER [final_running_buddy]