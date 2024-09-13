WITH hgc_mem_table AS (
    SELECT
        hhid,
        c04_sex,
        c03_rem,
        c06_status,
        c09_cur_attend,
        c11_ynot_attnd,
        CASE
            WHEN c13_hgc = 0 THEN 'No Grade Completed'
            WHEN c13_hgc <= 2000 THEN 'Pre-School (Nursery/Kinder/Prep)'
            WHEN c13_hgc = 10002 THEN 'Level 1 - IPED, Madrasah, SPED'
            WHEN c13_hgc = 10003 THEN 'Level 1 - ALS'
            WHEN c13_hgc <= 10017 THEN 'Grade 1 to Grade 6/7'
            WHEN c13_hgc = 10018 THEN 'Elementary Graduate'
            WHEN c13_hgc = 24002 THEN 'Level 2 - IPED, Madrasah, SPED'
            WHEN c13_hgc = 24003 THEN 'Level 2 - ALS'
            WHEN c13_hgc <= 24014 THEN 'JHS Undergraduate'
            WHEN c13_hgc = 24015 THEN 'JHS Graduate'
            WHEN c13_hgc <= 34012 THEN 'SHS Academic Track Undergrad'
            WHEN c13_hgc = 34013 THEN 'SHS Academic Track Graduate'
            WHEN c13_hgc <= 34032 THEN 'SHS Sport Track Undergrad'
            WHEN c13_hgc = 34033 THEN 'SHS Sport Track Graduate'
            WHEN c13_hgc <= 34022 THEN 'SHS Art and Design Track Undergrad'
            WHEN c13_hgc = 34023 THEN 'SHS Art and Design Graduate'
            WHEN c13_hgc <= 35012 THEN 'SHS Technical and Livelihood Track Undergrad'
            WHEN c13_hgc = 35013 THEN 'SHS Technical and Livelihood Track Graduate'
            WHEN c13_hgc <= 40003 THEN 'Post Secondary/Non Tertiary Education Undergrad'
            WHEN c13_hgc <= 49999 THEN 'Post Secondary/Non Tertiary Education Graduate'
            WHEN c13_hgc <= 50003 THEN 'Short Cycle Tertiary Education Undergrad'
            WHEN c13_hgc <= 59999 THEN 'Short Cycle Tertiary Education Graduate'
            WHEN c13_hgc = 60000 THEN 'Graduate 60000'
            WHEN c13_hgc <= 60006 THEN 'Bachelor Level Education Undergrad'
            WHEN c13_hgc <= 69999 THEN 'Bachelor Level Education Graduate'
            WHEN c13_hgc = 70000 THEN 'Graduate 70000'
            WHEN c13_hgc = 70010 THEN 'Master Level Education Undergrad'
            WHEN c13_hgc <= 79999 THEN 'Master Level Education Graduate'
            WHEN c13_hgc = 80010 THEN 'Doctoral Level Education Undergrad'
            WHEN c13_hgc <= 89999 THEN 'Doctoral Level Education Graduate'
            ELSE 'NA'
        END AS HGC
    FROM
        person_data
    ORDER BY
        c04_sex
)

/**
SELECT
    hgc,
    c11_ynot_attnd,
    COUNT(c11_ynot_attnd)
FROM
    hgc_mem_table
WHERE
    c04_sex = 1 AND
    c09_cur_attend > 3 AND
    c11_ynot_attnd IS NOT NULL
GROUP BY
    hgc,
    c11_ynot_attnd
ORDER BY
    hgc,
    c11_ynot_attnd
**/

SELECT
    c03_rem,
    c11_ynot_attnd,
    COUNT(c11_ynot_attnd)
FROM
    hgc_mem_table
WHERE
    c04_sex = 2 AND
    c11_ynot_attnd IS NOT NULL
GROUP BY
    c03_rem,
    c11_ynot_attnd
ORDER BY
    c03_rem,
    c11_ynot_attnd