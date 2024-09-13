SELECT
    hhid,
    c04_sex,
    c03_rem,
    c06_status,
    c20_bank_acct,
    c14_did_work,
    c15_cls_wkr
FROM person_data
ORDER BY
    c04_sex,
    c20_bank_acct;

SELECT
    c20_bank_acct,
    c03_rem,
    c14_did_work,
    COUNT(c20_bank_acct)
FROM
    person_data
WHERE
    c04_sex = 1
GROUP BY
    c20_bank_acct,
    c03_rem,
    c14_did_work
ORDER BY
    c20_bank_acct,
    c03_rem,
    c14_did_work;

SELECT
    c20_bank_acct,
    c03_rem,
    c14_did_work,
    COUNT(c20_bank_acct)
FROM
    person_data
WHERE
    c04_sex = 2
GROUP BY
    c20_bank_acct,
    c03_rem,
    c14_did_work
ORDER BY
    c20_bank_acct,
    c03_rem,
    c14_did_work;