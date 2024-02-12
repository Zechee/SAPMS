# Student Academic Performance Management System

## Functional Design

### Administrator

#### Categories

```mermaid
graph TB;
sys[Student Achievement Management System] --> manage[Administrator];
manage --> Login & Grade Management & Student Management & Class Management & Subject Management;
```

#### Grade Management

```mermaid
graph TB;
score_m[Grade Management];
score_m --> select[Query Grade] & add[Add Grade] & delete[Delete Grade] & update[Update Grade];
select --> s_one[Query Grade for a Student] & s_class_[Query by Class];
s_class_ --> Subject Grade List & Class Grade Statistics;

```

#### Student Management

```mermaid
graph TB;
student_m[Student Management];
student_m --> Modify Student Information & Add Student Information & Delete Student Information & Student List;
Student List --> By Class & Name Search;

```

#### Subject Management

```mermaid
graph TB;
subject_m[Subject Management];
subject_m --> Modify Subject Information & Add Subject Information & Delete Subject Information & Subject List;

```

#### Class Management

```mermaid
graph TB;
class_m[Class Management];
class_m --> Modify Class Information & Add Class Information & Delete Class Information & Class List;
```

### Student


```mermaid
graph TB;
sys[Student Academic Performance Management System] --> student[Student]
student --> Login & View Own Grades & View Rankings & Login System & Change Password;
```

## Database Design

### Database Tables

#### admin (Administrator Table)

| Field Name | Type     | Length | Description |
| ---------- | -------- | ------ | ----------- |
| mid        | varchar  | 10     | Administrator ID |
| password   | varchar  | 10     | Password    |
| createTime | datetime |        | Creation Time |

#### student (Student Table)

| Field Name | Type     | Length | Description |
| ---------- | -------- | ------ | ----------- |
| sid        | varchar  | 10     | Student ID  |
| password   | varchar  | 10     | Password    |
| createTime | datetime |        | Creation Time |
| gender     | char     | 3      | Gender      |
| birth      | date     |        | Date of Birth |
| name       | varchar  | 10     | Student Name |
| classid    | varchar  | 10     | Class ID    |

#### subject (Subject Table)

| Field Name | Type     | Length | Description |
| ---------- | -------- | ------ | ----------- |
| subid      | varchar  | 10     | Subject ID  |
| name       | varchar  | 10     | Subject Name |
| createTime | datetime |        | Creation Time |
| total      | int      |        | Total Score |

#### class (Class Table)

| Field Name | Type     | Length | Description |
| ---------- | -------- | ------ | ----------- |
| classid    | varchar  | 10     | Class ID    |
| name       | varchar  | 10     | Class Name  |
| createTime | datetime |        | Creation Time |

#### score (Grade Table)

| Field Name | Type     | Length  | Description     |
| ---------- | -------- | ------- | --------------- |
| scoreid    | varchar  | 10      | Grade Record ID |
| sid        | varchar  | 10      | Student ID      |
| subid      | varchar  | 10      | Subject ID      |
| grade      | decimal  | (3,1)   | Grade           |
| createTime | datetime |         | Creation Time   |


### Database Statement Design

#### Views

+ class_and_subject_statistics

```sql
SELECT
	AVG(score.grade) AS average,
	MAX(score.grade) AS max,
	MIN(score.grade) AS min,
    (
        SELECT COUNT(*) AS Expr1 
     	FROM student 
     	WHERE classid = class.classid
    ) AS classCount, 
    COUNT(*) AS testCount,
    (
        SELECT COUNT(*) AS Expr1
        FROM score_detail
        WHERE 
        	grade >= total * 0.6 
        	AND classid = class.classid 
        	AND subid = score.subid
    ) AS passCount,
    (
        SELECT COUNT(*) AS Expr1
        FROM score_detail AS score_detail_1
        WHERE 
        	grade >= total * 0.8
        	AND classid = class.classid
        	AND subid = score.subid
    ) AS goodCount, 
    score.subid, 
    class.classid
	FROM 
		score INNER JOIN student AS student_1 
			ON score.sid = student_1.sid 
    			INNER JOIN subject
    				ON score.subid = subject.subid 
                		INNER JOIN class 
                			ON student_1.classid = class.classid
	GROUP BY score.subid, class.classid
```


+ score_detail

```sql
SELECT 
	score.grade,
	subject.total,
    student.name,
    student.gender,
    student.birth,
    class.name AS class,
    subject.name AS subject,
    class.classid,
    score.subid,
    score.sid,
    score.scoreid
    FROM
    	score INNER JOIN student
        	ON score.sid = student.sid
        		INNER JOIN subject
        			ON score.subid = subject.subid
        				INNER JOIN class
        					ON student.classid = class.classid
```


#### Function Implementation


+ Administrator Login

  ```sql
  SELECT COUNT(*) FROM admin WHERE mid=#{mid} AND password=#{password}
  ```

+ Grade Management

  + Query grades for a specific studen

  ```sql
  SELECT grade,total,subject,subid FROM score_detail WHERE sid=#{sid};
  SELECT grade,total,subject,subid FROM score_detail WHERE name=#{name};
  ```
  

  
  + Query grade list by class and subject: {grade,total,name,gender,birth,class,sid}
  
  ```sql
  SELECT * FROM score_detail WHERE classid=#{classid} AND subid=#{subid};
  ```
  

  + Query class grade statistics data

  
  ```sql
  SELECT * FROM class_and_subject_statistics WHERE classid=#{classId} AND subid=#{subid} 
  ```



  + Add grade
  
  ```sql
  INSERT INTO score (scoreid,sid,subid,grade,createTime) VALUES(#{scoreid},#{sid},#{subid},#{grade},Getdate())
  ```
  
  + Delete grade
  
  ```sql
  DELETE FROM score WHERE scoreid=#{scoreId}
  ```
  
  + Update grade
  
  ```sql
  UPDATE score SET grade={grade} WHERE scoreid=#{scoreId}
  ```
  
+ Student Management

  + Query student information by class
  ```sql
  select * from student where classid=#{c00001};
  ```

  + Fuzzy name search for student information
  ```sql
  SELECT  student.name as name,sid,gender,birth,class.name as className FROM student,class WHERE student.classid=class.classid AND student.name LIKE CONNACT('%',#{value},'%')
  ```

  + Add student information
  
  ```sql
  INSERT INTO student (name,sid,gender,classid,birth,createTime) VALUES (#{name},#{sid},#{gender},#{classId},#{birth},Getdate())
  ```
  
  + Update student information
  
  ```sql
  UPDATE student SET name=#{name},classid=#{classId},gender=#{gender},birth=#{birth} WHERE sid=#{sid}
  ```
  
  + Delete student information
  
  ```sql
  DELETE FROM student WHERE sid=#{sid}
  ```
  
+ Class Management

  + Query class list

    ```sql
    SELECT * FROM class WHERE name LIKE '%#{name}%'
    ```

  + Update class information

    ```sql
    UPDATE class SET name=#{className} WHERE classid=#{classId}
    ```

  + Add class information

    ```sql
    INSERT INTO class (classid,name,createTime) VALUES (#{classId},#{className},Getdate())
    ```

  + Delete class information

    ```sql
    DELETE FROM class WHERE classid=#{classId}
    ```

+ Course Management

  + Query subject list
  
    ```sql
    SELECT * FROM subject
    ```
  
  + Add subject information
  
    ```sql
    INSERT INTO subject (subid,name,total,createTime) VALUES (#{subId},#{subName},#{total},Getdate())
    ```
  
  + Delete subject information
  
    ```sql
    DELETE FROM subject WHERE subid=#{subId}
    ```