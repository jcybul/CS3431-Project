-- Joseph Cybul and Trevor Weiler: Project 2

drop view MatchingBloodTypes;
				   
-- 2
Create view MatchingBloodTypes as 
Select op.organtype as organType ,o.bloodtype as bType, Count(*)as cnt from
organ o join patient p
on o.bloodtype = p.bloodtype 
join op
on o.physicianid = op.physicianid
group by rollup (op.organtype,o.bloodtype)
order by op.organtype,o.bloodtype;

Select * from MatchingBloodTypes;		       

-- 3
Create or replace procedure SurgeonOperations(firstname varchar2, lastname varchar2) as 
op_number number;
Cursor c1 is 
Select s.firstName, s.lastName
from operation o join doctor s
on o.physicianID = s.physicianID
where s.role = 'Surgeon';
Begin
op_number:= 0;
For rec in c1 Loop
    IF rec.firstname = firstname AND rec.lastname = lastname then
        op_number := op_number + 1;
    END if;
END loop;
If op_number > 0 then 
DBMS_OUTPUT.PUT_LINE('Dr. '|| firstname || ' ' || lastname || ': ' || op_number|| ' operations');
ELSE
RAISE NO_DATA_FOUND;
END IF;
EXCEPTION 
WHEN NO_DATA_FOUND then 
DBMS_OUTPUT.PUT_LINE('There is no surgeon that has operated with the name of Dr. '|| firstname || ' ' || lastname);
END;
/				      

-- 4
Create or replace Trigger InsertErrorBirthDates 
before insert on Patient 
for each row declare
tempdate date;
Begin
Select sysdate into tempdate from dual;
IF (:new.birthdate > tempdate) then
    RAISE_APPLICATION_ERROR(-20003,'The birthdate is after the current date');
END If;
end;
/

-- 5
Create or replace trigger BadBloodType 
before insert on Operation
for each row declare 
tempBloodTypePatient varchar2(25);
tempBloodTypeOrgan varchar2(25);
Begin 
Select bloodtype into tempBloodTypePatient from Patient where healthCareID = (:new.healthCareID);
Select bloodtype into tempBloodTypeOrgan from Organ where healthCareID = (:new.healthCareID);

If(tempBloodTypeOrgan != tempBloodTypePatient) then 
RAISE_APPLICATION_ERROR(-20004,'Different bloodtypes');
End if;
end;
/

-- 6
Create or replace Trigger FailedOperation 
before insert on Operation 
for each row declare
tempBloodTypePatient varchar2(25);
tempBloodTypeOrgan varchar2(25);
Begin 
Select bloodtype into tempBloodTypePatient from Patient where healthCareID = (:new.healthCareID);
Select bloodtype into tempBloodTypeOrgan from Organ where healthCareID = (:new.healthCareID);

    If(tempBloodTypeOrgan != tempBloodTypePatient) then
    :new.isSuccessful := 'F';
    end if;
end;
/

-- 7
Create or replace Trigger NoMatch 
before insert on Operation 
for each row declare
tempPhysicianID number;
tempHealthCareID number;
Begin
select physicianID, healthCareID into tempPhysicianID, tempHealthCareID 
from SurgeonPatient where physicianID = (:new.physicianID) and healthCareID = (:new.healthCareID);
if (tempPhysicianID is null or tempHealthCareID is null) then
    RAISE NO_DATA_FOUND;
end if;
EXCEPTION 
WHEN NO_DATA_FOUND then 
RAISE_APPLICATION_ERROR(-20005,'No match between Surgeon and Patient found in SurgeonPatient table');
end;
/
   
