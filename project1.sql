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
	amountCharged number,
	constraint OrganTransplant_pk primary key (physicianNum, patientID, invoiceNum),
	constraint OrganTransplant_fk1 foreign key (physicianNum) references Surgeon (physicianNum),
	constraint OrganTransplant_fk2 foreign key (patientID) references Patient (patientID)
);


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
insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Maryjane', 'Clay');
insert into Doctor values(physicianNum_seq.nextval, 'Surgeon', 'Eric', 'Weiss');

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

select * 
from Doctor D join PCP P
 on D.physicianNum = P.physicianNum;

select * 
from Doctor D join Surgeon S
 on D.physicianNum = S.physicianNum;
 
 select * 
from Doctor D join OP O
 on D.physicianNum = OP.physicianNum;
