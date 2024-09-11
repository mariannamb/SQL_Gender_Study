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