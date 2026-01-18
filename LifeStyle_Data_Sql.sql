/*
Column Description	
	
Column Name	Description
Age        	Age of the participant (in years).
Gender	 	Biological gender (Male/Female).
Weight (kg)		Weight of the individual in kilograms.
Height (m)		Height of the individual in meters.
Max_BPM	Maximum		 heart rate recorded during a workout session.
Avg_BPM	Average		 heart rate maintained during the session.
Resting_BPM	Resting		 heart rate before starting the workout.
Session_Duration (hours)			Duration of the workout session in hours.
Calories_Burned			Total calories burned during the session.
Workout_Type			Type of workout performed (e.g., Strength, HIIT, Cardio).
Fat_Percentage			Body fat percentage of the individual.
Water_Intake (liters)			Average daily water consumption in liters.
Workout_Frequency (days/week)			Number of workout days per week.
Experience_Level			Fitness experience level (1=Beginner, 2=Intermediate, 3=Advanced).
BMI							Body Mass Index, a measure of body fat based on height and weight.
Daily meals frequency				Number of meals consumed daily.
Physical exercise				Indicates the type or frequency of physical activity.
Carbs				Daily carbohydrate intake (grams).
Proteins				Daily protein intake (grams).
Fats				Daily fat intake (grams).
Calories				Total daily calorie intake from food.
meal_name			Name of the meal (e.g., Breakfast, Lunch, Dinner).
meal_type			Type of meal (e.g., Snack, Main, Beverage).
diet_type			Type of diet followed (e.g., Keto, Vegan, Balanced).
sugar_g					Sugar content in grams per meal.
sodium_mg					Sodium content in milligrams per meal.
cholesterol_mg					Cholesterol content in milligrams per meal.
serving_size_g				Portion size of the meal in grams.
cooking_method				Cooking method used (e.g., Boiled, Fried, Grilled).
prep_time_min				Preparation time in minutes.
cook_time_min					Cooking time in minutes.
rating					Meal or workout rating (typically 1–5 scale).
is_healthy					Boolean indicator (True/False) of whether the meal/workout is healthy.
Name of Exercise					Name of the exercise performed.
Sets							Number of sets completed in the exercise.
Reps							Number of repetitions per set.
Benefit									Description of the exercise’s physical benefit.
Burns Calories (per 30 min)									Estimated calories burned in 30 minutes of that exercise.
Target Muscle Group										Main muscle group targeted by the exercise.
Equipment Needed					Equipment required to perform the exercise.
Difficulty Level							Exercise difficulty level (Beginner, Intermediate, Advanced).
Body Part								Primary body part involved (e.g., Arms, Legs, Chest).
Type of Muscle							Type of muscle engaged (e.g., Upper, Core, Grip Strength).
Workout						Specific workout or exercise name.

*/

/*
🔹 LEVEL 1 — Core SQL Fundamentals (Must-Know)
1. Count the total number of participants in the dataset.
2. Count the number of unique genders, workout types, diet types, and exercise names.
3. Identify the minimum and maximum age of participants.
4. Find participants where BMI is NULL or zero.
5. Count the total number of workout sessions by workout type.
6. List all unique cooking methods used in meal preparation.
7. Count participants by experience level (Beginner, Intermediate, Advanced).
8. Calculate the overall average daily calorie intake.
9. Identify meals where calorie intake is NULL or zero.
10. Count the number of meals per meal type (Breakfast, Lunch, Dinner, Snack).

🔹 LEVEL 2 — Business-Driven Aggregations
11. Calculate average BMI by gender.
12. Compare average calories burned per session across workout types.
13. Compute average session duration by experience level.
14. Identify which diet type has the highest average sugar intake.
15. Compare average carbs, proteins, and fats intake across diet types.
16. Compare average resting BPM vs average workout BPM.
17. Identify which meal type has the highest average calorie intake.
18. Compare calorie intake vs calories burned by experience level.
19. Identify cooking methods associated with the highest average calories.
20. Calculate the percentage of meals marked as healthy (is_healthy = TRUE).

🔹 LEVEL 3 — Health Risk & Behavioral Analysis (INTERVIEW FAVORITE)
21. Identify participants with above-average calorie intake but below-average calories burned.
22. Find age groups with the highest average body fat percentage.
23. Analyze the relationship between workout frequency and BMI.
24. Identify meal types with high sodium intake but low average ratings.
 25. Compare calories burned between beginner and advanced users.
26 Identify diet types associated with the lowest average BMI.
 27 Identify exercises that burn the most calories per 30 minutes.
 28. Identify which target muscle groups are trained most frequently.


🔹 LEVEL 4 — Real-World Product, Policy & Risk Scenarios (Senior Analyst Level)
29 If a fitness app could target only one group, which records show high BMI, low workout frequency, and poor diet quality?
30 Identify age groups requiring the most lifestyle intervention.
31 Identify exercises that should be promoted for maximum calorie burn per unit time.


*/









