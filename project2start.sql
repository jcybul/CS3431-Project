drop table Doctor cascade constraint;
drop table OP cascade constraint;
drop table PCP cascade constraint;
drop table Surgeon cascade constraint;
drop table Organ cascade constraint;
drop table Patient cascade constraint;
drop table Operation cascade constraint;
drop table SurgeonPatient cascade constraint;
drop sequence physicianID_seq;
drop sequence healthCareID_seq;
drop sequence organID_seq;
drop sequence invoiceNumber_seq;

drop view MatchingBloodTypes;

create table Doctor (
	physicianID number,
	Role varchar2(25),
	firstName varchar2(25),
	lastName varchar2(25),
	constraint Doctor_PK primary key (physicianID),
	constraint Doctor_UN unique (physicianID, Role),
	constraint DoctorRoleVal check (Role in ('OP', 'PCP', 'Surgeon', 'Other'))
);

create sequence physicianID_seq
start with 100
increment by 5;

create table OP (
	physicianID number,
	Role varchar2(25) default 'OP' not null,
	organBank varchar2(25),
	organType varchar2(25),
	constraint OP_PK primary key (physicianID),
	constraint OPRoleVal check (Role in ('OP')),
	constraint OP_FK foreign key (physicianID, Role) references Doctor (physicianID, Role)
);

create table PCP (
	physicianID number,
	Role varchar2(25) default 'PCP' not null,
	specialty varchar2(25),
	medicalFacility varchar2(25),
	constraint PCP_PK primary key (physicianID),
	constraint PCPRoleVal check (Role in ('PCP')),
	constraint PCP_FK foreign key (physicianID, Role) references Doctor (physicianID, Role)
);

create table Surgeon (
	physicianID number,
	Role varchar2(25) default 'Surgeon' not null,
	boardCertified char(1),
	constraint Surgeon_PK primary key (physicianID),
	constraint SurgeonRoleVal check (Role in ('Surgeon')),
	constraint SurgeonBoardCertifiedVal check (boardCertified in ('T', 'F')),
	constraint Surgeon_FK foreign key (physicianID, Role) references Doctor (physicianID, Role)
);

create table Patient (
	healthCareID number,
	firstName varchar2(25),
	lastName varchar2(25),
	city varchar2(25),
	state char(2),
	bloodType varchar2(25),
	birthDate date,
	physicianID number,
	constraint Patient_PK primary key (healthCareID),
	constraint Patient_FK foreign key (physicianID) references PCP(physicianID),
	constraint PatientVal check (bloodType in ('A', 'B', 'AB', 'O'))
);

-- You could have included a value check for blood type as one of the following:
-- A, B, AB, O

create sequence healthCareID_seq
start with 100
increment by 5;


create table Organ (
	organID number,
	physicianID number,
	bloodType varchar2(25),
	dateRemoved date,
	healthCareID number,
	constraint Organ_PK primary key (organID, physicianID),
	constraint Organ_FK1 foreign key (physicianID) references OP(physicianID),
	constraint Organ_FK2 foreign key (healthCareID) references Patient(healthCareID),
	constraint OrganVal check (bloodType in ('A', 'B', 'AB', 'O'))
);
				   
create sequence organID_seq
start with 100
increment by 5;
				   

create table Operation (
	physicianID number,
	healthCareID number,
	invoiceNumber number,
	operationDate date,
	isSuccessful char(1),
	cost number(9,2),
	constraint Operation_PK primary key (invoiceNumber),
	constraint Operation_FK1 foreign key (physicianID) references Surgeon (physicianID),
	constraint Operation_FK2 foreign key (healthCareID) references Patient(healthCareID),
	constraint OperationVal check (isSuccessful in ('T', 'F'))
);

create sequence invoiceNumber_seq
start with 100
increment by 5;

create table SurgeonPatient (
	physicianID number,
	healthCareID number,
	constraint SurgeonPatient_PK primary key (physicianID, healthCareID),
	constraint SurgeonPatient_FK1 foreign key (physicianID) references Surgeon (physicianID),
	constraint SurgeonPatient_FK2 foreign key (healthCareID) references Patient(healthCareID)
);

insert into Doctor values(physicianID_seq.nextval, 'PCP', 'Matthew', 'Cantu');
insert into Doctor values(physicianID_seq.nextval, 'PCP', 'Chana', 'Owen');
insert into Doctor values(physicianID_seq.nextval, 'PCP', 'Noelle', 'Jordan');
insert into Doctor values(physicianID_seq.nextval, 'PCP', 'Henry', 'Mcbridge');
insert into Doctor values(physicianID_seq.nextval, 'PCP', 'Terrell', 'Riley');

