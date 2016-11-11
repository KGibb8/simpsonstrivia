
-- The number of script_lines any given character has for each episode
SELECT e.production_code, c.name, COUNT(sl.character_id) FROM episodes AS e
  FULL OUTER JOIN script_lines AS sl ON sl.episode_id = e.episode_id
  FULL OUTER JOIN characters AS c ON c.character_id = sl.character_id
  GROUP BY e.production_code, c.name;

SELECT sl.raw_text, sl.number FROM script_lines AS sl
  WHERE sl.episode_id = 32 ORDER BY sl.number ;

SELECT e.production_code, c.name, COUNT(sl.character_id) FROM episodes AS e
   FULL OUTER JOIN script_lines AS sl ON sl.episode_id = e.episode_id
   FULL OUTER JOIN characters AS c ON c.character_id = sl.character_id 
 WHERE LENGTH(e.production_code) < 7
 GROUP BY e.production_code, c.name HAVING COUNT(sl.character_id) > 0;

SELECT e.season, e.number_in_season, c.name, COUNT(sl.character_id) FROM episodes AS e
   FULL OUTER JOIN script_lines AS sl ON sl.episode_id = e.episode_id
   FULL OUTER JOIN characters AS c ON c.character_id = sl.character_id 
 GROUP BY e.season, e.number_in_season, c.name HAVING COUNT(sl.character_id) > 0;


SELECT c.name, COUNT(sl.character_id) 
  FROM episodes AS e
    FULL OUTER JOIN script_lines AS sl ON sl.episode_id = e.episode_id
    FULL OUTER JOIN characters AS c ON c.character_id = sl.character_id       
  GROUP BY c.name 
  HAVING COUNT(sl.character_id) > 0 ORDER BY 2 DESC;


SELECT l.name, c.name, COUNT(sl.character_id) FROM episodes AS e
   FULL OUTER JOIN script_lines AS sl ON sl.episode_id = e.episode_id
     FULL OUTER JOIN characters AS c ON c.character_id = sl.character_id LEFT OUTER JOIN locations AS l ON l.location_id = sl.location_id
      WHERE LENGTH(e.production_code) < 7
        GROUP BY l.name, c.name HAVING COUNT(sl.character_id) > 0;
