--Entertainment Agency Database 
--(Hint: The solution requires a JOIN of two tables.)
--1. “Display agents and the engagement dates they booked, sorted by booking start date.” //key:agent ID
--You can find the solution in CH08_Agents_Booked_Dates (111 rows).
use EntertainmentAgencyExample;
select * from sys.tables;
select * from Agents;
select * from Customers;
select * from Engagements;
select * from Entertainer_Members;
select * from Entertainer_Styles;
select * from Entertainers;
select * from Members;
select * from Musical_Preferences;
select * from Musical_Styles;

select a.AgentID, a.AgtFirstName, a.AgtLastName, e.StartDate
from Agents as a
	join Engagements as e
	on a.AgentID = e.AgentID
	order by e.StartDate;

--2. “List customers and the entertainers they booked.” 
--(Hint: The solution requires a JOIN of more than two tables.)
--You can find the solution in CH08_Customers_Booked_Entertainers (75 rows).

select distinct c.CustFirstName, c.CustLastName, et.EntertainerID, et.EntStageName
from Customers as c
	join Engagements as e
	on c.CustomerID = e.CustomerID
	join Entertainers as et
	on et.entertainerID = e.EntertainerID;

--3. “Find the agents and entertainers who live in the same postal code.”
--(Hint: The solution requires a JOIN on matching values.)
--You can find the solution in CH08_Agents_Entertainers_Same_Postal (10 rows).

select a.AgentID, a.AgtFirstName, a.AgtLastName, a.AgtZipCode, et.EntZipCode
from  Agents as a
	join Entertainers as et
	on a.AgtZipCode = et.EntZipCode
	where a.AgtZipCode = et.EntZipCode;




--Recipes Database
--1. “List all the recipes for salads.”
--(Hint: The solution requires a JOIN of two tables.)
--You can find the solution in CH08_Salads (1 row).
use RecipesExample;
select * from sys.tables;
select * from Ingredient_Classes;
select * from Ingredients;
select * from Measurements;
select * from Recipe_Classes; 
select * from Recipe_Ingredients;
select * from Recipes;

select RecipeTitle, rc.RecipeClassDescription
from Recipes as r
	join Recipe_Classes as rc
	on rc.RecipeClassID = r.RecipeClassID
where rc.RecipeClassID = 4;


--2. “List all recipes that contain a dairy ingredient.”
--(Hint: The solution requires a JOIN of more than two tables.)
--You can find the solution in CH08_Recipes_Containing_Dairy (2 rows). 

select distinct r.RecipeTitle, ic.IngredientClassDescription
from Recipes as r
	 join Recipe_Ingredients as ri
	 on r.recipeID = ri.recipeID
	 join Ingredients as i
	 on ri.ingredientID = i.ingredientID 
	 join Ingredient_Classes as ic
	 on i.IngredientClassID = ic.IngredientClassID
	 where ic.IngredientClassID = 8;



--3. “Find the ingredients that use the same default measurement amount.”
--(Hint: The solution requires a JOIN on matching values.)
--You can find the solution in CH08_Ingredients_Same_Measure (628 rows).
select st_Ingredient.FirstIngredientName, st_Ingredient.MeasurementDescription, nd_Ingredient.SecondIngredientName
from 
	(select i.IngredientName as FirstIngredientName, m.MeasurementDescription
		from Ingredients as i 
			join Measurements as m
			on i.MeasureAmountID = m.MeasureAmountID) as st_Ingredient 
		JOIN
    (select i.IngredientName as SecondIngredientName, m.MeasurementDescription
		from Ingredients as i 
		join Measurements as m
		on i.MeasureAmountID = m.MeasureAmountID) as nd_Ingredient 
	on st_Ingredient.FirstIngredientName != nd_Ingredient.SecondIngredientName 
	AND st_Ingredient.MeasurementDescription = nd_Ingredient.MeasurementDescription;


--4. “Show me the recipes that have beef and garlic.”// ingredientID = 1 and 9
--(Hint: The solution requires a JOIN on matching values.)
--You can find the solution in CH08_Beef_And_Garlic_Recipes (1 row).

--NEED TO FIX (did not show 1 row)
--select r.RecipeTitle, i.IngredientName
--from Recipes as r
--	 join Recipe_Ingredients as ri
--	 on r.recipeID = ri.recipeID
--	 join Ingredients as i
--	 on ri.ingredientID = i.ingredientID 
--	 where ri.ingredientID = 1;

select beef.RecipeTitle
from  
	(select r.RecipeID, r.RecipeTitle 
		from (Recipes as r
			join Recipe_Ingredients as ri
			on r.RecipeID = ri.RecipeID) 
			join Ingredients as i
			on ri.IngredientID = i.IngredientID
		where i.ingredientID = 1) as beef
			JOIN 
	(select ri.RecipeID 
		from Recipe_Ingredients as ri
			join Ingredients as i
			on ri.IngredientID = i.IngredientID
		where i.ingredientID = 9) as garlic 
	on beef.RecipeID = garlic.RecipeID;