insert into Doctor values(physicianID_seq.nextval, 'Surgeon', 'Trace', 'Ashley');
insert into Doctor values(physicianID_seq.nextval, 'Surgeon', 'Rey', 'Frye');
insert into Doctor values(physicianID_seq.nextval, 'Surgeon', 'Sterling', 'Weber');
insert into Doctor values(physicianID_seq.nextval, 'Surgeon', 'Rocco', 'Ayala');
insert into Doctor values(physicianID_seq.nextval, 'Surgeon', 'Patience', 'Cantu');

insert into Doctor values(physicianID_seq.nextval, 'OP', 'Mathias', 'Guerra');
insert into Doctor values(physicianID_seq.nextval, 'OP', 'Maryjane', 'Clay');
insert into Doctor values(physicianID_seq.nextval, 'OP', 'Eric', 'Weiss');

insert into PCP values(100, 'PCP', 'Family Medicine', 'Reliant Medical');
insert into PCP values(105, 'PCP', 'Internal Medicine', 'Cape Code Medical');
insert into PCP values(110, 'PCP', 'Pediatrics', 'Tufts Medical');
insert into PCP values(115, 'PCP', 'Geriatrics', 'Boston Medical');
insert into PCP values(120, 'PCP', 'Pediatrics', 'Boston Medical');

insert into Surgeon values(125, 'Surgeon', 'T');
insert into Surgeon values(130, 'Surgeon', 'F');
insert into Surgeon values(135, 'Surgeon', 'T');
insert into Surgeon values(140, 'Surgeon', 'F');
insert into Surgeon values(145, 'Surgeon', 'T');

insert into OP values(150, 'OP', 'Kidney Foundation', 'Kidney');
insert into OP values(155, 'OP', 'The Living Bank', 'Heart');
insert into OP values(160, 'OP', 'Donate Life America', 'Lungs');

