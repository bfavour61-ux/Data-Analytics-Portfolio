SELECT * FROM table1

SELECT * FROM table2

-- 1. Join Patient_Info and Lesion_Info into a single dataset
SELECT *
FROM table1 T1
JOIN table2 T2 ON T1.patient_id = T2.patient_id;

-- 2. Identify the age group with the highest melanoma (MEL) cases
SELECT 
    CASE 
        WHEN T1.age < 20 THEN '0-19'
        WHEN T1.age BETWEEN 20 AND 39 THEN '20-39'
        WHEN T1.age BETWEEN 40 AND 59 THEN '40-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS melanoma_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'MEL'
GROUP BY age_group
ORDER BY melanoma_cases DESC
LIMIT 1;

--3. Find the relationship between smoking and skin lesion type
SELECT T1.smoke, T2.diagnostic, COUNT(*) AS cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY T1.smoke, T2.diagnostic
ORDER BY cases DESC;

--4. Analyze pesticide exposure and malignant lesions (MEL, BCC)
SELECT T1.pesticide, T2.diagnostic, COUNT(*) AS cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic IN ('MEL','BCC')
GROUP BY T1.pesticide, T2.diagnostic
ORDER BY cases DESC;

-- 5. Calculate the average lesion diameter by diagnosis
SELECT T2.diagnostic,
       ROUND(AVG((T2.diameter_1 + T2.diameter_2)/2),2) AS avg_diameter
FROM Table2 T2
GROUP BY T2.diagnostic
ORDER BY avg_diameter DESC;

-- 6. Find the most common body region where lesions occur
SELECT T2.region, COUNT(*) AS lesion_count
FROM Table2 T2
GROUP BY T2.region
ORDER BY lesion_count DESC
LIMIT 1;

-- 7. Check how many lesions grew, changed, or bled by diagnosis
SELECT T2.diagnostic,
       SUM(CASE WHEN T2.grew = TRUE THEN 1 ELSE 0 END) AS grew_cases,
       SUM(CASE WHEN T2.changed = TRUE THEN 1 ELSE 0 END) AS changed_cases,
       SUM(CASE WHEN T2.bleed = TRUE THEN 1 ELSE 0 END) AS bleed_cases
FROM Table2 T2
GROUP BY T2.diagnostic
ORDER BY grew_cases DESC;

-- 8. Compare melanoma cases among patients with and without family cancer history
SELECT T1.cancer_history, COUNT(*) AS melanoma_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'MEL'
GROUP BY T1.cancer_history;

-- 9. Examine paternal ethnicity and lesion type distribution
SELECT T1.background_father, T2.diagnostic, COUNT(*) AS cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY T1.background_father, T2.diagnostic
ORDER BY cases DESC;

-- 10. Identify biopsy-confirmed lesions and their diagnosis
SELECT T2.diagnostic, COUNT(*) AS biopsy_count
FROM Table2 T2
WHERE T2.biopsed = TRUE
GROUP BY T2.diagnostic
ORDER BY biopsy_count DESC;

-- 11. Compare gender differences in skin cancer diagnoses
SELECT T1.gender, T2.diagnostic, COUNT(*) AS cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY T1.gender, T2.diagnostic
ORDER BY cases DESC;

-- 11. Compare gender differences in skin cancer diagnoses
SELECT T1.gender, T2.diagnostic, COUNT(*) AS cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY T1.gender, T2.diagnostic
ORDER BY cases DESC;

-- 12. Investigate effect of water and sanitation access on lesion cases
SELECT 
    T1.has_piped_water,
    T1.has_sewage_system,
    COUNT(T2.lesion_id) AS lesion_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY T1.has_piped_water, T1.has_sewage_system
ORDER BY lesion_cases DESC;

-- 13. Compare new lesion cases between patients with and without past skin cancer history
SELECT T1.skin_cancer_history, T2.diagnostic, COUNT(*) AS cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY T1.skin_cancer_history, T2.diagnostic
ORDER BY cases DESC;

-- 14. Assess Fitzpatrick skin type risk across lesion types
SELECT T2.fitspatrick, T2.diagnostic, COUNT(*) AS cases
FROM Table2 T2
GROUP BY T2.fitspatrick, T2.diagnostic
ORDER BY cases DESC;

-- 15. Identify which Fitzpatrick skin type has the most melanoma cases
SELECT T2.fitspatrick, COUNT(*) AS melanoma_cases
FROM Table2 T2
WHERE T2.diagnostic = 'MEL'
GROUP BY T2.fitspatrick
ORDER BY melanoma_cases DESC
LIMIT 1;

--- Conclusion & Recommendations
---This SQL analysis demonstrates how structured data can reveal meaningful patterns in skin cancer risk and diagnosis:
--Older age, family cancer history, smoking, and pesticide exposure are key risk factors.
--Lesion symptoms (growth, bleeding, color change) are strong malignant indicators.
--Fitzpatrick skin type plays an important role in melanoma susceptibility.
--Environmental conditions (water/sanitation) and ethnicity may influence overall risk.

---Recommendations:
--Use these structured results to build predictive machine learning models for early detection.
--Share insights with healthcare practitioners to guide targeted screening and prevention campaigns.
--Expand dataset collection to strengthen epidemiological research.


