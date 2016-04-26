----------------------------------------------------------------------------------------
-- Postgres create, load, and query script for hearthstone.
--
-- SQL statements for the hearthstone database
--
-- Author: Juan S. Vasquez
-- 
-- Tested on Postgres 9.5.0
----------------------------------------------------------------------------------------

-- Connect to your Postgres server and set the active database to hearthstone. Then . . .

--TABLES--

--Decklists--
CREATE TABLE decklists (
  slid 		CHAR(4) NOT NULL REFERENCES deckslots(slid),
  cid 		CHAR(4) NOT NULL REFERENCES cards(cid),
  isDupe 	BOOLEAN NOT NULL,
  PRIMARY KEY (slid, cid)
);

--Sample Decklist Data--
INSERT INTO decklists (slid, cid, isDupe)
  VALUES('sl00', 'c000', 't'),
	('sl00', 'c001', 't'),
	('sl00', 'c002', 't'),
	('sl00', 'c003', 't'),
	('sl00', 'c004', 't'),
	('sl00', 'c005', 't'),
	('sl00', 'c006', 't'),
	('sl00', 'c007', 't'),
	('sl00', 'c008', 't'),
	('sl00', 'c009', 't'),
	('sl00', 'c010', 'f'),
	('sl00', 'c011', 't'),
	('sl00', 'c012', 't'),
	('sl00', 'c013', 't'),
	('sl00', 'c014', 'f'),
	('sl00', 'c015', 't'),
	('sl01', 'c016', 't'),
	('sl01', 'c017', 't'),
	('sl01', 'c002', 't'),
	('sl01', 'c003', 't'),
	('sl01', 'c004', 't'),
	('sl01', 'c005', 't'),
	('sl01', 'c006', 't'),
	('sl01', 'c007', 't'),
	('sl01', 'c008', 't'),
	('sl01', 'c009', 't'),
	('sl01', 'c010', 'f'),
	('sl01', 'c011', 't'),
	('sl01', 'c012', 't'),
	('sl01', 'c013', 't'),
	('sl01', 'c014', 'f'),
	('sl01', 'c015', 't');

SELECT * FROM decklists;


--Deckslots--
CREATE TABLE deckslots (
  slid 		CHAR(4) NOT NULL,
  clid 		CHAR(4) NOT NULL REFERENCES classes(clid),
  cbid	 	CHAR(4) NOT NULL REFERENCES cardbacks(cbid),
  name		VARCHAR(25) NOT NULL,
  PRIMARY KEY (slid)
);
--Sample Deckslot Data--
INSERT INTO deckslots (slid, clid, cbid, name)
  VALUES('sl00', 'cl01', 'cb00', 'Sample Warrior Deck'),
	('sl01', 'cl08', 'cb01', 'Sample Mage Deck');

SELECT * FROM deckslots;


--Classes--
CREATE TABLE classes (
  clid		CHAR(4) NOT NULL,
  name 		VARCHAR(10)NOT NULL,
  PRIMARY KEY (clid)
);
--Sample Classes Data--
INSERT INTO classes (clid, name)
  VALUES('cl00', 'Neutral'),
	('cl01', 'Warrior'),
	('cl02', 'Shaman'),
	('cl03', 'Rogue'),
	('cl04', 'Paladin'),
	('cl05', 'Hunter'),
	('cl06', 'Druid'),
	('cl07', 'Warlock'),
	('cl08', 'Mage'),
	('cl09', 'Priest');

SELECT * FROM classes;


