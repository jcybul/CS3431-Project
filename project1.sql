drop table Organ;
drop table OrganTransplant;
drop table Patient;
drop table OP;
drop table Surgeon;
drop table PCP;
drop table Doctor;

drop sequence physicianNum_seq;
drop sequence patientID_seq;
drop sequence organID_seq;

create table Doctor (
	physicianNum number,
	Role varchar2(25),
	firstName varchar2(25),
	lastName varchar2(25),
	constraint Doctor_pk primary key (physicianNum),
	constraint Doctor_un unique (physicianNum, Role),
	constraint DoctorRoleVal check(Role in ('PCP', 'Surgeon', 'OP'))
);

create sequence physicianNum_seq
start with 100
increment by 5;

create table PCP (
	physicianNum number,
	Role varchar2(25) default 'PCP' not null,
	specialty varchar2(25),
	medicalFacility varchar2(25),
	constraint PCP_pk primary key (physicianNum),
	constraint PCPRoleVal check (Role in ('PCP')),
	constraint PCP_fk foreign key (physicianNum, Role) references Doctor (physicianNum, Role)	
		On Delete Cascade
);

create table Surgeon (
	physicianNum number,
	Role varchar2(25) default 'Surgeon' not null,
	isCertified char(1),
	constraint Surgeon_pk primary key (physicianNum),
	constraint SurgeonRoleVal check (Role in ('Surgeon')),
	constraint Surgeon_fk foreign key (physicianNum, Role) references Doctor (physicianNum, Role)
		On Delete Cascade,
	constraint isCertifiedVal check (isCertified in ('T', 'F'))
);

create table OP (
	physicianNum number,
	Role varchar2(25) default 'OP' not null,
	organBank varchar2(25),
	organType varchar2(25),
	constraint OP_pk primary key (physicianNum),
	constraint OPRoleVal check (Role in ('OP')),
	constraint OP_fk foreign key (physicianNum, Role) references Doctor (physicianNum, Role)
		On Delete Cascade
);

create table Patient (
	patientID number,
	firstName varchar2(25),
	lastName varchar2(25),
	city varchar2(25),
	state varchar2(25),
	bloodType varchar2(25),
	birthDate date,
	physicianNum number,
	constraint Patient_pk primary key (patientID),
	constraint Patient_fk foreign key (physicianNum) references PCP(physicianNum)
);

create sequence patientID_seq
start with 100
increment by 5;

create table OrganTransplant (
	physicianNum number,
	patientID number,
	invoiceNum number,
	operationDate date,
	isSuccessful char(1),
	amountCharged number(12,2),
	constraint OrganTransplant_pk primary key (physicianNum, patientID, invoiceNum),
	constraint OrganTransplant_fk1 foreign key (physicianNum) references Surgeon (physicianNum),
	constraint OrganTransplant_fk2 foreign key (patientID) references Patient (patientID),
	constraint isSuccessfulVal check (isSuccessful in ('T', 'F'))
);
					  
create sequence invoiceNumID_seq
start with 100
increment by 5;


create table Organ (
	organID number,
	physicianNum number,
	bloodType varchar2(25),
	dateRemoved date,
	patientID number,
	constraint Organ_pk primary key (organID, physicianNum),
	constraint Organ_fk1 foreign key (physicianNum) references OP (physicianNum),
	constraint Organ_fk2 foreign key (patientID) references Patient (patientID)
);

create sequence organID_seq
start with 100
increment by 5;

-- 4

insert into Doctor values(physicianNum_seq.nextval, 'PCP', 'Matthew', 'Cantu');
insert into Doctor values(physicianNum_seq.nextval, 'PCP', 'Chana', 'Owen');
insert into Doctor values(physicianNum_seq.nextval, 'PCP', 'Noelle', 'Jordan');
insert into Doctor values(physicianNum_seq.nextval, 'PCP', 'Henry', 'Mcbridge');
insert into Doctor values(physicianNum_seq.nextval, 'PCP', 'Terrell', 'Riley');

insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Trace', 'Ashley');
insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Rey', 'Frye');
insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Sterling', 'Weber');
insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Rocco', 'Ayala');
insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Patience', 'Cantu');

insert into Doctor values(physicianNum_seq.nextval, 'OP', 'Mathias', 'Guerra');
insert into Doctor values(physicianNum_seq.nextval, 'OP', 'Maryjane', 'Clay');
insert into Doctor values(physicianNum_seq.nextval, 'OP', 'Eric', 'Weiss');

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

