WITH workclass_table AS (
    SELECT
        hhid,
        h04_sex,
        h14_cls_wkr,
        h06_status,
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
        h14_cls_wkr
)

SELECT
    h14_cls_wkr,
    age_group,
    COUNT(age_group)
FROM
    workclass_table
WHERE
    h04_sex = 1 AND
    h14_cls_wkr IS NOT NULL
GROUP BY
    age_group,
    h14_cls_wkr
ORDER BY
    age_group,
    h14_cls_wkr

SELECT
    h14_cls_wkr,
    h06_status,
    COUNT(h14_cls_wkr)
FROM
    household_data
WHERE
    h04_sex = 1 AND
    h14_cls_wkr IS NOT NULL
GROUP BY
    h14_cls_wkr,
    h06_status
ORDER BY
    h14_cls_wkr,
    h06_status;

SELECT
    h14_cls_wkr,
    h06_status,
    COUNT(h14_cls_wkr)
FROM
    household_data
WHERE
    h04_sex = 2 AND
    h14_cls_wkr IS NOT NULL
GROUP BY
    h14_cls_wkr,
    h06_status
ORDER BY
    h14_cls_wkr,
    h06_status;