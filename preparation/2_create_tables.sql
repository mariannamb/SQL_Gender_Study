CREATE TABLE public.household_data
(
    REG INT,
    HHID NUMERIC,
    RFACT NUMERIC,
    FSIZE INT,
    CHLD_6_11 INT,
    CHLD_12_15 INT,
    CHLD_5_17 INT,
    PER_18_UP INT,
    WRK_HEAD INT,
    WRK_18 INT,
    WRK_5_17 INT,
    EDUC_6_11 INT,
    EDUC_12_15 INT,
    HHMELEM_6_11 INT,
    HHMHS_12_15 INT,
    H04_SEX INT,
    H05_AGE INT,
    H06_STATUS INT,
    H08_CUR_ATTEND INT,
    H09_CUR_GRADE INT,
    H10_YNOT_ATTND INT,
    H12_HGC INT,
    H13_DID_WORK INT,
    H14_CLS_WKR INT,
    C16_FAMILL INT,
    C20_FAMFIN INT,
    URB INT
);

CREATE TABLE public.person_data
(
    REG INT,
    HHID NUMERIC,
    C01_LNO INT,
    C03_REM INT,
    C04_SEX INT,
    C05_AGE INT,
    C06_STATUS INT,
    C08_PRE_PRIM INT,
    C09_CUR_ATTEND INT,
    C10_CUR_GRADE INT,
    C11_YNOT_ATTND INT,
    C13_HGC INT,
    C14_DID_WORK INT,
    C15_CLS_WKR INT,
    C16_ILL INT,
    C17_ILL_WORK INT,
    C18_ILL_DAYS INT,
    C20_BANK_ACCT INT,
    C22_VOUCHER INT,
    C23_A INT,
    C23_B INT,
    C23_C INT,
    C23_D INT,
    MEM_RFACT NUMERIC
);

CREATE TABLE public.socialprotection_data
(
    REG INT,
    HHID NUMERIC,
    H3 INT,
    H4 INT,
    H6 INT,
    H8 INT,
    H5_A INT,
    H5_B INT,
    H5_C INT,
    H5_D INT,
    H5_E INT,
    H5_F INT,
    H7_A INT,
    H7_B INT,
    H7_C INT,
    H7_D INT,
    H7_E INT,
    H7_F INT,
    H9_A INT,
    H9_B INT,
    H9_C INT,
    H9_D INT,
    H9_E INT,
    H9_F INT,
    H9_G INT,
    H9_H INT,
    H9_I INT,
    H9_J INT,
    H9_K INT,
    H9_L INT,
    H9_M INT
);

ALTER TABLE public.household_data OWNER to postgres;
ALTER TABLE public.person_data OWNER to postgres;
ALTER TABLE public.socialprotection_data OWNER to postgres;
