# Lost and Found Item Management System (MySQL)

A relational database design for managing lost and found items on a university campus.

## Overview
Lost items on campus are usually reported through verbal reports, notice boards, or social media, which leads to incomplete records and no reliable way to track an item's status. This group project (CSF3123 Database, Universiti Malaysia Terengganu) proposes a centralized database where guards, finders, and owners are recorded and every item is tracked from report to return.

## Database design
Six tables: `User`, `Finder`, `Owner`, `Guard`, `Item`, and `Claim`.
- Items move through the statuses Pending, Lost, Found, and Claimed
- Finders report found items, owners report lost items and submit claims, and guards verify items and claims
- Relationships are enforced with primary keys, foreign keys, `CHECK` constraints, `DEFAULT` values, and `ON DELETE CASCADE` on claims
- The design was normalized from an unnormalized form (UNF) to 3NF to reduce redundancy

## Included queries
The script creates the tables, inserts sample data, and demonstrates:
- **Create:** table creation and inserts
- **Retrieve:** all items, items by status, items by date, items joined with finder contact, claims joined with item and owner details
- **Update:** item status to Claimed, claim verification status to Approved
- **Delete:** removing an incorrect item record

## Interface mockups
![Interface mockups](lost%20and%20found%20interface.png)

## Files
- [Lost & Found.sql](Lost%20%26%20Found.sql): database script (tables, sample data, and CRUD queries)
- [Lost & Found Report.pdf](Lost%20%26%20Found%20Report.pdf): full project report (problem statement, ERD, normalization from UNF to 3NF, queries, and assessment)
- `lost and found interface.png`: interface mockups for the finder, owner, and guard screens

## How to run
1. Install MySQL 8.0.16 or later (earlier versions ignore `CHECK` constraints)
2. Open `Lost & Found.sql` in MySQL Workbench and run the script
3. **Warning:** the script drops and recreates a database named `assignment`. If you already have a database with that name, change the first three lines of the script before running it.

## Limitations
- Sample data only; passwords are stored in plain text for demonstration. A real system should store hashed passwords.
- No image upload, notification feature, or role-based login in this version

## Tools
MySQL, MySQL Workbench

## Note
Group project for CSF3123 Database, Universiti Malaysia Terengganu.