--Heroes--
CREATE TABLE heroes (
  hid		CHAR(4) NOT NULL,
  clid 		CHAR(4) NOT NULL REFERENCES classes(clid),
  name	 	VARCHAR(25) NOT NULL,
  description	TEXT NOT NULL,
  PRIMARY KEY (hid)
);
--Sample Heroes Data--
INSERT INTO heroes (hid, clid, name, description)
  VALUES('h000', 'cl01', 'Garrosh Hellscream', 'This former Warchief of the Horde isn''t bitter about being deposed. Not at all.'),
	('h001', 'cl02', 'Thrall', 'Thrall quit his former job as Warchief to save the world and spend more time with his family.'),
	('h002', 'cl03', 'Valeera Sanguinar', 'Expert Assassin. Deadly gladiator. Best knife skills in her cooking class, according to survivors.'),
	('h003', 'cl04', 'Uther Lightbringer', 'Leader of the Knights of the Silver Hand. Best-selling author of The Light and How to Swing It.'),
	('h004', 'cl05', 'Rexxar', 'He only feels at home in the wilderness with his beasts. Super secret: Misha is his favorite.'),
	('h005', 'cl06', 'Malfurion Stormrage', 'The lord of the night elves is a wise and noble leaser. Yes, those antlers are real.'),
	('h006', 'cl07', 'Gul''dan', 'Talented, persuasive and hard-working. Too bad he wants to feed your soul to demons.'),
	('h007', 'cl08', 'Jaina Proudmoore', 'The Kirin Tor''s leader is a powerful sorceress. She used to be a lot nicer before the Theramore thing.'),
	('h008', 'cl09', 'Anduin Wrynn', 'The future king of Stormwind is a kind, gentle soul. Except when he''s in Shadowform.'),
	('h009', 'cl01', 'Magni Bronzebeard', 'Lord of Ironforge. King of Khaz Modan. Grand Explorer. Moira''s Dad. Most Huggable Leader.'),
	('h010', 'cl08', 'Khadgar', 'His statue in Stormwind reflects his heroism, not his ego.');

SELECT * FROM heroes;


--Cardbacks--
CREATE TABLE cardbacks (
  cbid	 	CHAR(4) NOT NULL,
  name		VARCHAR(25) NOT NULL,
  description 	TEXT NOT NULL,
  PRIMARY KEY (cbid)
);
--Sample Cardbacks Data--
INSERT INTO cardbacks (cbid, name, description)
  VALUES('cb00', 'Classic', 'The only cardback you''ll ever need.'),
	('cb01', 'Heroic Naxxramas', 'Acquired from completing the Curse of Naxxramas in Heroic mode.'),
	('cb02', 'Hallow''s End', 'Acquired from achieving Rank 20 in Ranked Play, October 2014.'),
	('cb03', 'Magni', 'Acquired from purchasing the hero Magni Bronzebeard.'),
	('cb04', 'Eyes of C''thun', 'Acquired from pre-purchase of the Whispers of the Old Gods Card Packs.');

SELECT * FROM cardbacks;