SELECT * FROM lifestyle_data.final_data;


# 1. Count the total number of participants in the dataset.
select count(*) as Total_Number_of_Participants
 FROM lifestyle_data.final_data;

# 2. Count the number of unique genders, workout types, diet types, and exercise names.
select count(DIstinct Gender) as  unique_genders,
count(DIstinct Workout_Type) as  unique_Workout,
count(DIstinct diet_type) as  unique_genders,
count(DIstinct `Name of Exercise`) as  `unique_Exercise`
 FROM lifestyle_data.final_data;


# 3. Identify the minimum and maximum age of participants.
select Min(age) as Min_Age, MAX(age) as MAX_Age
from lifestyle_data.final_data
WHERE age IS NOT NULL;
;

# 4. Find participants where BMI is NULL or zero.
Select COUNT(*) AS invalid_bmi_records
from lifestyle_data.final_data
where BMI is Null or BMI=0 ;

# 5. Count the total number of workout sessions by workout type.
select Workout_Type, count(*) as total_workout_sessions
from lifestyle_data.final_data
WHERE Workout_Type IS NOT NULL
group by Workout_Type;

# 6. List all unique cooking methods used in meal preparation.
select distinct cooking_method
from lifestyle_data.final_data
WHERE cooking_method IS NOT NULL
ORDER BY cooking_method;

# 7. Count participants by experience level (Beginner, Intermediate, Advanced).
select 
 case when Experience_Level = 1 THEN 'Beginner'
        WHEN Experience_Level = 2 THEN 'Intermediate'
        WHEN Experience_Level = 3 THEN 'Advanced'
        ELSE 'Invalid'
end as Experience, count(*) as total_participations
from lifestyle_data.final_data
where Experience_Level in (1,2,3)
group by Experience
order by total_participations desc;


# 8. Calculate the overall average daily calorie intake.
select round(avg(Calories),2) as average_Calories_intake
from lifestyle_data.final_data
WHERE Calories IS NOT NULL AND Calories > 0;


# 9. Identify meals where calorie intake is NULL or zero.
SELECT 
    meal_name,
    COUNT(*) AS invalid_calorie_records
FROM lifestyle_data.final_data
WHERE Calories IS NULL OR Calories = 0
GROUP BY meal_name
ORDER BY invalid_calorie_records DESC;

# 10. Count the number of meals per meal type (Breakfast, Lunch, Dinner, Snack).
select meal_type, count(*) as number_of_meals
FROM lifestyle_data.final_data
where  meal_type is not null
GROUP BY meal_type
order by number_of_meals desc;

# 11. Calculate average BMI by gender.
select Gender,round(avg(BMI),2) as avg_BMI
from lifestyle_data.final_data
where BMI is not null and BMI>0
GROUP BY Gender
order by avg_BMI;

# 12. Compare average calories burned per session across workout types.
select Workout_Type ,round(avg(Calories_Burned),2) as avg_calories_burned
from lifestyle_data.final_data
where Calories_Burned is not null and Calories_Burned>0
GROUP BY Workout_Type
order by avg_calories_burned desc;


# 13. Compute average session duration by experience level.
select CASE
    WHEN Experience_Level >= 1 AND Experience_Level < 2 THEN 'Beginner'
    WHEN Experience_Level >= 2 AND Experience_Level < 3 THEN 'Intermediate'
    WHEN Experience_Level >= 3 THEN 'Advanced'
    ELSE 'Invalid'
END AS Experience_Group,round(avg(`Session_Duration (hours)`),2) as avg_Session_Duration
from lifestyle_data.final_data
where `Session_Duration (hours)` is not null and `Session_Duration (hours)`>0
GROUP BY Experience_Group
order by avg_Session_Duration desc;

# 14. Identify which diet type has the highest average sugar intake.
select diet_type, round(avg(sugar_g),2) as average_sugar_g
from lifestyle_data.final_data
where sugar_g is not null and sugar_g>0
GROUP BY diet_type
order by average_sugar_g desc;

# 15. Compare average carbs, proteins, and fats intake across diet types.
SELECT 
    diet_type, 
    ROUND(AVG(NULLIF(Carbs, 0)), 2) AS average_carbs,
    ROUND(AVG(NULLIF(Proteins, 0)), 2) AS average_proteins,
    ROUND(AVG(NULLIF(Fats, 0)), 2) AS average_fats
FROM lifestyle_data.final_data
WHERE diet_type IS NOT NULL
GROUP BY diet_type
ORDER BY diet_type;

