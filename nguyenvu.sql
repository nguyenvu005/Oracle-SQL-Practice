SELECT * FROM SALGRADE;
SELECT * FROM EMP;
SELECT DISTINCT JOB FROM EMP;
SELECT ENAME, SAL * 12 AS REMUNERATION 
FROM EMP;
SELECT ENAME || ' HAS HELP THE POSITION OF ' || JOB || ' IN DEPT ' || DEPTNO || ' SINCE ' || TO_CHAR(HIREDATE, 'DD-MM-YYYY') AS "Who, what and when" 
FROM EMP;
SELECT ENAME, DEPTNO, SAL 
FROM EMP 
WHERE SAL BETWEEN 1000 AND 2000;
SELECT DEPTNO, DNAME 
FROM DEPT 
ORDER BY DNAME ASC;
SELECT * FROM EMP 
WHERE DEPTNO IN (10, 20) 
ORDER BY ENAME ASC;
SELECT ENAME, JOB 
FROM EMP 
WHERE JOB = 'CLERK' AND DEPTNO = 20;
SELECT ENAME 
FROM EMP 
WHERE ENAME LIKE '%TH%' OR ENAME LIKE '%LL%';
-- 1. Liệt kê ENAME, DEPTNO và lương tăng 15% (PCTSAL)[cite: 38]
SELECT ENAME, DEPTNO, SAL * 1.15 AS PCTSAL 
FROM EMP;

-- 2. Hiển thị định dạng EMPLOYEE_AND_JOB (VD: KING******PRESIDENT)[cite: 39]
SELECT RPAD(ENAME, 8, '*') || RPAD(JOB, 10, '*') AS EMPLOYEE_AND_JOB 
FROM EMP;

-- 3. Hiển thị dạng EMPLOYEE (VD: KING (President))[cite: 39]
SELECT ENAME || ' (' || INITCAP(JOB) || ')' AS EMPLOYEE 
FROM EMP;

-- 4. Đổi tên công việc SALESMAN thành Salesperson[cite: 39]
SELECT ENAME, DEPTNO, DECODE(JOB, 'SALESMAN', 'Salesperson', INITCAP(JOB)) AS JOB 
FROM EMP;

-- 5. Tìm ngày thứ 6 đầu tiên cách 2 tháng so với ngày hiện tại[cite: 40]
SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 2), 'FRIDAY'), 'DD Month YYYY') AS "RESULT" 
FROM DUAL;

-- 6. Hiển thị ngày gia nhập công ty của phòng 20 theo định dạng chữ[cite: 40]
SELECT ENAME, TO_CHAR(HIREDATE, 'fmmonth, Dspth YYYY') AS "DATE HIRED" 
FROM EMP 
WHERE DEPTNO = 20;

-- 7. Hiển thị ngày gia nhập và ngày xét nâng lương (sau 1 năm)[cite: 40]
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 12) AS REVIEW 
FROM EMP 
ORDER BY REVIEW;

-- 8. Phân loại mức lương bằng mệnh đề CASE / DECODE[cite: 40]
SELECT ENAME, 
       CASE 
           WHEN SAL < 1500 THEN 'BELOW 1500'
           WHEN SAL = 1500 THEN 'On Target'
           ELSE TO_CHAR(SAL)
       END AS SALARY 
FROM EMP;

-- 9. Cho biết thứ của ngày hiện tại[cite: 40]
SELECT TO_CHAR(SYSDATE, 'DAY') AS "TODAY" FROM DUAL;

-- 10. Kiểm tra khuôn dạng nn/nn[cite: 40, 41]
SELECT VAL, 
       CASE WHEN REGEXP_LIKE(VAL, '^[0-9]{2}/[0-9]{2}$') THEN 'YES' ELSE 'NO' END AS "VALID?"
FROM (
    SELECT '12/34' AS VAL FROM DUAL UNION ALL
    SELECT '01/1a' FROM DUAL UNION ALL
    SELECT '99/88' FROM DUAL
);