--Cards--
CREATE TABLE cards (
  cid		CHAR(4) NOT NULL,
  name 		VARCHAR(25) NOT NULL,
  clid 		CHAR(4) NOT NULL REFERENCES classes(clid),
  effectText	TEXT NOT NULL,
  ssid		CHAR(4) NOT NULL REFERENCES standardSets(ssid),
  rid		CHAR(4) NOT NULL REFERENCES rarity(rid),
  manaCost	INT NOT NULL,
  numberOwned	INT NOT NULL,
  PRIMARY KEY (cid)
);
--Sample Cards Data--
INSERT INTO cards (cid, name, clid, effectText, ssid, rid, manaCost, numberOwned)
  VALUES('c000', 'Cruel Taskmaster', 'cl01', 'Battlecry: Deal 1 damage to a minion and give it +2 Attack.', 'ss01','r000','2','2'),
	('c001', 'Brawl', 'cl01', 'Destroy all minions except one (chosen randomly).', 'ss01','r002','5','2'),
	('c002', 'Argent Squire', 'cl00', 'Divine Shield', 'ss01','r000','1','2'),
	('c003', 'Goldshire Footman', 'cl00', 'Taunt', 'ss00','r000','1','2'),
	('c004', 'Hungry Crab', 'cl00', 'Battlecry: Destroy a Murloc and gain +2/+2.', 'ss01','r002','1','2'),
	('c005', 'Worgen Infiltrator', 'cl00', 'Stealth', 'ss01','r000','1','2'),
	('c006', 'Young Dragonhawk', 'cl00', 'Windfury', 'ss01','r000','1','2'),
	('c007', 'Annoy-o-Tron', 'cl00', 'Taunt, Divine Shield', 'ss03','r000','2','2'),
	('c008', 'Bluegill Warrior', 'cl00', 'Charge', 'ss00','r000','2','2'),
	('c009', 'Nerubian Egg', 'cl00', 'Deathrattle: Summon a 4/4 Nerubian.', 'ss02','r001','2','2'),
	('c010', 'Brann Bronzebeard', 'cl00', 'Your Battlecries trigger twice', 'ss06','r003','3','1'),
	('c011', 'Coldlight Seer', 'cl00', 'Battlecry: Give ALL other Murlocs +2 Health', 'ss01','r001','3','2'),
	('c012', 'Dancing Swords', 'cl00', 'Deathrattle: Your opponent draws a card.', 'ss02','r000','3','2'),
	('c013', 'Injured Blademaster', 'cl00', 'Battlecry: Deal 4 damage to HIMSELF.', 'ss01','r001','3','2'),
	('c014', 'Gormok the Impaler', 'cl00', 'Battlecry: If you have at least 4 other minions, deal 4 damage.', 'ss05','r003','4','1'),
	('c015', 'Hungry Dragon', 'cl00', 'Battlecry: Summon a random 1-Cost minion for your opponent.', 'ss04','r000','4','2'),
	('c016', 'Ice Block', 'cl08', 'Secret: When your hero takes fatal damage, prevent it and become immune this turn.', 'ss01','r002','3','2'),
	('c017', 'Flamewaker', 'cl08', 'After you cast a spell, deal 2 damage randomly split among all enemies.', 'ss04','r001','3','2'),
	('c018', 'Totemic Might', 'cl02', 'Give your Totems +2 Health.', 'ss00','r000','0','2'),
	('c019', 'Vitality Totem', 'cl02', 'At the end of your turn, restore 4 Health to your hero.', 'ss03','r001','2','2'),
	('c020', 'Preparation', 'cl03', 'The next spell you cast this turn costs (3) less.', 'ss01','r002','0','2'),
	('c021', 'Cogmaster'' Wrench', 'cl03', 'Has +2 Attack while you have a Mech.', 'ss03','r002','3','1'),
	('c022', 'Coghammer', 'cl04', 'Battlecry: Give random friendly minion Divine Shied and Taunt.', 'ss03','r002','3','1'),
	('c023', 'Redemption', 'cl04', 'Secret: When one of your minions dies, return it to life with 1 Health.', 'ss01','r000','1','2'),
	('c024', 'Gladiator''s Longbow', 'cl05', 'Your hero is Immune while attacking.', 'ss01','r002','7','1'),
	('c025', 'Tundra Rhino', 'cl05', 'Your Beasts have Charge.', 'ss00','r000','5','2'),
	('c026', 'Druid of the Fang', 'cl06', 'Battlecry: If you have a Beast, transform this minion into a 7/7.', 'ss03','r000','5','2'),
	('c027', 'Soul of the Forest', 'cl06', 'Give all your minions Deathrattle: Summon a 2/2 Treant.', 'ss01','r000','4','2'),
	('c028', 'Wrathguard', 'cl07', 'Whenever this minion takes damage, also deal that amount to your hero.', 'ss05','r000','2','2'),
	('c029', 'Demonwrath', 'cl07', 'Deal 2 damage 2 all non-Demon minions.', 'ss04','r001','3','2'),
	('c030', 'Northshire Cleric', 'cl09', 'Whenever a minion is healed, draw a card.', 'ss00','r000','1','2'),
	('c031', 'Lightbomb', 'cl09', 'Deal damage to each minion equal to its Attack.', 'ss03','r002','6','2');

