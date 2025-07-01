-- 1. Top deployed heroes (most missions)
SELECT h.name, COUNT(hm.mission_id) AS mission_count
FROM Heroes h
JOIN Hero_Missions hm ON h.hero_id = hm.hero_id
GROUP BY h.name
ORDER BY mission_count DESC;

-- 2. Missions that involved 'Extreme' threat villains
SELECT DISTINCT m.mission_id, m.location
FROM Missions m
JOIN Mission_Villains mv ON m.mission_id = mv.mission_id
JOIN Villains v ON mv.villain_id = v.villain_id
WHERE v.threat_level = 'Extreme';

-- 3. Number of heroes in each mission
SELECT m.mission_id, m.location, COUNT(hm.hero_id) AS total_heroes
FROM Missions m
JOIN Hero_Missions hm ON m.mission_id = hm.mission_id
GROUP BY m.mission_id, m.location;

-- 4. List of failed missions and the villains involved
SELECT m.location, v.name AS villain
FROM Missions m
JOIN Mission_Villains mv ON m.mission_id = mv.mission_id
JOIN Villains v ON mv.villain_id = v.villain_id
WHERE m.outcome = 'Failure';

-- 5. Active heroes and their missions
SELECT h.name AS hero, m.location, m.mission_type
FROM Heroes h
JOIN Hero_Missions hm ON h.hero_id = hm.hero_id
JOIN Missions m ON m.mission_id = hm.mission_id
WHERE h.status = 'Active';