insert into Patient values (patientID_seq.nextval,'Carl','Stein','Boston','MA','A+','14-May-75',100);
insert into Patient values (patientID_seq.nextval,'James','Lloyd','Cambridge','MA','A+','14-May-89',105);
insert into Patient values (patientID_seq.nextval,'Roman','Phillips','Worcester','MA','O-','13-Jun-62',110);
insert into Patient values (patientID_seq.nextval,'Daryl','Miller','Waltham','MA','B+','16-Apr-76',115);
insert into Patient values (patientID_seq.nextval,'Darcy','Carroll','Miami','FL','B-','06-Nov-79',120);
insert into Patient values (patientID_seq.nextval,'Kevin','Hamilton','Austin','TX','O-','31-Dec-90',100);
insert into Patient values (patientID_seq.nextval,'Violet','Casey','Houston','TX','AB+','19-Oct-99',105);
insert into Patient values (patientID_seq.nextval,'Richard','Watson','Jersey','NY','B+','29-Aug-05',110);
insert into Patient values (patientID_seq.nextval,'Grace','Foster','Buffalo','NY','B+','10-Aug-87',115);
insert into Patient values (patientID_seq.nextval,'Adam','Tucker','Syracuse','NY','AB-','02-Aug-83',120);
insert into Patient values (patientID_seq.nextval,'Robert','Robinson','Los Angels','CA','B+','09-Jan-89',100);
insert into Patient values (patientID_seq.nextval,'Amber','Sullivan','Los Angels','CA','O+','17-May-68',105);
insert into Patient values (patientID_seq.nextval,'Arnold','Owens','Chula Vista','CA','B-','14-Jul-95',115);
insert into Patient values (patientID_seq.nextval,'Melissa','Casey','Dallas','TX','A+','16-Apr-99',120);
insert into Patient values (patientID_seq.nextval,'Melanie','Perkins','Forth Worth','TX','O+','21-Jun-81',110);
insert into Patient values (patientID_seq.nextval,'Marcus','Murphy','El paso','TX','A-','11-Jun-77',100);
insert into Patient values (patientID_seq.nextval,'Grace','Ferguson','Akron','OH','A-','12-Jun-83',105);
insert into Patient values (patientID_seq.nextval,'Alina','Cooper','Cleveland','OH','A+','19-Jul-80',110);
insert into Patient values (patientID_seq.nextval,'Alissa','Reed','Anchorage','AK','A+','02-Dec-91',115);
insert into Patient values (patientID_seq.nextval,'Elise','Wright','Phoenix','AZ','A-','30-Aug-55',120);
					  

					  
insert into OrganTransplant values (125,100,invoiceNumID_seq.nextval,'1-Sep-19','F',10654.50);
insert into OrganTransplant values (130,105,invoiceNumID_seq.nextval,'1-Sep-19','T',110.5);
insert into OrganTransplant values (135,110,invoiceNumID_seq.nextval,'1-Sep-19','T',1203.90);
insert into OrganTransplant values (140,115,invoiceNumID_seq.nextval,'1-Sep-19','T',13045.4);
insert into OrganTransplant values (145,120,invoiceNumID_seq.nextval,'1-Sep-19','F',1000.3);
insert into OrganTransplant values (125,125,invoiceNumID_seq.nextval,'1-Sep-19','T',100.12);
insert into OrganTransplant values (130,130,invoiceNumID_seq.nextval,'1-Sep-19','T',10033.90);
insert into OrganTransplant values (135,135,invoiceNumID_seq.nextval,'1-Sep-19','T',40000.10);
insert into OrganTransplant values (140,140,invoiceNumID_seq.nextval,'1-Sep-19','T',143534);
insert into OrganTransplant values (145,145,invoiceNumID_seq.nextval,'1-Sep-19','T',1345.4);
insert into OrganTransplant values (125,150,invoiceNumID_seq.nextval,'1-Sep-19','T',10435.90);
insert into OrganTransplant values (135,155,invoiceNumID_seq.nextval,'1-Sep-19','T',14540);
insert into OrganTransplant values (130,160,invoiceNumID_seq.nextval,'1-Sep-19','T',10340);
insert into OrganTransplant values (145,165,invoiceNumID_seq.nextval,'1-Sep-19','T',104350);
insert into OrganTransplant values (140,170,invoiceNumID_seq.nextval,'1-Sep-19','T',10000.09);
insert into OrganTransplant values (125,175,invoiceNumID_seq.nextval,'1-Sep-19','T',1030.04);
insert into OrganTransplant values (135,180,invoiceNumID_seq.nextval,'1-Sep-19','T',10340.90);
insert into OrganTransplant values (125,185,invoiceNumID_seq.nextval,'1-Sep-19','T',1034.23);
insert into OrganTransplant values (145,190,invoiceNumID_seq.nextval,'1-Sep-19','T',12134.45);
insert into OrganTransplant values (130,195,invoiceNumID_seq.nextval,'1-Sep-19','F',1000.345);

select * 
from Doctor D join PCP P
 on D.physicianNum = P.physicianNum;

select * 
from Doctor D join Surgeon S
 on D.physicianNum = S.physicianNum;
 
 select * 
from Doctor D join OP O
 on D.physicianNum = O.physicianNum;