# 16. Compare average resting BPM vs average workout BPM.
select round(avg(Resting_BPM),2) as "average resting BPM",
round(avg(Avg_BPM),2) as "average workout BPM"
FROM lifestyle_data.final_data
where Resting_BPM is not null and Resting_BPM>0 and Avg_BPM is not null and Avg_BPM>0;

# 17. Identify which meal type has the highest average calorie intake.
select meal_type,round(avg(Calories),2) as average_calorie_intake
FROM lifestyle_data.final_data
where Calories is not null and Calories>0 
group by meal_type
order by average_calorie_intake desc;

# 18. Compare calorie intake vs calories burned by experience level.
select CASE
    WHEN Experience_Level >= 1 AND Experience_Level < 2 THEN 'Beginner'
    WHEN Experience_Level >= 2 AND Experience_Level < 3 THEN 'Intermediate'
    WHEN Experience_Level >= 3 THEN 'Advanced'
    ELSE 'Invalid'
END AS Experience_Group,round(avg(Calories),2) as avg_Calories_intake,
round(avg(Calories_Burned),2) as avg_Calories_Burned
from lifestyle_data.final_data
where Calories is not null and Calories>0
and Calories_Burned is not null and Calories_Burned>0
GROUP BY Experience_Group;

# 19. Identify cooking methods associated with the highest average calories.
select cooking_method,round(avg(Calories),2) as highest_average_calories
from lifestyle_data.final_data
where Calories is not null and Calories>0
GROUP BY cooking_method
order by highest_average_calories desc
limit 1;