insert into Patient values (healthCareID_seq.nextval,'Carl','Stein','Boston','MA','A','14-May-75',100);
insert into Patient values (healthCareID_seq.nextval,'James','Lloyd','Cambridge','MA','A','14-May-89',105);
insert into Patient values (healthCareID_seq.nextval,'Roman','Phillips','Worcester','MA','A','13-Jun-62',110);
insert into Patient values (healthCareID_seq.nextval,'Daryl','Miller','Waltham','MA','A','16-Apr-76',115);
insert into Patient values (healthCareID_seq.nextval,'Darcy','Carroll','Miami','FL','A','06-Nov-79',120);
insert into Patient values (healthCareID_seq.nextval,'Kevin','Hamilton','Austin','TX','B','31-Dec-90',100);
insert into Patient values (healthCareID_seq.nextval,'Violet','Casey','Houston','TX','B','19-Oct-99',105);
insert into Patient values (healthCareID_seq.nextval,'Richard','Watson','Jersey','NY','B','29-Aug-05',110);
insert into Patient values (healthCareID_seq.nextval,'Grace','Foster','Buffalo','NY','B','10-Aug-87',115);
insert into Patient values (healthCareID_seq.nextval,'Adam','Tucker','Syracuse','NY','B','02-Aug-83',120);
insert into Patient values (healthCareID_seq.nextval,'Robert','Robinson','Los Angeles','CA','AB','09-Jan-89',100);
insert into Patient values (healthCareID_seq.nextval,'Amber','Sullivan','Los Angeles','CA','AB','17-May-68',105);
insert into Patient values (healthCareID_seq.nextval,'Arnold','Owens','Chula Vista','CA','AB','14-Jul-95',115);
insert into Patient values (healthCareID_seq.nextval,'Melissa','Casey','Dallas','TX','AB','16-Apr-99',120);
insert into Patient values (healthCareID_seq.nextval,'Melanie','Perkins','Forth Worth','TX','AB','21-Jun-81',110);
insert into Patient values (healthCareID_seq.nextval,'Marcus','Murphy','El Paso','TX','O','11-Jun-77',100);
insert into Patient values (healthCareID_seq.nextval,'Grace','Ferguson','Akron','OH','O','12-Jun-83',105);
insert into Patient values (healthCareID_seq.nextval,'Alina','Cooper','Cleveland','OH','O','19-Jul-80',110);
insert into Patient values (healthCareID_seq.nextval,'Alissa','Reed','Anchorage','AK','O','02-Dec-91',115);
insert into Patient values (healthCareID_seq.nextval,'Elise','Wright','Phoenix','AZ','O','30-Aug-55',120);
					  

					  
insert into Operation values (125,100,invoiceNumber_seq.nextval,'1-Sep-19','F',10654.50);
insert into Operation values (130,105,invoiceNumber_seq.nextval,'1-Sep-19','T',110.5);
insert into Operation values (135,110,invoiceNumber_seq.nextval,'1-Sep-19','T',1203.90);
insert into Operation values (140,115,invoiceNumber_seq.nextval,'1-Sep-19','T',13045.4);
insert into Operation values (145,120,invoiceNumber_seq.nextval,'1-Sep-19','F',1000.3);
insert into Operation values (125,125,invoiceNumber_seq.nextval,'1-Sep-19','T',100.12);
insert into Operation values (130,130,invoiceNumber_seq.nextval,'1-Sep-19','T',10033.90);
insert into Operation values (135,135,invoiceNumber_seq.nextval,'1-Sep-19','T',40000.10);
insert into Operation values (140,140,invoiceNumber_seq.nextval,'1-Sep-19','T',143534);
insert into Operation values (145,145,invoiceNumber_seq.nextval,'1-Sep-19','T',1345.4);
insert into Operation values (125,150,invoiceNumber_seq.nextval,'1-Sep-19','T',10435.90);
insert into Operation values (135,155,invoiceNumber_seq.nextval,'1-Sep-19','T',14540);
insert into Operation values (130,160,invoiceNumber_seq.nextval,'1-Sep-19','T',10340);
insert into Operation values (145,165,invoiceNumber_seq.nextval,'1-Sep-19','T',104350);
insert into Operation values (140,170,invoiceNumber_seq.nextval,'1-Sep-19','T',10000.09);
insert into Operation values (125,175,invoiceNumber_seq.nextval,'1-Sep-19','T',1030.04);
insert into Operation values (135,180,invoiceNumber_seq.nextval,'1-Sep-19','T',10340.90);
insert into Operation values (125,185,invoiceNumber_seq.nextval,'1-Sep-19','T',1034.23);
insert into Operation values (145,190,invoiceNumber_seq.nextval,'1-Sep-19','T',12134.45);
insert into Operation values (130,195,invoiceNumber_seq.nextval,'1-Sep-19','F',1000.345);
				       
				       
insert into Organ values (organID_seq.nextval,150,'O','3-Oct-18',100);
insert into Organ values (organID_seq.nextval,150,'A','3-Oct-17',105);
insert into Organ values (organID_seq.nextval,155,'B','3-Oct-18',110);
insert into Organ values (organID_seq.nextval,160,'AB','3-Oct-16',115);
insert into Organ values (organID_seq.nextval,150,'O','3-Oct-18',120);
insert into Organ values (organID_seq.nextval,155,'A','3-Oct-18',125);
insert into Organ values (organID_seq.nextval,160,'B','3-Oct-12',130);
insert into Organ values (organID_seq.nextval,150,'AB','3-Oct-18',135);
insert into Organ values (organID_seq.nextval,155,'O','3-Oct-18',140);
insert into Organ values (organID_seq.nextval,160,'A','3-Oct-18',145);
insert into Organ values (organID_seq.nextval,150,'B','3-Oct-13',150);
insert into Organ values (organID_seq.nextval,155,'AB','3-Oct-18',155);
insert into Organ values (organID_seq.nextval,160,'O','3-Oct-18',160);
insert into Organ values (organID_seq.nextval,150,'A','3-Oct-18',165);
insert into Organ values (organID_seq.nextval,155,'B','3-Oct-18',170);
insert into Organ values (organID_seq.nextval,150,'AB','3-Oct-18',175);
insert into Organ values (organID_seq.nextval,160,'O','3-Oct-18',180);
insert into Organ values (organID_seq.nextval,150,'A','3-Oct-18',185);
insert into Organ values (organID_seq.nextval,155,'B','3-Oct-18',190);
insert into Organ values (organID_seq.nextval,155,'AB','3-Oct-18',195);


select * 
from Doctor D join PCP P
 on D.physicianId = P.physicianID;

select * 
from Doctor D join Surgeon S
 on D.physicianid = S.physicianid;
 
 select * 
from Doctor D join OP O
 on D.physicianid = O.physicianid;


Select * from organ;

Create view MatchingBloodTypes as 
Select op.organtype as organType ,o.bloodtype as bType, Count(*)as cnt from
organ o join patient p
on o.bloodtype = p.bloodtype 
join op
on o.physicianid = op.physicianid
group by rollup (op.organtype,o.bloodtype)
order by op.organtype,o.bloodtype;

Select * from MatchingBloodTypes;
				       
				    
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
DBMS_OUTPUT.PUT_LINE('There is no surgeon that has operated with the name of Dr. '|| firstname || ' ' || lastname);
END IF;
END;
/
----------------------------------
set serveroutput on;
exec SurgeonOperations('Jhon','Smith');
				       
				      
				       
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
				       