-- 11. Hiển thị ngày lĩnh lương (Thứ 6, sau ít nhất 15 ngày làm việc)[cite: 41]
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE + 15, 'FRIDAY') AS PAY_DATE 
FROM EMP 
ORDER BY HIREDATE;
-- 1. Tìm lương thấp nhất, lớn nhất và trung bình[cite: 41]
SELECT MIN(SAL) AS MIN_SAL, MAX(SAL) AS MAX_SAL, AVG(SAL) AS AVG_SAL 
FROM EMP;

-- 2. Tìm lương nhỏ nhất và lớn nhất của mỗi loại nghề nghiệp[cite: 41]
SELECT JOB, MIN(SAL) AS MIN_SAL, MAX(SAL) AS MAX_SAL 
FROM EMP 
GROUP BY JOB;

-- 3. Đếm số lượng giám đốc (MANAGER)[cite: 41]
SELECT COUNT(*) AS NUM_OF_MANAGERS 
FROM EMP 
WHERE JOB = 'MANAGER';

-- 4. Tìm các phòng ban có số nhân viên > 3[cite: 41]
SELECT DEPTNO, COUNT(*) AS TOTAL_EMP 
FROM EMP 
GROUP BY DEPTNO 
HAVING COUNT(*) > 3;

-- 5. Tìm mức lương nhỏ nhất theo từng người quản lý (MGR)[cite: 41]
SELECT MGR, MIN(SAL) AS MIN_SAL 
FROM EMP 
WHERE MGR IS NOT NULL 
GROUP BY MGR 
ORDER BY MIN_SAL ASC;
-- 1. Tên nhân viên và tên phòng ban sắp xếp theo tên phòng[cite: 48]
SELECT E.ENAME, D.DNAME 
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
ORDER BY D.DNAME;

-- 2. Tên nhân viên, vị trí địa lý, tên phòng có SAL > 1500[cite: 48]
SELECT E.ENAME, D.LOC, D.DNAME 
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
WHERE E.SAL > 1500;

-- 3. Tên nhân viên, nghề nghiệp, lương và bậc lương (SALGRADE)[cite: 48]
SELECT E.ENAME, E.JOB, E.SAL, S.GRADE 
FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 4. Tên nhân viên, nghề nghiệp, lương có bậc lương = 3[cite: 48]
SELECT E.ENAME, E.JOB, E.SAL, S.GRADE 
FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE S.GRADE = 3;

-- 5. Nhân viên làm việc tại DALLAS[cite: 49]
SELECT E.ENAME, D.LOC, E.SAL 
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
WHERE D.LOC = 'DALLAS';

-- 6. Chi tiết nhân viên trừ nghề CLERK, sắp xếp lương giảm dần[cite: 49]
SELECT E.ENAME, E.JOB, E.SAL, S.GRADE, D.DNAME 
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.JOB != 'CLERK' 
ORDER BY E.SAL DESC;

-- 7. Nhân viên thu nhập 36000/năm hoặc làm nghề CLERK[cite: 49]
SELECT E.ENAME, E.JOB, E.SAL * 12 AS ANUAL_SAL, D.DNAME, S.GRADE 
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE (E.SAL * 12 = 36000) OR E.JOB = 'CLERK';

-- 8. Phòng ban không có nhân viên nào (Outer Join)[cite: 41, 44, 49]
SELECT D.DEPTNO, D.DNAME, D.LOC 
FROM DEPT D LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO 
WHERE E.EMPNO IS NULL;

-- 9. Tên nhân viên và tên người quản lý (Self Join)[cite: 41, 49]
SELECT E.ENAME AS EMP_NAME, E.SAL AS EMP_SAL, M.ENAME AS MGR_NAME, M.SAL AS MGR_SAL 
FROM EMP E JOIN EMP M ON E.MGR = M.EMPNO;

-- 10. Tương tự câu 9, hiển thị thêm ông KING (người không có MGR)[cite: 50]
SELECT E.ENAME AS EMP_NAME, E.SAL AS EMP_SAL, M.ENAME AS MGR_NAME, M.SAL AS MGR_SAL 
FROM EMP E LEFT JOIN EMP M ON E.MGR = M.EMPNO;

-- 11. Nghề tuyển dụng năm 1981 nhưng không tuyển năm 1994 (dùng MINUS)[cite: 42, 50]
SELECT JOB FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981'
MINUS
SELECT JOB FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1994';

