create database learnbay;
 select * from Crop_prod_study; 

 ---Calculate Crop Yield

 SELECT 
    Crop,
    State_Name,
    Crop_Year,
    SUM(Production) / NULLIF(SUM(Area), 0) AS Crop_Yield
FROM Crop_prod_study
GROUP BY Crop, State_Name, Crop_Year
ORDER BY Crop_Yield DESC;

 ---Year-over-Year Percentage Growth in Crop Production

 SELECT 
    State_Name,
    Crop,
    crop_Year,
    Production,
    LAG(Production) OVER (PARTITION BY State_Name, Crop ORDER BY crop_Year) AS Previous_Year_Production,
    ((Production - LAG(Production) OVER (PARTITION BY State_Name, Crop ORDER BY crop_Year)) / 
        NULLIF(LAG(Production) OVER (PARTITION BY State_Name, Crop ORDER BY crop_Year), 0)) * 100 AS Year_Over_Year_Growth
FROM Crop_prod_study
ORDER BY State_Name, Crop, crop_Year;

---3. Average Yield by State and Top N States with Highest Average Yield--

SELECT 
    State_name,
    AVG(Production / NULLIF(Area, 0)) AS Average_Yield
FROM Crop_prod_study
GROUP BY State_name
ORDER BY Average_Yield DESC
top 10;

SELECT TOP 10
    State_Name,
    AVG(Production / NULLIF(Area, 0)) AS Average_Yield
FROM Crop_prod_study
GROUP BY State_Name
ORDER BY Average_Yield DESC;


---4. Variance in Production Across Different Crops and State--

SELECT 
    Crop,
    State_name,
    VAR(Production) AS Production_Variance
FROM Crop_prod_study
GROUP BY Crop, State_Name
ORDER BY Production_Variance DESC;

---5. States with the Largest Increase in Cultivated Area for a Specific Crop Between Two Years

SELECT 
    State_name,
    Crop,
    crop_Year,
    Area,
    (Area - LAG(Area) OVER (PARTITION BY State_name, Crop ORDER BY crop_Year)) AS Increase_in_Area
FROM Crop_prod_study
WHERE Crop = 'coconut'
ORDER BY Increase_in_Area DESC;
