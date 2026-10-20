DROP DATABASE IF EXISTS assignment;
CREATE DATABASE assignment;
USE assignment;

CREATE TABLE User (
UserID 		INT AUTO_INCREMENT,
Email 		VARCHAR(100) NOT NULL UNIQUE,
Password 	VARCHAR(255) NOT NULL,
Role 		VARCHAR(50) CHECK (Role IN ('Finder', 'Owner', 'Guard')),
CONSTRAINT User_UserID_pk PRIMARY KEY(UserID)
);

CREATE TABLE Finder (
FinderID 	INT AUTO_INCREMENT,
ContactNo 	VARCHAR(20) NOT NULL,
UserID 		INT NOT NULL,
CONSTRAINT Finder_FinderID_pk PRIMARY KEY(FinderID),
CONSTRAINT Finder_UserID_fk FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Owner (
OwnerID 	INT AUTO_INCREMENT,
ContactNo 	VARCHAR(20) NOT NULL,
UserID 		INT NOT NULL,
CONSTRAINT Owner_OwnerID_pk PRIMARY KEY(OwnerID),
CONSTRAINT Owner_UserID_fk FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Guard (
GuardID		INT AUTO_INCREMENT,
ContactNo 	VARCHAR(20) NOT NULL,
UserID 		INT NOT NULL,
CONSTRAINT Guard_GuardID_pk PRIMARY KEY(GuardID),
CONSTRAINT Guard_UserID_fk FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Item (
ItemID 			INT AUTO_INCREMENT,
ItemName 		VARCHAR(100) NOT NULL,
Description 	VARCHAR(100),
Location 		VARCHAR(100) NOT NULL,
DateReported 	DATE NOT NULL,
Status 			VARCHAR(50) DEFAULT 'Pending',
FinderID 		INT,
OwnerID 		INT,
GuardID 		INT NOT NULL,

CHECK (Status IN ('Pending', 'Lost', 'Found', 'Claimed')),

CONSTRAINT Item_ItemID_pk PRIMARY KEY(ItemID),
CONSTRAINT Item_FinderID_fk FOREIGN KEY (FinderID) REFERENCES Finder(FinderID),
CONSTRAINT Item_OwnerID_fk FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID),
CONSTRAINT Item_GuardID_fk FOREIGN KEY (GuardID) REFERENCES Guard(GuardID)
);

CREATE TABLE Claim (
ClaimID 			INT AUTO_INCREMENT,
ClaimDate			DATE NOT NULL,
VerificationStatus 	VARCHAR(50) DEFAULT 'Pending',
ItemID 				INT NOT NULL,
OwnerID 			INT NOT NULL,
GuardID 			INT NOT NULL,

CHECK (VerificationStatus IN ('Pending', 'Approved', 'Rejected')),

CONSTRAINT Claim_ClaimID_pk PRIMARY KEY(ClaimID),
CONSTRAINT Claim_ItemID_fk FOREIGN KEY (ItemID) REFERENCES Item(ItemID) ON DELETE CASCADE,
CONSTRAINT Claim_OwnerID_fk FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID),
CONSTRAINT Claim_GuardID_fk FOREIGN KEY (GuardID) REFERENCES Guard(GuardID)
);

INSERT INTO User (Email, Password, Role) VALUES
('finder1@umt.edu.my', 'f123', 'Finder'),
('finder2@umt.edu.my', 'f234', 'Finder'),
('finder3@umt.edu.my', 'f345', 'Finder'),
('finder4@umt.edu.my', 'f456', 'Finder'),
('owner1@umt.edu.my', 'o123', 'Owner'),
('owner2@umt.edu.my', 'o234', 'Owner'),
('owner3@umt.edu.my', 'o345', 'Owner'),
('owner4@umt.edu.my', 'o456', 'Owner'),
('guard1@umt.edu.my', 'g123', 'Guard'),
('guard2@umt.edu.my', 'g234', 'Guard');

INSERT INTO Finder (ContactNo, UserID) VALUES
('0121000001', 1),
('0121000002', 2),
('0121000003', 3),
('0121000004', 4),
('0121000005', 1),
('0121000006', 2),
('0121000007', 3),
('0121000008', 4),
('0121000009', 1),
('0121000010', 2);

INSERT INTO Owner (ContactNo, UserID) VALUES
('0132000001', 5),
('0132000002', 6),
('0132000003', 7),
('0132000004', 8),
('0132000005', 5),
('0132000006', 6),
('0132000007', 7),
('0132000008', 8),
('0132000009', 5),
('0132000010', 6);

INSERT INTO Guard (ContactNo, UserID) VALUES
('0143000001', 9),
('0143000002', 10),
('0143000003', 9),
('0143000004', 10),
('0143000005', 9),
('0143000006', 10),
('0143000007', 9),
('0143000008', 10),
('0143000009', 9),
('0143000010', 10);

INSERT INTO Item
(ItemName, Description, Location, DateReported, Status, FinderID, OwnerID, GuardID)
VALUES
('Wallet', 'Black leather wallet', 'Library', '2024-12-01', 'Found', 1, NULL, 1),
('Bottle', 'Blue water bottle', 'Gym', '2024-12-02', 'Found', 2, NULL, 2),
('Umbrella', 'Red umbrella', 'Cafeteria', '2024-12-03', 'Found', 3, NULL, 3),
('Laptop Bag', 'Dell bag', 'Lecture Hall', '2024-12-04', 'Found', 4, NULL, 4),
('Student Card', 'Ali Ahmad', 'Library', '2024-12-05', 'Lost', NULL, 1, 5),
('Calculator', 'Casio FX-570', 'Exam Hall', '2024-12-06', 'Lost', NULL, 2, 6),
('Watch', 'Black digital watch', 'Gym', '2024-12-07', 'Lost', NULL, 3, 7),
('Power Bank', '20000mAh', 'Bus Stop', '2024-12-08', 'Lost', NULL, 4, 8),
('Earphone', 'Wireless earbuds', 'Cafeteria', '2024-12-09', 'Found', 5, NULL, 9),
('Notebook', 'Blue notebook', 'Library', '2024-12-10', 'Found', 6, NULL, 10);

INSERT INTO Claim
(ClaimDate, VerificationStatus, ItemID, OwnerID, GuardID)
VALUES
('2024-12-11', 'Approved', 1, 1, 1),
('2024-12-12', 'Pending', 2, 2, 2),
('2024-12-13', 'Rejected', 3, 3, 3),
('2024-12-14', 'Approved', 4, 4, 4),
('2024-12-15', 'Pending', 5, 5, 5),
('2024-12-16', 'Approved', 6, 6, 6),
('2024-12-17', 'Rejected', 7, 7, 7),
('2024-12-18', 'Pending', 8, 8, 8),
('2024-12-19', 'Approved', 9, 9, 9),
('2024-12-20', 'Rejected', 10, 10, 10);

SELECT * FROM Item;

SELECT * FROM Item
WHERE Status = 'Found';

SELECT * FROM Item
WHERE DateReported = '2024-12-03';

SELECT 
    Item.ItemID,
    Item.ItemName,
    Finder.ContactNo
FROM Item
JOIN Finder ON Item.FinderID = Finder.FinderID;

SELECT
    Claim.ClaimID,
    Item.ItemName,
    Owner.ContactNo,
    Claim.VerificationStatus
FROM Claim
JOIN Item ON Claim.ItemID = Item.ItemID
JOIN Owner ON Claim.OwnerID = Owner.OwnerID;

UPDATE Item
SET Status = 'Claimed'
WHERE ItemID = 1;

SELECT * FROM Item WHERE ItemID = 1;

UPDATE Claim
SET VerificationStatus = 'Approved'
WHERE ClaimID = 2;

SELECT * FROM Claim WHERE ClaimID = 2;

DELETE FROM Item
WHERE ItemID = 10;

SELECT * FROM Item WHERE ItemID = 10;