-- 12. Tìm nhân viên gia nhập công ty trước Quản lý[cite: 50]
SELECT E.ENAME AS EMP_NAME, E.HIREDATE AS EMP_HIREDATE, M.ENAME AS MGR_NAME, M.HIREDATE AS MGR_HIREDATE 
FROM EMP E JOIN EMP M ON E.MGR = M.EMPNO 
WHERE E.HIREDATE < M.HIREDATE;

-- 13. Nhân viên có lương cao nhất theo từng loại nghề[cite: 50]
SELECT ENAME, JOB, SAL 
FROM EMP 
WHERE (JOB, SAL) IN (SELECT JOB, MAX(SAL) FROM EMP GROUP BY JOB);

-- 14. Nhân viên gia nhập phòng ban sớm nhất[cite: 51]
SELECT ENAME, HIREDATE, DEPTNO 
FROM EMP 
WHERE (DEPTNO, HIREDATE) IN (SELECT DEPTNO, MIN(HIREDATE) FROM EMP GROUP BY DEPTNO);

-- 15. Nhân viên có lương cao hơn lương trung bình của phòng mình[cite: 51]
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO 
FROM EMP E 
WHERE E.SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO);
-- 1. Tìm nhân viên gia nhập trong khoảng 2 ngày nhập vào (&first_date, &last_date)[cite: 53]
SELECT ENAME, HIREDATE 
FROM EMP 
WHERE HIREDATE BETWEEN TO_DATE('&first_date', 'DD-MM-YYYY') AND TO_DATE('&last_date', 'DD-MM-YYYY');

-- 2. Tìm thông tin nhân viên theo nghề nghiệp nhập vào (&job)[cite: 53]
SELECT ENAME, JOB, SAL, MGR, DEPTNO 
FROM EMP 
WHERE UPPER(JOB) = UPPER('&job');

-- 3. Định nghĩa biến tính thu nhập năm >= 30000[cite: 52, 53]
DEFINE rem = 'SAL * 12 + NVL(COMM, 0)';
SELECT ENAME, &rem AS ANUAL_SAL 
FROM EMP 
WHERE &rem >= 30000;

-- 4. Tính thâm niên làm việc của nhân viên nhập vào (&emp_name)[cite: 53]
SELECT ENAME, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) || ' YEAR ' || 
       MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)), 12) || ' MONTHS' AS "LENGTH OF SERVICE" 
FROM EMP 
WHERE UPPER(ENAME) = UPPER('&emp_name');
-- 1. Tạo bảng PROJECT[cite: 63]
CREATE TABLE PROJECT (
    PROJID        NUMBER(4) PRIMARY KEY,
    P_DESC        VARCHAR2(20),
    P_START_DATE  DATE,
    P_END_DATE    DATE,
    BUDGET_AMOUNT NUMBER(7,2),
    MAX_NO_STAFF  NUMBER(2),
    CONSTRAINT CK_PROJ_DATE CHECK (P_END_DATE > P_START_DATE)
);

-- 2. Tạo bảng ASSIGNMENTS[cite: 63]
CREATE TABLE ASSIGNMENTS (
    PROJID       NUMBER(4) NOT NULL REFERENCES PROJECT(PROJID),
    EMPNO        NUMBER(4) NOT NULL REFERENCES EMP(EMPNO),
    A_START_DATE DATE,
    A_END_DATE   DATE,
    BILL_AMOUNT  NUMBER(4,2),
    ASSIGN_TYPE  VARCHAR2(2)
);

-- 3. Thêm cột COMMENTS vào PROJECT và HOURS vào ASSIGNMENTS[cite: 63]
ALTER TABLE PROJECT ADD (COMMENTS LONG);
ALTER TABLE ASSIGNMENTS ADD (HOURS NUMBER);

-- 4. Thêm ràng buộc UNIQUE cho PROJID và EMPNO trong ASSIGNMENTS[cite: 63]
ALTER TABLE ASSIGNMENTS ADD CONSTRAINT UNQ_PROJ_EMP UNIQUE (PROJID, EMPNO);

