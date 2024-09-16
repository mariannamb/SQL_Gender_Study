# 👋🏼 Introduction
**How does gender influence the roles and responsibilities of household heads and members in the Philippines?**
In what ways does gender shape family dynamics within households?
To what extent do gender roles impact access to education, employment opportunities, and financial literacy?

These questions popped into my head after reading *‘Invisible Women: Exposing Data Bias in a World Designed for Men’* by Caroline Criado Perez. The book discussed **the gender data gap,** and highlighted multiple examples of gender bias mainly in Europe and America. As a Filipino, I wondered how similar or different things were for my country. 🤔

I worked with a public dataset available on the website of the Philippine Statistics Authority: Annual Poverty Indicators Survey 2019.* I figured that analyzing this sex-disaggregated data would help me uncover valuable insights into families in the Philippines and the presence and impact of gender roles. Using SQL and Tableau, I analyzed relationships between certain variables and visualized my results. 📊

This is the second part of my project. The first part was shared on Tableau Public and can be viewed [here](https://public.tableau.com/views/GenderRolesinthePhilippines2019/HeadofHousehold1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

**I decided to use the 2019 dataset as this was the latest one available on the website that was the most complete. I hope to keep updating this project as new data becomes available.*

# 🗂️ Background
The Annual Poverty Indicators Survey by the PSA is a survey which gathers data on the socio-economic profile of families in the Philippines. You can check out the dataset I used [here](https://psada.psa.gov.ph/catalog/246/study-description).

Specifically, I used the files Household, Person Record, and Social Protection (PhilHealth, Child Protection, Disasters Preparedness Kit). These files contain demographic and economic characteristics of the family head and family members, and information on social protection programs.

Additionally, the data came with a dictionary which defined the variables used per file. You can check it out [here](apis_2019_metadata_dictionary.xlsx). 

This project is limited to the data available in the given dataset and files used, and does not include any other data taken from elsewhere.

# 🧰 Tools I Used
For this project, I used these key tools:
- SQL: This allowed me to query the database and retrieve the essential data I needed to gain insights.
- PostgreSQL: This was the most ideal database management system for me to use.
- Visual Studio Code: This made executing SQL queries more convenient and efficient.
- Tableau: This allowed me to create simple yet effective visuals that captured the results of my code.
- Git & Github: These allowed me to share my SQL scripts and analysis, and made sure versions were kept up to date.

# 📉 The Analysis
## 1. Employment Status of Head

I wanted to know the distribution of employed and unemployed male and female heads across (1) age group, and (2) civil status.

```sql
WITH employment_table AS (
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
        h06_status
)

SELECT
    age_group,
    h13_did_work,
    COUNT(age_group)
FROM
    employment_table
WHERE
    h04_sex = 1
GROUP BY
    age_group,
    h13_did_work
ORDER BY
    age_group,
    h13_did_work;
```

*I ran the code above twice, changing the WHERE clause from 1 to 2, to see male vs female data. I did this for all future code blocks as well.*

These were the results:
![Age Group vs Employment of Head](images/agegrp_v_employmenthead.png)
A greater percentage of male heads are employed compared to female heads, particularly those of ages 30 to 59. For female heads, the more employed ages are 40 to 69.

```sql
SELECT
    h06_status,
    h13_did_work,
    COUNT(h13_did_work)
FROM
    household_data
WHERE
    h04_sex = 2
GROUP BY
    h13_did_work,
    h06_status
ORDER BY
    h06_status;
```
![Civil Status vs Employment of Head](images/civstat_v_employmenthead.png)

While 88.01% of male married heads are employed, only 62.21% of married female heads are employed. It's also something to note that widowed female heads are quite evenly distributed, with 49.67% employed and 50.33% unemployed.

## 2. Work Class of Head

The next relationship I wanted to explore was the work class of heads and their age group and civil status.

```sql
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
```
![Age Group vs Work Class of Head](images/agegrp_v_workclshead.png)
For both sexes, majority worked for private establishments or were self-employed without any employee. It's interesting that female heads aged 50 to 69 are most commonly self-employed without any employee.

```sql
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
```
![Civil Status vs Work Class of Head](images/civstat_v_workclshead.png)
As we saw previously, most heads worked for private establishments or were self-employed without any employee. For males, they are mostly married/living together. For female heads, most that are self-employed are widowed.

## 3. Highest Grade Completed by Head

I wanted to find out if the highest grade completed by the head affected their employment status and work class.
Because there are multiple levels of highest grades completed, the CTA I created was quite lengthy. I won't embed the code here, but you can check out the full code [in this link](analysis/3_head_hgc.sql).

![HGC vs. Employment Status of Head Table](images/hgc_v_employmenthead.png)
![HGC vs. Employment Treemap Male](images/hgc_v_employ_treemap_m.png)
![HGC vs. Employment Treemap Female](images/hgc_v_employ_treemap_f.png)
I made use of treemaps to clearly visualize employed heads (green) vs. unemployed (grey). As we can see, the distribution of male heads leans more heavily towards employed, as compared to female heads where it's more evenly spread.

Most employed male heads were Junior High Graduates or Undergraduates, or completed Grades 1 to 6/7. Employed female heads were also commonly Junior High Graduates, but 1,039 of them actually completed Bachelor Level Education.

![HGC vs. Work Class of Head Male](images/hgc_v_workclshead_m.png)
![HGC vs. Work Class of Head Female](images/hgc_v_workclshead_f.png)
Earlier, we saw that most employed male heads completed JHS or Grades 1 to 6/7. The table shows us that majority of them also work for private establishments or are self-employed without any employee.

For employed female heads, those that were JHS Graduates were mostly self-employed without any employee, but the Bachelor Level Education Graduates most commonly worked for government.

## 4. Schooling Status of Household Member
Now I wanted to take a deeper look at all household members not currently attending school. Their reason for not attending school could be related to their highest grade completed. Again, the CTA I created was lengthy so you can check out the full code [here](analysis/4_hhmember_school.sql).

![HGC vs. Reason Not Attending Male](images/hgc_v_reason_m.png)
![HGC vs. Reason Not Attending Female](images/hgc_v_reason_f.png)
Clearly, those who are too young to go to school have not completed any grade yet. I wanted to focus more on the top reasons of each sex for not attending school, so I visualized this in a bubbles graph:

![Top Reasons for Not Attending](images/top_not_attending_school.png)
I figured out that a large amount of females mentioned marriage/family matters as their reason for not attending school, while for males it was employment.

This made me wonder, for each sex's top 5 reasons for not attending school, what was the members' relationship to the family head?
![Relationship to Head vs. Reason Not Attending](images/reltohead_v_reason.png)
Most of the male household members not attending school were sons of the family head. They were most likely employed, too young, or not interested. Meanwhile, for the females that mentioned marriage/family matters as their reason, they were the spouse of the family head, or daughter/daughter-in-law.

## 5. Financial Status of Household Member
Lastly, I wanted to look at the financial account of household members, and if having an account related to having a job/work.
```sql
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
```
![Bank Account vs. Work Status of Members](images/bank_v_reltohead_v_work.png)
Despite majority of male members having work, a large number of them do not own a bank account. For females, most that own a bank account are the spouse or daughter of the head. However, this is still outnumbered by those who do not have a bank account. I wanted to know more about why most do not own a bank account, but unfortunately this study is limited by the data available, and there was no data on reasons for not owning one.

# 💡 Valuable Takeaways
- 💼 Among **female heads** of households, those who were **married or living with a partner** had an employment rate of 62.21%, while 37.79% were unemployed. For **widowed** female heads, 49.67% were employed and 50.33% were unemployed.

- 📘 The top three educational levels completed by **employed male heads** were:

    1. Junior High School (JHS) Graduate
    2. Grades 1–6/7
    3. JHS Undergraduate

- 📕 The top three educational levels completed by **employed female heads** were:

    1. Junior High School (JHS) Graduate
    2. Bachelor’s Degree Graduate
    3. Grades 1–6/7

- 🖌️ The top five reasons **male household members** cited for not attending school were:

    1. Employment
    2. Too young to attend school
    3. Lack of personal interest
    4. High cost of education/financial concerns
    5. Finished schooling or post-secondary or college

    - Of the 2,860 members who cited **employment** as their reason for not attending school, **2,075 were sons** of the family head.

- 🖍️ The top five reasons **female household members** cited for not attending school were:

    1. Marriage or family matters
    2. Too young to attend school
    3. Employment
    4. Finished schooling or post-secondary or college
    5. Lack of personal interest

    - Of the 2,182 members who cited **marriage or family matters** as their reason for not attending school, **840 were spouses** of the family head, **671 were daughters**, and **468 were daughters-in-law**.

- 💰 A significant number of **employed male heads of households** (19,321 or 45.56%) reported having **no bank or financial account,** despite having had work in the past six months.

# ✅ Conclusions

Based on my analysis of the PSA APIS 2019 dataset, I have identified the following assumptions regarding gender roles in the Philippines:

1. **Men are heavily influenced or pressured to be the main providers for their households.**
    - 76.5% of all surveyed households were headed by males.
    - 88.61% of male heads were married or living with a partner, and 88.01% of these male heads were employed. This suggests that, in married households, men are typically the primary earners.
    - Additionally, 2,860 male household members cited employment as their reason for not attending school, indicating a prioritization of work and income over completing school.
   
2. **Women are more likely to take on the role of homemakers or primary caretakers.**
    - Only 23.5% of surveyed households were headed by females, and 42.08% of these female heads were unemployed.
    - While 30.01% of female heads were married or living with a partner, 50.9% were widowed. This indicates that men typically head households in married couples, and women often assume the role only after their spouse passes away.
    - Furthermore, 2,182 female household members listed marriage or family matters as their reason for not attending school. Of these, 840 were spouses of the household head, and 1,139 were daughters or daughters-in-law, highlighting the prioritization of family duties over education for many women.

3. **There is a need to promote financial literacy for both men and women.**
    - 53.52% of male heads and 45.85% of female heads did not have a bank account or other financial account.
    - Among 86,532 male household members, only 10,968 of those who had work owned a bank or financial account, while 31,443 employed male members did not.
    - Similarly, among 84,521 female household members, only 11,613 working women had a bank or financial account, while 16,114 did not.
    - These findings reveal a significant gap in financial literacy and access, potentially driven by factors such as limited access to financial education, inadequate wages, or economic challenges that lead to living paycheck to paycheck.

---

These conclusions suggest that cultural norms in the Philippines continue to shape the roles of men and women within households, and addressing gaps in education and financial literacy could help promote more balanced opportunities for both genders.


## 📝 Closing Thoughts
Working on this project made me realize that the Philippines still has a long way to go when it comes to gender equality. Both men and women are victims of societal pressures which lead to inequalities in family, education, and employment. It is also evident that they lack opportunities to become more aware of these gaps and take steps to closing them.

However, the data used for this project was from 2019 (which was 5 years ago), so hopefully things have started to improve since then. I hope the most recent data will become publicly available soon so further studies can be done on the progress of the country, particularly in gender equality. ⚖️