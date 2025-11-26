INSERT OR IGNORE INTO users (name, email, gender, register_date, occupation_id)
VALUES
('Ферафонтов Алексей Вадимович', 'ferafontov@gmail.com', 'male', date('now'),
 (SELECT id FROM occupations ORDER BY id LIMIT 1)),
('Голиков Евгений Александрович', 'golikov@gmail.com', 'male', date('now'),
 (SELECT id FROM occupations ORDER BY id LIMIT 1)),
('Адеев Ильдар Альбертович', 'adeev@gmail.com', 'male', date('now'),
 (SELECT id FROM occupations ORDER BY id LIMIT 1)),
('Кечемайкин Дмитрий Максимович', 'kemaikin@gmail.com', 'male', date('now'),
 (SELECT id FROM occupations ORDER BY id LIMIT 1)),
('Розанов Ярослав Дмитриевич', 'rozanov@gmail.com', 'male', date('now'),
 (SELECT id FROM occupations ORDER BY id LIMIT 1));


INSERT OR IGNORE INTO movies (title, year)
VALUES
('Ирония судьбы, или С лёгким паром! (1975)', 1975),
('Москва слезам не верит (1979)', 1979),
('В бой идут одни старики (1973)', 1973);

INSERT OR IGNORE INTO genres (name) VALUES ('Romance');
INSERT OR IGNORE INTO genres (name) VALUES ('Drama');
INSERT OR IGNORE INTO genres (name) VALUES ('War');

INSERT OR IGNORE INTO movie_genres (movie_id, genre_id)
SELECT m.id, g.id FROM movies m JOIN genres g ON g.name = 'Romance'
WHERE m.title = 'Ирония судьбы, или С лёгким паром! (1975)';

INSERT OR IGNORE INTO movie_genres (movie_id, genre_id)
SELECT m.id, g.id FROM movies m JOIN genres g ON g.name = 'Drama'
WHERE m.title = 'Москва слезам не верит (1979)';

INSERT OR IGNORE INTO movie_genres (movie_id, genre_id)
SELECT m.id, g.id FROM movies m JOIN genres g ON g.name = 'War'
WHERE m.title = 'В бой идут одни старики (1973)';

INSERT INTO ratings (user_id, movie_id, rating, timestamp)
SELECT u.id, m.id, 5.0, strftime('%s','now')
FROM users u JOIN movies m ON m.title = 'Ирония судьбы, или С лёгким паром! (1975)'
WHERE u.email = 'zhivaev@gmail.com'
AND NOT EXISTS (
    SELECT 1 FROM ratings r WHERE r.user_id = u.id AND r.movie_id = m.id
);

INSERT INTO ratings (user_id, movie_id, rating, timestamp)
SELECT u.id, m.id, 4.9, strftime('%s','now')
FROM users u JOIN movies m ON m.title = 'Москва слезам не верит (1979)'
WHERE u.email = 'zhivaev@gmail.com'
AND NOT EXISTS (
    SELECT 1 FROM ratings r WHERE r.user_id = u.id AND r.movie_id = m.id
);

INSERT INTO ratings (user_id, movie_id, rating, timestamp)
SELECT u.id, m.id, 4.8, strftime('%s','now')
FROM users u JOIN movies m ON m.title = 'В бой идут одни старики (1973)'
WHERE u.email = 'zhivaev@gmail.com'
AND NOT EXISTS (
    SELECT 1 FROM ratings r WHERE r.user_id = u.id AND r.movie_id = m.id
);
