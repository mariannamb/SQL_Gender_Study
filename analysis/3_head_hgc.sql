WITH hgc_table AS (
    SELECT
        hhid,
        h04_sex,
        h13_did_work,
        h14_cls_wkr,
        CASE
            WHEN h12_hgc = 0 THEN 'No Grade Completed'
            WHEN h12_hgc <= 2000 THEN 'Pre-School (Nursery/Kinder/Prep)'
            WHEN h12_hgc = 10002 THEN 'Level 1 - IPED, Madrasah, SPED'
            WHEN h12_hgc = 10003 THEN 'Level 1 - ALS'
            WHEN h12_hgc <= 10017 THEN 'Grade 1 to Grade 6/7'
            WHEN h12_hgc = 10018 THEN 'Elementary Graduate'
            WHEN h12_hgc = 24002 THEN 'Level 2 - IPED, Madrasah, SPED'
            WHEN h12_hgc = 24003 THEN 'Level 2 - ALS'
            WHEN h12_hgc <= 24014 THEN 'JHS Undergraduate'
            WHEN h12_hgc = 24015 THEN 'JHS Graduate'
            WHEN h12_hgc <= 34012 THEN 'SHS Academic Track Undergrad'
            WHEN h12_hgc = 34013 THEN 'SHS Academic Track Graduate'
            WHEN h12_hgc <= 34032 THEN 'SHS Sport Track Undergrad'
            WHEN h12_hgc = 34033 THEN 'SHS Sport Track Graduate'
            WHEN h12_hgc <= 34022 THEN 'SHS Art and Design Track Undergrad'
            WHEN h12_hgc = 34023 THEN 'SHS Art and Design Graduate'
            WHEN h12_hgc <= 35012 THEN 'SHS Technical and Livelihood Track Undergrad'
            WHEN h12_hgc = 35013 THEN 'SHS Technical and Livelihood Track Graduate'
            WHEN h12_hgc <= 40003 THEN 'Post Secondary/Non Tertiary Education Undergrad'
            WHEN h12_hgc <= 49999 THEN 'Post Secondary/Non Tertiary Education Graduate'
            WHEN h12_hgc <= 50003 THEN 'Short Cycle Tertiary Education Undergrad'
            WHEN h12_hgc <= 59999 THEN 'Short Cycle Tertiary Education Graduate'
            WHEN h12_hgc = 60000 THEN 'Graduate 60000'
            WHEN h12_hgc <= 60006 THEN 'Bachelor Level Education Undergrad'
            WHEN h12_hgc <= 69999 THEN 'Bachelor Level Education Graduate'
            WHEN h12_hgc = 70000 THEN 'Graduate 70000'
            WHEN h12_hgc = 70010 THEN 'Master Level Education Undergrad'
            WHEN h12_hgc <= 79999 THEN 'Master Level Education Graduate'
            WHEN h12_hgc = 80010 THEN 'Doctoral Level Education Undergrad'
            WHEN h12_hgc <= 89999 THEN 'Doctoral Level Education Graduate'
            ELSE 'NA'
        END AS HGC
    FROM
        household_data
    ORDER BY
        h04_sex
)

/**
SELECT
    hgc,
    h13_did_work,
    COUNT(h13_did_work)
FROM
    hgc_table
WHERE
    h04_sex = 1
GROUP BY
    hgc,
    h13_did_work
ORDER BY
    hgc,
    h13_did_work
**/

SELECT
    hgc,
    h14_cls_wkr,
    COUNT(h14_cls_wkr)
FROM
    hgc_table
WHERE
    h04_sex = 2
    AND h14_cls_wkr IS NOT NULL
GROUP BY
    hgc,
    h14_cls_wkr
ORDER BY
    hgc,
    h14_cls_wkr