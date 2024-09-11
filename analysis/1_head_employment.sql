SELECT
    MIN(h05_age),
    MAX(h05_age)
FROM
    household_data;

SELECT
    hhid,
    h04_sex,
    h06_status,
    h13_did_work,
    h05_age,
    CASE
        WHEN h05_age <=17 THEN '13 to 17'
        WHEN h05_age <=29 THEN '18 to 29'
        WHEN h05_age <=39 THEN '30 to 39'
        WHEN h05_age <=49 THEN '40 to 49'
        WHEN h05_age <=59 THEN '50 to 59'
        WHEN h05_age <=69 THEN '60 to 69'
        WHEN h05_age <=79 THEN '70 to 79'
        WHEN h05_age <=89 THEN '80 to 89'
        ELSE '90 to 99'
    END AS age_group
FROM
    household_data
ORDER BY
    h04_sex,
    h06_status;