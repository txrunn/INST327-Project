USE inst327project;

-- Average salary for each job posting
CREATE VIEW posting_average_salary AS
SELECT 
    position.position_id, 
    title.name AS job_title,
    company_position_title.experience, 
    company_position_title.remote,
    (salary.salary_from + salary.salary_to) / 2 AS avg_salary,
    salary.currency
FROM company_position_title
JOIN title USING (title_id)
JOIN position USING (position_id)
LEFT JOIN salary USING (salary_id)
ORDER BY avg_salary DESC;
SELECT * FROM posting_average_salary;

-- Average salaries per company
CREATE VIEW company_average_salary AS
SELECT 
    company_id,
    (AVG(salary_from) + AVG(salary_to)) / 2 AS avg_comp_sal
FROM position
JOIN company USING (company_id)
JOIN salary USING (salary_id)
GROUP BY company_id
ORDER BY avg_comp_sal DESC;
SELECT * FROM company_average_salary;

-- Min, max, mean of salaries for Polish IT jobs
CREATE VIEW polish_min_max_mean AS
SELECT 
    MIN(salary_from) AS min_salary,
    MAX(salary_to) AS max_salary,
    (AVG(salary_from) + AVG(salary_to)) / 2 AS mean_salary,
    currency
FROM salary
WHERE currency = 'pln';
SELECT * FROM polish_min_max_mean;

-- Number of IT jobs per country
CREATE VIEW jobs_per_country AS
SELECT 
    location.country,
    COUNT(DISTINCT position.position_id) AS num_of_jobs
FROM company_location
JOIN position USING (company_id)
JOIN location USING (location_id)
GROUP BY location.country;
SELECT * FROM jobs_per_country;

-- Number of remote jobs
CREATE VIEW remote_jobs_number AS
SELECT 
    COUNT(remote) AS num_of_remote_jobs
FROM company_position_title
WHERE remote = 1;
SELECT * FROM remote_jobs_number;

-- Most valued/sought after coding languages/skills
CREATE VIEW valued_skills AS
SELECT 
    position.marker_icon,
    COUNT(position.marker_icon) AS count
FROM position
GROUP BY position.marker_icon
ORDER BY count DESC;  -- Modified to order by count to get the most valued skills on top
SELECT * FROM valued_skills;

-- Companies with average salaries above the overall average
CREATE VIEW companies_above_avg_salary AS
SELECT 
    company.company_id,
    (AVG(salary.salary_from) + AVG(salary.salary_to)) / 2 AS company_avg_salary
FROM company
JOIN position USING (company_id)
JOIN salary USING (salary_id)
GROUP BY company.company_id
HAVING company_avg_salary > (
    SELECT 
        (AVG(salary_from) + AVG(salary_to)) / 2 
    FROM salary
);
SELECT * FROM companies_above_avg_salary;
