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
drop sequence invoiceNumber_seq;

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
	organType varchar2(25),
	organBank varchar2(25),
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
	birthDate date,
	bloodType varchar2(25),
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

create table Operation (
	invoiceNumber number,
	operationDate date,
	isSuccessful char(1),
	cost number(9,2),
	physicianID number,
	healthCareID number,
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
