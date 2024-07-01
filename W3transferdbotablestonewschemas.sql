
select 'alter schema bowling_new1 transfer ' +name+ ';' from sys.tables;

alter schema bowling_new1 transfer Bowler_Scores;
alter schema bowling_new1 transfer Bowlers;
alter schema bowling_new1 transfer Match_Games;

select 'alter schema bowling_new2 transfer ' + name + ';' from sys.tables;
alter schema bowling_new2 transfer Tournaments;
alter schema bowling_new2 transfer Tourney_Matches;
alter schema bowling_new2 transfer ztblBowlerRatings;
alter schema bowling_new2 transfer ztblSkipLabels;
alter schema bowling_new2 transfer ztblWeeks;

use RecipesExample;
select 'alter schema new_recipes1 transfer ' + name + ';' from sys.tables;
alter schema new_recipes1 transfer Ingredient_Classes;
alter schema new_recipes1 transfer Ingredients;
alter schema new_recipes1 transfer Measurements;

select 'alter schema new_recipes2 transfer ' + name + ';' from sys.tables;
alter schema new_recipes2 transfer Recipe_Classes;
alter schema new_recipes2 transfer Recipe_Ingredients;
alter schema new_recipes2 transfer Recipes;