SELECT * FROM cards;


--Minions--
CREATE TABLE minions (
  mid		CHAR(4) NOT NULL,
  cid 		CHAR(4) NOT NULL REFERENCES cards(cid),
  tid 		CHAR(4) NOT NULL REFERENCES tribes(tid),
  attack	INT NOT NULL,
  health	INT NOT NULL,
  PRIMARY KEY (mid)
);
--Sample Minions Data--
INSERT INTO minions (mid, cid, tid, attack, health)
  VALUES('m000', 'c000', 't000', '2', '2'),
	('m001', 'c002', 't000', '1', '1'),
	('m002', 'c003', 't000', '1', '2'),
	('m003', 'c004', 't001', '1', '2'),
	('m004', 'c005', 't000', '2', '1'),
	('m005', 'c006', 't001', '1', '1'),
	('m006', 'c007', 't002', '1', '2'),
	('m007', 'c008', 't003', '2', '1'),
	('m008', 'c009', 't000', '0', '4'),
	('m009', 'c010', 't000', '2', '4'),
	('m010', 'c011', 't003', '2', '3'),
	('m011', 'c012', 't000', '4', '4'),
	('m012', 'c013', 't000', '4', '7'),
	('m013', 'c014', 't000', '4', '4'),
	('m014', 'c015', 't004', '5', '6'),
	('m015', 'c017', 't000', '2', '4'),
	('m016', 'c019', 't005', '0', '3'),
	('m017', 'c025', 't001', '2', '5'),
	('m018', 'c026', 't000', '4', '4'),
	('m019', 'c028', 't006', '4', '3'),
	('m020', 'c030', 't000', '1', '3');

SELECT * FROM minions;

  
--Tribes--
CREATE TABLE tribes (
  tid 		CHAR(4) NOT NULL,
  tribeName	VARCHAR(10) NOT NULL,
  PRIMARY KEY (tid)
);
--Sample Tribes Data--
INSERT INTO tribes (tid, tribeName)
  VALUES('t000', 'None'),
	('t001', 'Beast'),
	('t002', 'Mech'),
	('t003', 'Murloc'),
	('t004', 'Dragon'),
	('t005', 'Totem'),
	('t006', 'Demon');

SELECT * FROM tribes;


--Spells--
CREATE TABLE spells (
  sid	 	CHAR(4) NOT NULL,
  cid 		CHAR(4) NOT NULL REFERENCES cards(cid),
  PRIMARY KEY (sid)
);
--Sample Spells Data--
INSERT INTO spells (sid, cid)
  VALUES('s000', 'c001'),
	('s001', 'c016'),
	('s002', 'c018'),
	('s003', 'c020'),
	('s004', 'c023'),
	('s005', 'c027'),
	('s006', 'c029'),
	('s007', 'c031');

SELECT * FROM spells;


--Weapons--
CREATE TABLE weapons (
  wid	 	CHAR(4) NOT NULL,
  cid 		CHAR(4) NOT NULL REFERENCES cards(cid),
  attack	INT NOT NULL,
  durability	INT NOT NULL,
  PRIMARY KEY (wid)
);
--Sample Weapons Data--
INSERT INTO weapons (wid, cid, attack, durability)
  VALUES('w000', 'c021', '1', '3'),
	('w001', 'c022', '2', '3'),
	('w002', 'c024', '5', '2');

SELECT * FROM weapons;


--Rarity--
CREATE TABLE rarity (
  rid	 	CHAR(4) NOT NULL,
  rarityName	VARCHAR(10) NOT NULL,
  PRIMARY KEY (rid)
);
--Sample Rarity Data--
INSERT INTO rarity (rid, rarityName)
  VALUES('r000', 'Common'),
	('r001', 'Rare'),
	('r002', 'Epic'),
	('r003', 'Legendary');

SELECT * FROM rarity;