# 20. Calculate the percentage of meals marked as healthy (is_healthy = TRUE).
SELECT
    ROUND(
        SUM(
            CASE 
                WHEN Calories <= 2200
                 AND sugar_g <= 25
                 AND sodium_mg <= 600
                 AND cholesterol_mg <= 300
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(*),
    2
    ) AS pct_healthy_meals
FROM lifestyle_data.final_data
WHERE Calories IS NOT NULL
  AND sugar_g IS NOT NULL
  AND sodium_mg IS NOT NULL
  AND cholesterol_mg IS NOT NULL;


# 21. Identify participants with above-average calorie intake but below-average calories burned.
WITH averages AS (
    SELECT 
        AVG(Calories) AS avg_calories_intake,
        AVG(Calories_Burned) AS avg_calories_burned
    FROM lifestyle_data.final_data
    WHERE Calories IS NOT NULL AND Calories > 0
      AND Calories_Burned IS NOT NULL AND Calories_Burned > 0
)
SELECT 
    f.*
FROM lifestyle_data.final_data f, averages a
WHERE f.Calories > a.avg_calories_intake
  AND f.Calories_Burned < a.avg_calories_burned;



# 22. Find age groups with the highest average body fat percentage.
select 
case 
WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 23 THEN '18-23'
    WHEN Age BETWEEN 24 AND 29 THEN '24-29'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 36 AND 41 THEN '36-41'
    WHEN Age BETWEEN 42 AND 47 THEN '42-47'
    WHEN Age BETWEEN 48 AND 53 THEN '48-53'
    WHEN Age >= 54 THEN '54+'
else 'Invalid'
end as Age_Group,
round(avg(Fat_Percentage),2) as Average_Fat_Percentage
from lifestyle_data.final_data
where Fat_Percentage>0 and Fat_Percentage is not null and Age>0 and Age is not null and Age BETWEEN 18 AND 100
# and Age_Group <> 'Invalid'
Group By Age_Group
HAVING Age_Group <> 'Invalid'
order by Average_Fat_Percentage desc;




# 23. Analyze the relationship between workout frequency and BMI.
select 
round(
sum((`Workout_Frequency (days/week)`-(select avg(`Workout_Frequency (days/week)`) from lifestyle_data.final_data))*
(BMI-(select avg(BMI) from lifestyle_data.final_data)))/
(sqrt(sum(pow(`Workout_Frequency (days/week)`-(select avg(`Workout_Frequency (days/week)`) from lifestyle_data.final_data),2)))
*sqrt(sum(pow(BMI-(select avg(BMI) from lifestyle_data.final_data),2))))
,4)
as "correlation between workout frequency and BMI"
from lifestyle_data.final_data
where `Workout_Frequency (days/week)`>0 and `Workout_Frequency (days/week)` is not null
and BMI>0 and BMI is not null;
 

# 24. Identify meal types with high sodium intake but low average ratings.
with cte as 
(select avg(sodium_mg) as avg_sodium_mg,avg(rating) as avg_rating 
from lifestyle_data.final_data
where sodium_mg>0 and sodium_mg is not null and rating>0 and rating is not null
),
cte2 as (
select meal_type ,avg(sodium_mg) as sodium_intake,avg(rating) as low_rating 
from lifestyle_data.final_data  
where sodium_mg>0 and sodium_mg is not null and rating>0 and rating is not null
group by meal_type)
select meal_type ,round(sodium_intake,2) as avg_sodium_mg, round(low_rating,2)  as avg_rating
from cte2 cross join cte
where cte2.sodium_intake>cte.avg_sodium_mg and cte2.low_rating<cte.avg_rating
order by avg_sodium_mg desc;

# 25. Compare calories burned between beginner and advanced users.
select CASE
    WHEN Experience_Level < 2 THEN 'Beginner'
    WHEN Experience_Level >= 2 AND Experience_Level < 3 THEN 'Intermediate'
    WHEN Experience_Level >= 3 THEN 'Advanced'
    ELSE 'Invalid'
END AS Experience_Group,
round(avg(Calories_Burned),2) as avg_Calories_Burned
from lifestyle_data.final_data
where Calories_Burned is not null and Calories_Burned>0
GROUP BY Experience_Group
having Experience_Group in ("Advanced","Beginner");
 
# 26 Identify diet types associated with the lowest average BMI.
select diet_type,round(avg(BMI),2) as avg_BMI
from lifestyle_data.final_data
where BMI>0 and BMI is not null and diet_type is not null
group by diet_type
order by avg_BMI asc limit 1;

# 27 Identify exercises that burn the most calories per 30 minutes.
select `Name of Exercise` as Exercise, round(avg(`Burns Calories (per 30 min)`),2) as `calories burned per 30 minutes`
from lifestyle_data.final_data
where `Burns Calories (per 30 min)`>0 and `Burns Calories (per 30 min)` is not null and `Name of Exercise` is not null
group by  `Name of Exercise`
order by `calories burned per 30 minutes` desc limit 1;


# 28. Identify which target muscle groups are trained most frequently.
select `Target Muscle Group`,count(*) as most_trained_body_parts
from lifestyle_data.final_data
WHERE `Target Muscle Group` IS NOT NULL
group by `Target Muscle Group`
order by most_trained_body_parts desc ;


/* 29 If a fitness app could target only one group, which records show high BMI, 
 low workout frequency, and poor diet quality? */ 
WITH benchmarks AS (
    SELECT 
        AVG(BMI) AS avg_bmi,
        AVG(`Workout_Frequency (days/week)`) AS avg_workout_freq,
        AVG(rating) AS avg_rating
    FROM lifestyle_data.final_data
    WHERE BMI IS NOT NULL AND BMI > 0
      AND `Workout_Frequency (days/week)` IS NOT NULL AND `Workout_Frequency (days/week)` > 0
      AND rating IS NOT NULL AND rating > 0
)
SELECT 
    COUNT(*) AS priority_intervention_records
FROM lifestyle_data.final_data d
CROSS JOIN benchmarks b
WHERE d.BMI > b.avg_bmi
  AND d.`Workout_Frequency (days/week)` < b.avg_workout_freq
  AND d.rating < b.avg_rating;



# 30 Identify age groups requiring the most lifestyle intervention.
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 23 THEN '18-23'
        WHEN Age BETWEEN 24 AND 29 THEN '24-29'
        WHEN Age BETWEEN 30 AND 35 THEN '30-35'
        WHEN Age BETWEEN 36 AND 41 THEN '36-41'
        WHEN Age BETWEEN 42 AND 47 THEN '42-47'
        WHEN Age BETWEEN 48 AND 53 THEN '48-53'
        WHEN Age >= 54 THEN '54+'
        else 'Invalid'
    END AS age_group,
    ROUND(AVG(BMI), 2) AS avg_bmi,
    ROUND(AVG(Fat_Percentage), 2) AS avg_fat_percentage,
    ROUND(AVG(`Workout_Frequency (days/week)`), 2) AS avg_workout_frequency
FROM lifestyle_data.final_data
WHERE Age IS NOT NULL AND Age >= 18
  AND BMI IS NOT NULL AND BMI > 0
  AND Fat_Percentage IS NOT NULL AND Fat_Percentage > 0
  AND `Workout_Frequency (days/week)` IS NOT NULL AND `Workout_Frequency (days/week)` > 0
GROUP BY age_group
having age_group <> 'Invalid'
ORDER BY avg_bmi DESC, avg_fat_percentage DESC;


# 31 Identify exercises that should be promoted for maximum calorie burn per unit time.
SELECT 
    `Name of Exercise` AS exercise,
    ROUND(AVG(`Burns Calories (per 30 min)`), 2) AS avg_calories_burned_30min
FROM lifestyle_data.final_data
WHERE `Burns Calories (per 30 min)` IS NOT NULL
  AND `Burns Calories (per 30 min)` > 0
  AND `Name of Exercise` IS NOT NULL
GROUP BY `Name of Exercise`
ORDER BY avg_calories_burned_30min DESC
LIMIT 5;




















