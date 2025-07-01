-- HEROES
INSERT INTO Heroes VALUES 
(1, 'Iron Man', 'Tech Suit', 'Active'),
(2, 'Black Widow', 'Combat', 'Retired'),
(3, 'Captain America', 'Shield', 'Injured'),
(4, 'Spider-Man', 'Agility', 'Active'),
(5, 'Doctor Strange', 'Magic', 'Active');

-- VILLAINS
INSERT INTO Villains VALUES
(1, 'Thanos', 'Extreme'),
(2, 'Loki', 'High'),
(3, 'Ultron', 'High'),
(4, 'Vulture', 'Medium'),
(5, 'Red Skull', 'High');

-- MISSIONS
INSERT INTO Missions VALUES
(101, 'New York', 'Combat', 'Success'),
(102, 'Berlin', 'Recon', 'Failure'),
(103, 'Wakanda', 'Rescue', 'Success'),
(104, 'Space', 'Combat', 'Ongoing'),
(105, 'London', 'Combat', 'Failure');

-- HERO_MISSIONS
INSERT INTO Hero_Missions VALUES
(1, 101, 'Leader'),
(2, 101, 'Support'),
(3, 102, 'Leader'),
(4, 103, 'Support'),
(5, 104, 'Leader'),
(1, 104, 'Support');

-- MISSION_VILLAINS
INSERT INTO Mission_Villains VALUES
(101, 2),
(101, 3),
(102, 5),
(103, 4),
(104, 1),
(105, 3);
