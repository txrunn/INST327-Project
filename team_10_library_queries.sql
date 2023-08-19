USE inst327project;

/* average salary for each job posting */
CREATE VIEW posting_average_salary AS
SELECT position.position_id, name, experience, remote, (salary_from + salary_to) / 2 AS 'avg_salary', currency
FROM company_position_title
	JOIN title USING (title_id)
	JOIN position USING (position_id)
	LEFT JOIN salary USING (salary_id)
ORDER BY avg_salary DESC;
SELECT * FROM posting_average_salary;


/* average salaries per company */
CREATE VIEW company_average_salary AS
SELECT company_id, (AVG(salary_from) + AVG(salary_to)) / 2 AS 'avg_comp_sal'
FROM position
    JOIN company USING (company_id)
    JOIN salary USING (salary_id)
GROUP BY company_id
ORDER BY avg_comp_sal DESC;
SELECT * FROM company_average_salary;


/* min, max, mean of salaries for polish it jobs */
CREATE VIEW polish_min_max_mean AS
SELECT 
	MIN(salary_from) AS 'min_salary',
    MAX(salary_to) AS 'max_salary',
    (AVG(salary_from) + AVG(salary_to)) / 2 AS 'mean_salary', currency
FROM salary
WHERE currency = 'pln';
SELECT * FROM polish_min_max_mean;


/* number of IT jobs per country from the database*/
CREATE VIEW jobs_per_country AS
SELECT country, COUNT(DISTINCT position_id) AS 'num_of_jobs'
FROM company_location
	JOIN position USING (company_id)
    JOIN location USING (location_id)
GROUP BY country;
SELECT * FROM jobs_per_country;


/*number of remote jobs */
CREATE VIEW remote_jobs_number AS
SELECT COUNT(remote) AS 'num_of_remote_jobs'
FROM company_position_title
WHERE remote = 1;
SELECT * FROM remote_jobs_number;


/* most valued/sought after coding languages/skills */
CREATE VIEW valued_skills AS
SELECT marker_icon, COUNT(marker_icon) AS 'count'
FROM position
GROUP BY marker_icon
ORDER BY marker_icon;
SELECT * FROM valued_skills;