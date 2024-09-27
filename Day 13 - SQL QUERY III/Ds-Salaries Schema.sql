SELECT *
FROM DS_Salaries
WHERE salary_in_usd > (
 SELECT AVG(salary_in_usd)
 FROM DS_Salaries
)
AND company_size = 'S';