CREATE SCHEMA drzewo;
SET SEARCH_PATH TO drzewo;

create table person (id_person int, first_name varchar(30), last_name varchar(30), gender varchar(30), date_of_birth varchar(30), date_of_death varchar(30), place_of_birth varchar(30));
create table relationship (id_relationship int, person1_id int, person2_id int, person1_role int, person2_role int, id_relationship_type int);
create table relationship_types (id_relationship_type int, relationship_type_desc varchar(30));
create table role (id_role int, role_desc varchar(30));	
alter table person add primary key (id_person);
alter table relationship add primary key (id_relationship, person1_id, person2_id, person1_role, person2_role, id_relationship_type);
alter table relationship_types add primary key (id_relationship_type);
alter table role add primary key (id_role);
alter table relationship add foreign key (person1_id) references person (id_person);
alter table relationship add foreign key (person2_id) references person (id_person);
alter table relationship add foreign key (id_relationship_type) references relationship_types (id_relationship_type);
alter table relationship add foreign key (person1_role) references role (id_role);
alter table relationship add foreign key (person2_role) references role (id_role);

insert into person (id_person, first_name, last_name, gender, date_of_birth, date_of_death, place_of_birth) values
(1, 'A1', 'A2', 'M', '1900', '1950', 'City1'),  (2, 'B1', 'B2', 'K', '1901', '1951', 'City2'), (3, 'C1', 'C2', 'M', '1902', '1952', 'City3'), 
(4, 'D1', 'D2', 'M', '1903', '1953', 'City4'), (5, 'E1', 'E2', 'M', '1920', '1970', 'City5'), (6, 'F1', 'F2', 'K', '1921', '1971', 'City6'),
(7, 'A1', 'A2', 'K', '1922', '1972', 'City1');
insert into relationship_types(id_relationship_type, relationship_type_desc) values (1, 'Maried'), (2, 'Parent/Child');
insert into role (id_role, role_desc) values (1, 'Father'), (2, 'Mother'), (3, 'Son'), (4, 'Daughter'), (5, 'Husband'), (6, 'Wife');
insert into relationship (id_relationship, person1_id, person2_id, person1_role, person2_role, id_relationship_type) values (1, 1, 2, 5, 6, 1),	
(2, 3, 4, 5, 6, 1), (3, 1, 5, 1, 3, 2), (4, 2, 5, 2, 3, 2), (5, 3, 6, 1, 4, 2), (6, 3, 7, 1, 4, 2), (7, 4, 6, 2, 4, 2), (8, 4, 7, 2, 4, 2), (9, 5, 6, 5, 6, 1);	

--1--
SELECT p_info.id_person as "ID",
	   p_info.first_name as "First Name",
	   p_info.last_name as "Last Name",
	   p_info.gender as "Gender",
	   p_info.date_of_birth as "Date of Birth",
	   p_info.date_of_death as "Date of Death",
	   p_info.place_of_birth as "Place of Birth",
	   spouse.first_name as "Spouse First Name",
	   spouse.last_name as "Spouse Last Name"
FROM person p_info
JOIN relationship ON CASE WHEN p_info.gender = 'M' THEN p_info.id_person = relationship.person1_id ELSE p_info.id_person = relationship.person2_id END
JOIN relationship_types ON relationship_types.id_relationship_type = relationship.id_relationship_type AND relationship_types.relationship_type_desc= 'Maried'
JOIN person spouse ON CASE WHEN p_info.gender = 'M' THEN spouse.id_person = relationship.person2_id ELSE spouse.id_person = relationship.person1_id END
WHERE p_info.first_name = 'Cathleen' AND p_info.last_name = 'Walsh';

--2--
SELECT parent.first_name as "Parent First Name",
	   parent.last_name as "Parent Last Name"
FROM person parent
JOIN relationship on parent.id_person = relationship.person1_id
JOIN relationship_types on relationship_types.id_relationship_type = relationship.id_relationship_type AND relationship_types.relationship_type_desc= 'Parent/Child'
JOIN person child on child.id_person = relationship.person2_id
WHERE child.first_name= 'Jon' AND child.last_name = 'Erikson';
 
--3--
SELECT child.first_name as "Child First Name",
	   child.last_name as "Child Last Name"
FROM person child
JOIN relationship on child.id_person = relationship.person2_id
JOIN relationship_types on relationship_types.id_relationship_type = relationship.id_relationship_type AND relationship_types.relationship_type_desc= 'Parent/Child'
JOIN person parent on parent.id_person = relationship.person1_id
WHERE parent.first_name= 'Steven' AND parent.last_name = 'Erikson';