-- 5. Chèn dữ liệu bài tập Chương 8 vào bảng PROJECT[cite: 67]
INSERT INTO PROJECT VALUES (1, 'WRITE C030 COURSE', TO_DATE('02-01-1988','DD-MM-YYYY'), TO_DATE('07-01-1988','DD-MM-YYYY'), 500, 1, NULL);
INSERT INTO PROJECT VALUES (2, 'PROOF READ NOTES', TO_DATE('01-01-1989','DD-MM-YYYY'), TO_DATE('10-01-1989','DD-MM-YYYY'), 600, 1, NULL);

-- 6. Chèn dữ liệu vào bảng ASSIGNMENTS[cite: 67]
INSERT INTO ASSIGNMENTS VALUES (1, 7369, TO_DATE('01-01-1988','DD-MM-YYYY'), TO_DATE('03-01-1988','DD-MM-YYYY'), 50.00, 'WR', 15);
INSERT INTO ASSIGNMENTS VALUES (1, 7902, TO_DATE('04-01-1988','DD-MM-YYYY'), TO_DATE('07-01-1988','DD-MM-YYYY'), 55.00, 'WR', 20);
INSERT INTO ASSIGNMENTS VALUES (2, 7844, TO_DATE('01-01-1989','DD-MM-YYYY'), TO_DATE('10-01-1989','DD-MM-YYYY'), 45.50, 'PF', 30);

COMMIT;
-- 1. Tạo Index trên cột PROJID cho bảng ASSIGNMENTS[cite: 69, 72]
CREATE INDEX IDX_ASSIGN_PROJID ON ASSIGNMENTS(PROJID);

-- 2. Hiển thị danh sách nhân viên thuộc quản lý của người có tên nhập từ bàn phím[cite: 72]
SELECT * FROM EMP 
WHERE MGR = (SELECT EMPNO FROM EMP WHERE UPPER(ENAME) = UPPER('&mgr_name'));
-- 1. Tạo View AGGREGATES tổng hợp dữ liệu lương/thưởng theo phòng ban[cite: 74]
CREATE OR REPLACE VIEW AGGREGATES AS 
SELECT DEPTNO, 
       AVG(SAL) AS AVERAGE, 
       MAX(SAL) AS MAXIMUM, 
       MIN(SAL) AS MINIMUM, 
       SUM(SAL) AS SUM, 
       COUNT(SAL) AS NO_SALS, 
       COUNT(COMM) AS NO_COMMS 
FROM EMP 
GROUP BY DEPTNO;

-- Xem kết quả View vừa tạo[cite: 74]
SELECT * FROM AGGREGATES;

-- 2. Định nghĩa bảng MESSAGES dùng cho lập trình PL/SQL[cite: 74]
CREATE TABLE MESSAGES (
    NUMCOL1  NUMBER(9,2),
    NUMCOL2  NUMBER(9,2),
    CHARCOL1 VARCHAR2(60),
    CHARCOL2 VARCHAR2(60),
    DATECOL1 DATE,
    DATECOL2 DATE
);
-- Bài 2: Vòng lặp Insert dữ liệu vào bảng MESSAGES (Bỏ qua 6 và 8)[cite: 83]
DECLARE
    V_COUNTER NUMBER := 1;
BEGIN
    WHILE V_COUNTER <= 10 LOOP
        IF V_COUNTER NOT IN (6, 8) THEN
            INSERT INTO MESSAGES (NUMCOL1) VALUES (V_COUNTER);
        END IF;
        V_COUNTER := V_COUNTER + 1;
    END LOOP;
    COMMIT;
END;
/

-- Kiểm tra kết quả trong bảng MESSAGES[cite: 74, 83]
SELECT * FROM MESSAGES;

-- Bài 4: Cập nhật dòng dữ liệu bằng PL/SQL Loop[cite: 83]
DECLARE
    V_ROWS_UPDATED NUMBER;
BEGIN
    FOR V IN 1..10 LOOP
        UPDATE MESSAGES 
        SET NUMCOL2 = 100 
        WHERE NUMCOL1 = V;
        
        V_ROWS_UPDATED := SQL%ROWCOUNT;
        IF V_ROWS_UPDATED > 1 THEN
            EXIT;
        END IF;
    END LOOP;
    COMMIT;
END;
/