--StandardSets--
CREATE TABLE standardSets (
  ssid	 	CHAR(4) NOT NULL,
  setName	VARCHAR(25) NOT NULL,
  PRIMARY KEY (ssid)
);
--Sample StandardSets Data--
INSERT INTO standardSets (ssid, setName)
  VALUES('ss00', 'Basic'),
	('ss01', 'Classic'),
	('ss02', 'Curse of Naxxramas'),
	('ss03', 'Goblins vs Gnomes'),
	('ss04', 'Blackrock Mountain'),
	('ss05', 'The Grand Tournament'),
	('ss06', 'The League of Explorers');

SELECT * FROM standardSets ORDER BY ssid;

--KCEntity--
CREATE TABLE kcEntity (
  cid 		CHAR(4) NOT NULL REFERENCES cards(cid),
  kid 		CHAR(4) NOT NULL REFERENCES keywords(kid),
  PRIMARY KEY (cid, kid)
);
--Sample KCEntity Data--
INSERT INTO kcEntity (cid, kid)
  VALUES('c000', 'k000'),
	('c002', 'k001'),
	('c003', 'k002'),
	('c004', 'k000'),
	('c005', 'k003'),
	('c006', 'k004'),
	('c007', 'k011'),
	('c008', 'k005'),
	('c009', 'k012'),
	('c011', 'k000'),
	('c012', 'k006'),
	('c013', 'k000'),
	('c014', 'k000'),
	('c015', 'k013'),
	('c016', 'k008'),
	('c022', 'k014'),
	('c023', 'k008'),
	('c024', 'k009'),
	('c025', 'k005'),
	('c026', 'k000'),
	('c027', 'k012');
	
SELECT * FROM kcEntity;

  
--Keywords--
CREATE TABLE keywords (
  kid	 	CHAR(4) NOT NULL,
  name		VARCHAR(50) NOT NULL,
  description 	TEXT NOT NULL,
  PRIMARY KEY (kid)
);
--Sample Keywords Data--
INSERT INTO keywords (kid, name, description)
  VALUES('k000', 'Battlecry', 'Triggers an action when the minion is played from your hand.'),
	('k001', 'Divine Shield', 'Absorbs the first source of damage taken by the minion, removing the shield.'),
	('k002', 'Taunt', 'Enemies must attack minions this minion before any non-Taunt characters. This includes minions and hero melee weapon attacks.'),
	('k003', 'Stealth', 'Minions with Stealth may not be the target of attacks, spells or abilities until they attack or deal damage. Once they attack or deal damage, Stealth is removed.'),
	('k004', 'Windfury', 'Can attack twice each turn.'),
	('k005', 'Charge', 'Enables the minion to attack on the same turn that it is summoned.'),
	('k006', 'Deathrattle', 'An ability that is triggered when the minion dies.'),
	('k007', 'Summon', 'Summons the specified minion/s onto the board.'),
	('k008', 'Secret', 'This spells''s effect remains hidden until its trigger condition occurs, revealing its effect. Can only be activated during the opponent''s turn.'),
	('k009', 'Immune', 'Immune is an ability that prevents damage dealt from any source to the target, and prevents all enemy interaction with the target.'),
	('k010', 'Transform', 'Changes a minion into something else irreversibly, entirely replacing the previous card.'),
	('k011', 'Taunt/Divine Shield', 'A combination of Taunt and Divine Shield on the same minion.'),
	('k012', 'Deathrattle/Summon', 'When this card dies, summon the specified minion.'),
	('k013', 'Battlecry/Summon', 'When this card is played, summon the specified minion.'),
	('k014', 'Battlecry/Divine Shield/Taunt', 'When this card is played, give a minion a combination of Taunt and Divine Shield.'),
	('k015', 'Battlecry/Transform', 'When this card is played, change a minion into something else irreversibly');

SELECT * FROM keywords;


--ALL SELECT STATEMENTS FOR EASE OF USE BELOW--

