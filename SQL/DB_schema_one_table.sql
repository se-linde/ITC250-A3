
*/

# Mandatory for our one main table, sp16_rssfeed. 
# Haven't been able to run into MySQL, as I can't log in. 

SET foreign_key_checks = 0; #turn off constraints temporarily

#since constraints cause problems, drop tables first, working backward
DROP TABLE IF EXISTS sp16_rssfeed;
 
 
#all tables must be of type InnoDB to do transactions, foreign key constraints
CREATE TABLE sp16_rssfeed(
RSSFeed INT UNSIGNED NOT NULL AUTO_INCREMENT,
AdminID INT UNSIGNED DEFAULT 0,
Category VARCHAR(255) DEFAULT '',
Title VARCHAR(255) DEFAULT '',
FeedURL TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (RSSFeedID)
)ENGINE=INNODB;

#assigning first RSSFeed to RSSFeedID == 1
INSERT INTO sp16_rssfeed VALUES (NULL,1,'Entertainment','Midnight Oil','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/entertain-feed1.php',NOW(),NOW());


/* 

# Optional tables, in case we need multiple ones. Need to be modified from homework. 

#foreign key field must match size and type, hence SurveyID is INT UNSIGNED
CREATE TABLE sp16_questions(
QuestionID INT UNSIGNED NOT NULL AUTO_INCREMENT,
SurveyID INT UNSIGNED DEFAULT 0,
Question TEXT DEFAULT '',
Description TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (QuestionID),
INDEX SurveyID_index(SurveyID),
FOREIGN KEY (SurveyID) REFERENCES sp16_surveys(SurveyID) ON DELETE CASCADE
)ENGINE=INNODB;

INSERT INTO sp16_questions VALUES (NULL,1,'Do You Like Our Website?','We really want to know!',NOW(),NOW());
INSERT INTO sp16_questions VALUES (NULL,1,'Do You Like Cookies?','We like cookies!',NOW(),NOW());
INSERT INTO sp16_questions VALUES (NULL,1,'Favorite Toppings?','We like chocolate!',NOW(),NOW());

#foreign key field must match size and type, hence DemoID is INT UNSIGNED
CREATE TABLE sp16_demographics(
DemoID INT UNSIGNED NOT NULL AUTO_INCREMENT,
SurveyID INT UNSIGNED DEFAULT 0,
Demographic TEXT DEFAULT '',
Description TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (DemoID),
INDEX SurveyID_index(SurveyID),
FOREIGN KEY (SurveyID) REFERENCES sp16_surveys(SurveyID) ON DELETE CASCADE
)ENGINE=INNODB;

INSERT INTO sp16_demographics VALUES (NULL,1,'What is your gender?','Male/Female/Both/None/Other/Refuse to Answer',NOW(),NOW());
INSERT INTO sp16_demographics VALUES (NULL,1,'What is your yearly income?','Under $25,000/$25,000-$75,000/Over $75,000.',NOW(),NOW());
INSERT INTO sp16_demographics VALUES (NULL,1,'Do you have pets?','Yes/No/Other',NOW(),NOW());
*/ 

/*
Add additional tables here


*/
SET foreign_key_checks = 1; #turn foreign key check back on