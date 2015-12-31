DROP TABLE OrderedProduct;
DROP TABLE Orders;
DROP TABLE Warehouse;
DROP TABLE Product;
DROP TABLE Customer;



CREATE TABLE Customer (
 userID VARCHAR(10),
 pswd VARCHAR(20),
 firstName  VARCHAR(10),
 lastName VARCHAR(10),
 cAddress VARCHAR(10),
 city VARCHAR(10),
 postalcode VARCHAR(6),
 province CHAR(10),
 country CHAR(10),
 phonenumber INT,
 email VARCHAR(25),
PRIMARY KEY(userID)
);




 CREATE TABLE Product (
  productId INT NOT NULL,
  productName VARCHAR(50),
  categoryName VARCHAR(50),
  description VARCHAR(200),
  price	Decimal(9,2),
  img     VARCHAR(500), 
PRIMARY KEY (productID),

);


CREATE TABLE Warehouse (
 productId INT,
 amount INT,
FOREIGN KEY(productId) REFERENCES Product (productId)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Orders (
   orderId 	int 	NOT NULL IDENTITY PRIMARY KEY,
   userID VARCHAR(10),
   totalAmount 	decimal(9,2),
   FOREIGN KEY (userID) REFERENCES Customer (userID)
   ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE OrderedProduct (
   orderId       int	NOT NULL,
   productId     int	NOT NULL,
   quantity      int,
   price         decimal(9,2),
   PRIMARY KEY (OrderId, ProductId),
   CONSTRAINT FK_OrderedProduct_Order FOREIGN KEY (OrderId) REFERENCES Orders (OrderId) 
   ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_OrderedProduct_Product FOREIGN KEY (ProductId) REFERENCES Product (ProductId) 
   ON DELETE CASCADE ON UPDATE CASCADE
);


	INSERT Product VALUES(1,'That Missing Sock From the Dryer','Clothing', 'You''ve been looking for this for years. We found it for you!', 3.00, 'https://upload.wikimedia.org/wikipedia/commons/8/89/Blue_sock.jpg');
	INSERT Product VALUES(2,'Grandma''s Homemade Itchy Sweater','Clothing','She loves you so much. She''s so proud of you.The least you can do is wear this sweater she made with love.', 25.00, 'https://farm9.staticflickr.com/8330/8119823941_2d9d6520b1_o_d.jpg');
	INSERT Product VALUES(3,'Kid''s Telescope','Toys','For the Aunt or Uncle who''s stumped for gifts.', 50.00, 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRQbKBHmwwrSCfTcn1TEijIouYaEFr-qxRDavcg4O3Y4lIkL0bu');
	INSERT Product VALUES(4,'Pots and Pans','Toys','What the hey they''ll play with anything right? Multi-use gift!', 30.00,'https://farm3.staticflickr.com/2364/1532958780_ca212a14ba_o_d.jpg');
	INSERT Product VALUES(5,'Teddy Bear Security Camera','Home Essentials','What you do with this doesn''t concern us. Perfect gift for Valentine''s Day!', 200.00, 'https://farm4.staticflickr.com/3614/3304306800_1aa2690bf5_o_d.png');
	INSERT Product VALUES(6,'Nut Cracker','Home Essentials','Don''t worry, not that kind.', 7.50, 'http://img01.taobaocdn.com/bao/uploaded/i1/T1ow5JXmdaXXahge2X_115058.jpg');
	INSERT Product VALUES(7,'Walkie Talkie','Toys','Talk to your friends from as far away as 10 ft!',19.99,'http://www.orbitalsound.com/gfx/event-comms/tetraradios.jpg');
	INSERT Product VALUES(8,'Temporary Tattoos','Beauty','You''re a rebel. At least for as long as these tattoos last anyways.', 5.00, 'http://ecx.images-amazon.com/images/I/41jYUYgjLRL.jpg');
	INSERT Product VALUES(9,'Makeup Remover','Beauty','Girl you don''t need makeup, you''re perfect when you wake up.', 9.00, 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Kleenex-small-box.jpg');
	INSERT Product VALUES(10,'Hand Sanitizer','Beauty','Keep those hands clean!', 4.00,'http://ep.yimg.com/ay/yhst-29523360387793/purell-hand-sanitizer-advanced-2-oz-2.gif');
	INSERT Product VALUES(11,'Lost Fish Pillow','Home Essentials','Not in anyway associated with the works of Pixar.', 15.00,'https://farm4.staticflickr.com/3469/3986303072_2d384bc97a_o_d.jpg');
	INSERT Product VALUES(12,'Gummy Bear','Healthy candy','Tasty Gummy Bears that are healthy. I am a gummy bear, I am a yummy wummy little gummy bear.', 15.00,'http://cdn.playbuzz.com/cdn/a3f01d33-979b-4442-882b-9a776391e4f8/8b921575-63bb-4cf0-8234-db0dc974764a.jpg');

INSERT Warehouse VALUES(1,100);
INSERT Warehouse VALUES(2,100);
INSERT Warehouse VALUES(3,100);
INSERT Warehouse VALUES(4,100);
INSERT Warehouse VALUES(5,100);
INSERT Warehouse VALUES(6,100);
INSERT Warehouse VALUES(7,100);
INSERT Warehouse VALUES(8,100);
INSERT Warehouse VALUES(9,100);
INSERT Warehouse VALUES(10,100);
INSERT Warehouse VALUES(11,100);
INSERT Warehouse VALUES(12,100);