SELECT * FROM decklists;
SELECT * FROM deckslots;
SELECT * FROM classes;
SELECT * FROM heroes;
SELECT * FROM cardbacks;
SELECT * FROM cards;
SELECT * FROM minions;
SELECT * FROM tribes;
SELECT * FROM spells;
SELECT * FROM weapons;
SELECT * FROM rarity;
SELECT * FROM standardSets;
SELECT * FROM kcEntity;
SELECT * FROM keywords;

--VIEWS--

CREATE VIEW RarityInSets AS
  SELECT name AS CardName, setName, rarityName
  FROM cards
  INNER JOIN standardSets
  ON cards.ssid = standardSets.ssid
  INNER JOIN rarity
  ON cards.rid = rarity.rid
  ORDER BY setName, rarityName; 

CREATE VIEW KeywordsInEffectText AS
  SELECT c.name AS CardName, c.effectText AS CardText, k.name AS Keywords
  FROM cards c, kcEntity kc, keywords k
  WHERE kc.cid = c.cid AND kc.kid = k.kid
  ORDER BY k.name, c.name;
  
--REPORTS--

SELECT TRUNC(
  CAST((
	SELECT COUNT(c.cid) AS MinionCount
	FROM cards c
	INNER JOIN minions m
	ON c.cid = m.cid
        ) AS DECIMAL(5,2)
       )/(
	SELECT COUNT(c.cid) AS AllCards
	FROM cards c
          )*100
) AS MinionPercentage

SELECT 
TRUNC(CAST((
	SELECT COUNT(c.cid) AS BasicCount FROM cards c
	INNER JOIN standardSets s ON c.ssid = s.ssid
	WHERE setName = 'Basic'
        ) AS DECIMAL(5,2)
       )/(SELECT COUNT(c.cid) AS AllCards FROM cards c)*100
) AS BasicPercentage,
  TRUNC(CAST((
	SELECT COUNT(c.cid) AS ClassicCount FROM cards c
	INNER JOIN standardSets s ON c.ssid = s.ssid
	WHERE setName = 'Classic'
        ) AS DECIMAL(5,2)
       )/(SELECT COUNT(c.cid) AS AllCards FROM cards c)*100
) AS ClassicPercentage,
  TRUNC(CAST((
	SELECT COUNT(c.cid) AS GVGCount FROM cards c
	INNER JOIN standardSets s ON c.ssid = s.ssid
	WHERE setName = 'Goblins vs Gnomes'
        ) AS DECIMAL(5,2)
       )/(SELECT COUNT(c.cid) AS AllCards FROM cards c)*100
) AS GVGPercentage,
  TRUNC(CAST((
	SELECT COUNT(c.cid) AS BRMCount FROM cards c
	INNER JOIN standardSets s ON c.ssid = s.ssid
	WHERE setName = 'Blackrock Mountain'
        ) AS DECIMAL(5,2)
       )/(SELECT COUNT(c.cid) AS AllCards FROM cards c)*100
) AS BRMPercentage,
  TRUNC(CAST((
	SELECT COUNT(c.cid) AS TGTCount FROM cards c
	INNER JOIN standardSets s ON c.ssid = s.ssid
	WHERE setName = 'The Grand Tournament'
        ) AS DECIMAL(5,2)
       )/(SELECT COUNT(c.cid) AS AllCards FROM cards c)*100
) AS TGTPercentage,
  TRUNC(CAST((
	SELECT COUNT(c.cid) AS LOECount FROM cards c
	INNER JOIN standardSets s ON c.ssid = s.ssid
	WHERE setName = 'The League of Explorers'
        ) AS DECIMAL(5,2)
       )/(SELECT COUNT(c.cid) AS AllCards FROM cards c)*100
) AS LOEPercentage

--SECURITY--
CREATE ROLE dev;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC
TO dev;

CREATE ROLE player;
GRANT SELECT ON ALL TABLES 
IN SCHEMA PUBLIC
TO player;
GRANT INSERT, UPDATE ON deckslots, decklists
TO player;
