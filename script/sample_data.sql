USE bfeed_data;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE rule;
TRUNCATE TABLE content;
TRUNCATE TABLE beacon;
TRUNCATE TABLE user;

INSERT INTO user VALUES 
(1,'maniek','haslo','example@a.com','ADMIN' ),
(2,'test','test','test@a.com','ADMIN' );


INSERT INTO beacon VALUES 
(1,1,'beacon1','aaa1','bbb1','ccc1','moj maly bejkon','to jest bikon  z klopa'),
(2,1,'beacon2','aaa2','bbb2','ccc2','moj maly bejkon','to jest bikon  z klopa'),
(3,2,'beacon3','aaa3','bbb3','ccc3','moj maly bejkon','to jest bikon  z klopa'),
(4,2,'beacon4','aaa4','bbb3','ccc4','moj maly bejkon','to jest bikon  z klopa');

INSERT INTO content VALUES 
(1,1,'moj content1', 'To jest zajebisty content1','http://google.com','http://google.com'), 
(2,1,'moj content2', 'To jest zajebisty content2','http://google.com','http://google.com'), 
(3,1,'moj content3', 'To jest zajebisty content3','http://google.com','http://google.com'), 
(4,1,'moj content4', 'To jest zajebisty content4','http://google.com','http://google.com'), 
(5,1,'moj content5', 'To jest zajebisty content5','http://google.com','http://google.com'), 
(6,1,'moj content5', 'To jest zajebisty content6','http://google.com','http://google.com');

INSERT INTO rule VALUES 
(1,1,1,1,'rula 1','Opis ruli1','{"my":"rule"}'),
(2,1,2,2,'rula 2','Opis ruli1','{"my":"rule"}'),
(3,1,2,1,'rula 3','Opis ruli1','{"my":"rule"}');
