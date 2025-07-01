-- 1. INNER JOIN: Heroes and their mission locations and outcomes
SELECT h.name AS hero, m.location, m.outcome
FROM Heroes h
JOIN Hero_Missions hm ON h.hero_id = hm.hero_id
JOIN Missions m ON m.mission_id = hm.mission_id;

-- 2. LEFT JOIN: All heroes including those not assigned to any mission
SELECT h.name AS hero, m.location
FROM Heroes h
LEFT JOIN Hero_Missions hm ON h.hero_id = hm.hero_id
LEFT JOIN Missions m ON m.mission_id = hm.mission_id;

-- 3. RIGHT JOIN: All missions including those without heroes (only in some DBs)
-- MySQL doesn't support RIGHT JOIN in all tools. This is for Postgres/Oracle.
SELECT m.location, h.name AS hero
FROM Missions m
RIGHT JOIN Hero_Missions hm ON m.mission_id = hm.mission_id
RIGHT JOIN Heroes h ON h.hero_id = hm.hero_id;

-- 4. FULL OUTER JOIN (MySQL workaround using UNION)
SELECT h.name, m.location
FROM Heroes h
LEFT JOIN Hero_Missions hm ON h.hero_id = hm.hero_id
LEFT JOIN Missions m ON m.mission_id = hm.mission_id

UNION

SELECT h.name, m.location
FROM Missions m
LEFT JOIN Hero_Missions hm ON m.mission_id = hm.mission_id
LEFT JOIN Heroes h ON hm.hero_id = h.hero_id;

-- 5. Window Function: Total mission count per hero
SELECT h.name,
       COUNT(hm.mission_id) OVER (PARTITION BY h.name) AS total_missions
FROM Heroes h
JOIN Hero_Missions hm ON h.hero_id = hm.hero_id;

-- 6. CTE + Aggregation: Number of villains per mission
WITH VillainCounts AS (
  SELECT mission_id, COUNT(villain_id) AS villain_count
  FROM Mission_Villains
  GROUP BY mission_id
)
SELECT m.location, v.villain_count
FROM Missions m
JOIN VillainCounts v ON m.mission_id = v.mission_id;

-- 7. CASE Statement: Assigning risk levels based on number of villains
SELECT m.location,
  CASE
    WHEN COUNT(v.villain_id) >= 2 THEN 'High Risk'
    WHEN COUNT(v.villain_id) = 1 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS risk_level
FROM Missions m
LEFT JOIN Mission_Villains mv ON m.mission_id = mv.mission_id
GROUP BY m.location;

-- 8. Nested Query: Heroes who participated ONLY in successful missions
SELECT name FROM Heroes
WHERE hero_id IN (
  SELECT hm.hero_id
  FROM Hero_Missions hm
  JOIN Missions m ON m.mission_id = hm.mission_id
  GROUP BY hm.hero_id
  HAVING SUM(m.outcome = 'Failure') = 0
);
