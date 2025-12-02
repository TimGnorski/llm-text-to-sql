SELECT count(*) FROM singer
SELECT count(*) FROM singer
SELECT T1.name, T1.country, T1.age FROM singer AS T1 JOIN concert AS T2 ON T1.singer_id = T2.singer_id ORDER BY T2.age DESC LIMIT 1
SELECT T1.name, T1.country, T1.age FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.singer_id = T2.singer_id ORDER BY T2.age DESC
SELECT avg(Age), min(Age), max(Age) FROM singer WHERE Country = "France"
SELECT avg(age), min(age), max(age) FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.singer_id = T2.singer_id GROUP BY T1.singer_id ORDER BY T1.age DESC LIMIT 1
SELECT T1.name, T1.release_year FROM singer AS T1 JOIN concert AS T2 ON T1.singer_id = T2.singer_id ORDER BY T2.age DESC LIMIT 1
SELECT Song_release_year, Song_release_year FROM singer ORDER BY Age DESC LIMIT 1
SELECT DISTINCT Country FROM singer WHERE Age > 20
SELECT Country FROM singer WHERE Age > 20
SELECT Country, COUNT(*) FROM singer GROUP BY Country
SELECT Country, count(*) FROM singer GROUP BY Country
SELECT Song_Name FROM singer WHERE Age > (SELECT avg(age) FROM singer_in_concert)
SELECT T1.name FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.singer_id = T2.singer_id WHERE T2.age > (SELECT avg(age) FROM singer_in_concert)
SELECT LOCATION, name FROM stadium WHERE capacity BETWEEN 5000 AND 10000
SELECT LOCATION, T1.name FROM stadium AS T1 JOIN concert AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.capacity BETWEEN 5000 AND 10000
SELECT max(capacity), avg(capacity) FROM stadium
SELECT avg(capacity), max(capacity) FROM stadium
SELECT name, capacity FROM stadium ORDER BY avg(capacity) DESC LIMIT 1
SELECT name, capacity FROM stadium ORDER BY avg(capacity) DESC LIMIT 1
SELECT count(*) FROM concert WHERE YEAR = 2014 OR YEAR = 2015
SELECT count(*) FROM concert WHERE YEAR = 2014 OR YEAR = 2015
SELECT T1.name, COUNT(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id GROUP BY T1.stadium_id
SELECT stadium, count(*) FROM concert GROUP BY stadium
SELECT name, capacity FROM stadium ORDER BY COUNT(*) DESC LIMIT 1
SELECT Name, Capacity FROM stadium ORDER BY Average DESC LIMIT 1
SELECT YEAR FROM concert GROUP BY YEAR ORDER BY COUNT(*) DESC LIMIT 1
SELECT YEAR FROM concert GROUP BY YEAR ORDER BY COUNT(*) DESC LIMIT 1
SELECT name FROM stadium WHERE stadium_id NOT IN (SELECT stadium_id FROM concert)
SELECT name FROM stadium WHERE stadium_id NOT IN (SELECT stadium_id FROM concert)
SELECT Country FROM singer WHERE Age > 40 INTERSECT SELECT Country FROM singer WHERE Age  30
SELECT T1.name FROM stadium AS T1 JOIN concert AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2014
SELECT T1.name FROM stadium AS T1 JOIN concert AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2014
SELECT T1.name, T1.theme, count(*) FROM concert AS T1 JOIN singer_in_concert AS T2 ON T1.concert_id = T2.concert_id GROUP BY T1.concert_id
SELECT T1.name, T1.theme, count(*) FROM singer_in_concert AS T1 JOIN concert AS T2 ON T1.concert_id = T2.concert_id GROUP BY T1.concert_id
SELECT T1.name, COUNT(*) FROM singer_in_concert AS T1 JOIN concert AS T2 ON T1.singer_id = T2.singer_id GROUP BY T1.singer_id
SELECT T1.name, COUNT(*) FROM singer_in_concert AS T1 JOIN concert AS T2 ON T1.singer_id = T2.singer_id GROUP BY T1.singer_id
SELECT T1.name FROM singer_in_concert AS T1 JOIN concert AS T2 ON T1.singer_id = T2.singer_id WHERE T1.year = 2014
SELECT T1.name FROM singer_in_concert AS T1 JOIN concert AS T2 ON T1.singer_id = T2.singer_id WHERE T1.year = 2014
SELECT T1.name, T1.country FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.singer_id = T2.singer_id WHERE T1.name LIKE "%Hey%"
SELECT T1.name, T1.country FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.singer_id = T2.singer_id WHERE T1.name LIKE '%Hey%'
SELECT T1.name, T1.location FROM stadium AS T1 JOIN concert AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2014 INTERSECT SELECT T1.location, T1.location FROM stadium AS T1 JOIN concert AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2015
SELECT T1.Name, T2.Location FROM stadium AS T1 JOIN concert AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2014 AND T2.year = 2015
SELECT count(*) FROM stadium ORDER BY capacity DESC LIMIT 1
SELECT count(*) FROM stadium ORDER BY capacity DESC LIMIT 1
SELECT count(*) FROM Pets WHERE weight > 10
SELECT count(*) FROM Pets WHERE weight > 10
SELECT weight FROM pets ORDER BY age DESC LIMIT 1
SELECT count(*) FROM Pets GROUP BY age ORDER BY count(*) DESC LIMIT 1
SELECT max(weight), pettype FROM Pets GROUP BY pettype
SELECT max(weight), max(weight) FROM Pets GROUP BY max(weight)
SELECT count(*) FROM Pets WHERE age > 20
SELECT count(*) FROM Pets WHERE age > 20
SELECT count(*) FROM Has_Pet WHERE sex = "F"
SELECT count(*) FROM Has_Pet WHERE Sex = "F"
SELECT count(DISTINCT pettype) FROM Pets
SELECT count(DISTINCT pettype) FROM Pets
SELECT T1.fname FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.PetType = "Cat" OR T2.PetType = "dog"
SELECT T1.fname FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.PetType = "Cat" OR T2.PetType = "dog"
SELECT T1.fname FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.PetType = "Cat" INTERSECT SELECT T1.Fname FROM Has_Pet AS T1 JOIN Pets AS T2 ON T1.PetID = T2.PetID WHERE T2.PetType = "dog"
SELECT T1.fname FROM Student AS T1 JOIN Pets AS T2 ON T1.StuID = T2.StuID WHERE T2.PetType = "Cat" INTERSECT SELECT T1.Fname FROM Has_Pet AS T1 JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID WHERE T2.PetType = "dog"
SELECT major, age FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT major FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT StuID FROM Has_Pet WHERE StuID NOT IN (SELECT StuID FROM Has_Pet WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT StuID FROM Has_Pet WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT T1.fname, T1.age FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.PetType = "dog" AND T2.PetType = "cat"
SELECT T1.fname FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.PetType = "dog" AND T2.PetType = "cat"
SELECT T1.PetType, T1.weight FROM Pets AS T1 JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID GROUP BY T1.PetID ORDER BY T1.age DESC LIMIT 1
SELECT pettype, weight FROM Pets ORDER BY age DESC LIMIT 1
SELECT petid, weight FROM Pets WHERE age > 1
SELECT petid, weight FROM Has_Pet WHERE age > 1
SELECT avg(age), max(age) FROM Pets GROUP BY pettype
SELECT avg(age), max(age), pettype FROM Pets GROUP BY pettype
SELECT avg(weight), pettype FROM Pets GROUP BY pettype
SELECT avg(weight), pettype FROM Pets GROUP BY pettype
SELECT T1.fname, T1.age FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID
SELECT DISTINCT T1.fname, T1.age FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID
SELECT T1.PetID FROM Has_Pet AS T1 JOIN Pets AS T2 ON T1.PetID = T2.PetID WHERE T1.LName = "Smith"
SELECT T1.PetID FROM Has_Pet AS T1 JOIN Pets AS T2 ON T1.PetID = T2.PetID WHERE T1.LName = 'Smith'
SELECT count(*), student_id FROM Has_Pet GROUP BY student_id
SELECT count(*), T1.StuID FROM Has_Pet AS T1 JOIN Pets AS T2 ON T1.PetID = T2.PetID GROUP BY T1.StuID
SELECT T1.fname, T1.sex FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID HAVING count(*) > 1
SELECT T1.fname, T1.sex FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID HAVING count(*) > 1
SELECT T1.Fname FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.age = 3
SELECT T1.Fname FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID WHERE T2.age = 3
SELECT avg(age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT avg(age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT count(*) FROM continents
SELECT count(*) FROM continents
SELECT continent, continentname, count(*) FROM countries GROUP BY continent
SELECT continents, countryname, count(*) FROM countries GROUP BY continent
SELECT count(*) FROM countries
SELECT count(*) FROM countries
SELECT fullname, id, count(*) FROM car_makers GROUP BY fullname
SELECT fullname, id, count(*) FROM car_makers GROUP BY fullname
SELECT Model FROM cars_data ORDER BY Horsepower DESC LIMIT 1
SELECT Model FROM cars_data ORDER BY Horsepower DESC LIMIT 1
SELECT model FROM car_names WHERE weight  (SELECT avg(weight) FROM car_names)
SELECT model FROM car_names WHERE weight  (SELECT avg(weight) FROM car_names)
SELECT T1.Make FROM car_makers AS T1 JOIN countries AS T2 ON T1.id = T2.id WHERE T2.Year = 1970
