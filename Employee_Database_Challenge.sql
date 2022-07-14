-- Use Dictinct with Orderby to remove duplicate rows
SELECT em.emp_no,
em.first_name,
em.last_name,
em.birth_date,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees AS em
INNER JOIN titles
	ON (em.emp_no = titles.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY (em.birth_date, em.emp_no) DESC;

-- Find unique titles that are retiring soon that are still with company filtered by date.
SELECT emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY (to_date) DESC;

-- Retrieving of number of titles retiring
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;
SELECT*FROM retiring_titles;

-- Looking for employees mature enough in their careers to mentor others

SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
ti.title,
de.from_date,
de.to_date
INTO mentorship
FROM employees AS e
INNER JOIN titles AS ti
 	ON (ti.emp_no = e.emp_no)
INNER JOIN dept_employees AS de
	ON (de.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY (e.emp_no);