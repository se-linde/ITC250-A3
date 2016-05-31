SET foreign_key_checks = 0; #turn off constraints temporarily

#############table sp16_rssfeed###########
DROP TABLE IF EXISTS sp16_rssfeed;



CREATE TABLE sp16_rssfeed(
RSSFeedID INT UNSIGNED NOT NULL AUTO_INCREMENT,
CategoryID INT UNSIGNED NOT NULL DEFAULT 0,
DateAdded DATETIME,
PRIMARY KEY (RSSFeedID),
INDEX CategoryID_index(CategoryID),
FOREIGN KEY (CategoryID) REFERENCES 


#fill table sp16_rssfeed
INSERT INTO sp16_rssfeed VALUES (NULL,1,NOW());
    
    
#Run this after all tables have been created.      
sp16_rssfeed_Categories(CategoryID) ON DELETE CASCADE
)ENGINE=INNODB;






#############table 1 sp16_rssfeed_Categories#############
DROP TABLE IF EXISTS sp16_rssfeed_Categories;
CREATE TABLE sp16_rssfeed_Categories(
CategoryID INT UNSIGNED NOT NULL AUTO_INCREMENT,
RSSFeedID INT UNSIGNED NOT NULL AUTO_INCREMENT,
Category VARCHAR(255) DEFAULT '',
Description TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
TimesViewed INT DEFAULT 0,
Status INT DEFAULT 0,
PRIMARY KEY (CategoryID)
)ENGINE=INNODB; 

INSERT INTO sp16_rssfeed_Categories VALUES (NULL,NULL,'Entertainment','Entertainment',NOW(),NOW(),0,0);
INSERT INTO sp16_rssfeed_Categories VALUES (NULL,NULL,'News','News',NOW(),NOW(),0,0); 
INSERT INTO sp16_rssfeed_Categories VALUES (NULL,NULL,'Science','Science',NOW(),NOW(),0,0); 

#########table 2 sp16_rssfeed_Entertainment########
DROP TABLE IF EXISTS sp16_rssfeed_Entertainment;
CREATE TABLE sp16_rssfeed_Entertainment(
EntertainmentID INT UNSIGNED NOT NULL AUTO_INCREMENT,
CategoryID INT UNSIGNED DEFAULT 0,
Title TEXT DEFAULT '',
FeedURL TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (EntertainmentID),
INDEX CategoryID_index(CategoryID),
FOREIGN KEY (CategoryID) REFERENCES sp16_rssfeed_Categories(CategoryID) ON DELETE CASCADE
)ENGINE=INNODB;

#fill table 2 sp16_rssfeed_Entertainment 

INSERT INTO sp16_rssfeed_Entertainment VALUES (NULL,1,'Midnight Oil','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/entertain-feed1.php',NOW(),NOW());
INSERT INTO sp16_rssfeed_Entertainment VALUES (NULL,1,'Piano','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/entertain-feed2.php',NOW(),NOW());
INSERT INTO sp16_rssfeed_Entertainment VALUES (NULL,1,'Radiohead','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/entertain-feed3.php',NOW(),NOW());

 #############table 3 sp16_rssfeed_News##############   
DROP TABLE IF EXISTS sp16_rssfeed_News;
CREATE TABLE sp16_rssfeed_News(
NewsID INT UNSIGNED NOT NULL AUTO_INCREMENT,
CategoryID INT UNSIGNED DEFAULT 0,
Title TEXT DEFAULT '',
FeedURL TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (NewsID),
INDEX CategoryID_index(CategoryID),
FOREIGN KEY (CategoryID) REFERENCES sp16_rssfeed_Categories(CategoryID) ON DELETE CASCADE
)ENGINE=INNODB;

#fill table 3 sp16_rssfeed_News
INSERT INTO sp16_rssfeed_News VALUES (NULL,2,'kittens','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/news-feed1.php',NOW(),NOW());
INSERT INTO sp16_rssfeed_News VALUES (NULL,2,'gun control','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/news-feed2.php',NOW(),NOW());
INSERT INTO sp16_rssfeed_News VALUES (NULL,2,'transgender','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/news-feed3.php',NOW(),NOW());  
    
 ##########table 4 sp16_rssfeed_Science##############   
DROP TABLE IF EXISTS sp16_rssfeed_Science;
CREATE TABLE sp16_rssfeed_Science(
ScienceID INT UNSIGNED NOT NULL AUTO_INCREMENT,
CategoryID INT UNSIGNED DEFAULT 0,
Title TEXT DEFAULT '',
FeedURL TEXT DEFAULT '',
DateAdded DATETIME,
LastUpdated TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (ScienceID),
INDEX CategoryID_index(CategoryID),
FOREIGN KEY (CategoryID) REFERENCES sp16_rssfeed_Categories(CategoryID) ON DELETE CASCADE
)ENGINE=INNODB;
#fill sp16_rssfeed_Science
INSERT INTO sp16_rssfeed_Science VALUES (NULL,3,'Mars','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/science-feed1.php',NOW(),NOW());
INSERT INTO sp16_rssfeed_Science VALUES (NULL,3,'linear algebra','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/science-feed2.php',NOW(),NOW());
INSERT INTO sp16_rssfeed_Science VALUES (NULL,3,'California Science Center','http://www.lindese.com/itc250/sandbox/A3-RSS/xml-test/science-feed3.php',NOW(),NOW());

####Join table statment#############
SELECT Title, FeedURL, c.CategoryID, c.Category 
from sp16_rssfeed_Entertainment as e inner join sp16_rssfeed_Categories c on e.CategoryID = c.CategoryID
Where c.CategoryID = 1

# or 
SELECT Title, FeedURL, c.CategoryID, c.Category 
from sp16_rssfeed_News as n inner join sp16_rssfeed_Categories c on n.CategoryID = c.CategoryID


# or 
SELECT c.CategoryID, c.Category, r.RSSFeedID  
from sp16_rssfeed as r inner join sp16_rssfeed_Categories c on r.CategoryID = c.CategoryID

        
        
        



 
