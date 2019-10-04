
drop sequence physicianID_seq;
drop sequence healthCareID_seq;
drop sequence invoiceNumber_seq;



create sequence physicianID_seq
start with 37000
increment by 10;

create sequence healthCareID_seq
start with 37000
increment by 10;

create sequence invoiceNumber_seq 
start with 37000
increment by 10;


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

insert into PCP values(37000, 'PCP', 'Family Medicine', 'Reliant Medical');
insert into PCP values(37010, 'PCP', 'Internal Medicine', 'Cape Code Medical');
insert into PCP values(37020, 'PCP', 'Pediatrics', 'Tufts Medical');
insert into PCP values(37030, 'PCP', 'Geriatrics', 'Boston Medical');
insert into PCP values(37040, 'PCP', 'Pediatrics', 'Boston Medical');

insert into Surgeon values(37050, 'Surgeon', 'Y');
insert into Surgeon values(37060, 'Surgeon', 'N');
insert into Surgeon values(37070, 'Surgeon', 'Y');
insert into Surgeon values(37080, 'Surgeon', 'N');
insert into Surgeon values(37090, 'Surgeon', 'Y');

insert into OP values(37100, 'OP', 'Kidney', 'Kidney Foundation');
insert into OP values(37110, 'OP', 'Heart', 'The Living Bank');
insert into OP values(37120, 'OP', 'Lungs', 'Donate Life America');

insert into Patient values (healthCareID_seq.nextval,'Carl','Stein','Boston','MA','14-May-75','A',37000);
insert into Patient values (healthCareID_seq.nextval,'James','Lloyd','Cambridge','MA','14-May-89','A',37010);
insert into Patient values (healthCareID_seq.nextval,'Roman','Phillips','Worcester','MA','13-Jun-62','A',37020);
insert into Patient values (healthCareID_seq.nextval,'Daryl','Miller','Waltham','MA','16-Apr-76','A',37030);
	insert into Patient values (healthCareID_seq.nextval,'Darcy','Carroll','Miami','FL','06-Nov-79','A',37040);
	insert into Patient values (healthCareID_seq.nextval,'Kevin','Hamilton','Austin','TX','31-Dec-90','B',37000);
	insert into Patient values (healthCareID_seq.nextval,'Violet','Casey','Houston','TX','19-Oct-99','B',37010);
	insert into Patient values (healthCareID_seq.nextval,'Richard','Watson','Jersey','NY','29-Aug-05','B',37020);
	insert into Patient values (healthCareID_seq.nextval,'Grace','Foster','Buffalo','NY','10-Aug-87','B',37030);
	insert into Patient values (healthCareID_seq.nextval,'Adam','Tucker','Syracuse','NY','02-Aug-83','B',37040);
	insert into Patient values (healthCareID_seq.nextval,'Robert','Robinson','Los Angeles','CA','09-Jan-89','AB',37000);
	insert into Patient values (healthCareID_seq.nextval,'Amber','Sullivan','Los Angeles','CA','17-May-68','AB',37010);
	insert into Patient values (healthCareID_seq.nextval,'Arnold','Owens','Chula Vista','CA','14-Jul-95','AB',37020);
	insert into Patient values (healthCareID_seq.nextval,'Melissa','Casey','Dallas','TX','16-Apr-99','AB',37030);
	insert into Patient values (healthCareID_seq.nextval,'Melanie','Perkins','Forth Worth','TX','21-Jun-81','AB',37020);
	insert into Patient values (healthCareID_seq.nextval,'Marcus','Murphy','El Paso','TX','11-Jun-77','O',37000);
	insert into Patient values (healthCareID_seq.nextval,'Grace','Ferguson','Akron','OH','12-Jun-83','O',37010);
	insert into Patient values (healthCareID_seq.nextval,'Alina','Cooper','Cleveland','OH','19-Jul-80','O',37020);
	insert into Patient values (healthCareID_seq.nextval,'Alissa','Reed','Anchorage','AK','02-Dec-91','O',37030);
	insert into Patient values (healthCareID_seq.nextval,'Elise','Wright','Phoenix','AZ','30-Aug-55','O',37040);



	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',10654.50,37050,37000);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',110.5,37060,37010);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',1203.90,37070,37020);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',13045.4,37080,37030);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','N',1000.30,37090,37040);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',100.12,37050,37050);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',10033.90,37060,37060);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',40000.10,37070,37070);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',143534,37080,37080);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',1345.4,37090,37090);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',10435.90,37050,37100);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',14540,37060,37110);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',10340,37070,37120);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',104350,37090,37130);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',10000.09,37080,37140);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',1030.04,37050,37150);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',10340.90,37060,37160);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',1034.23,37050,37170);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','Y',12134.45,37080,37180);
	insert into Operation values (invoiceNumber_seq.nextval,'1-Sep-19','N',1000.345,37060,37190);



	insert into Organ values (1,37100,'O','3-Oct-18',37000);
	insert into Organ values (2,37100,'A','3-Oct-17',37010);
	insert into Organ values (3,37110,'B','3-Oct-18',37020);
	insert into Organ values (4,37120,'AB','3-Oct-16',37030);
	insert into Organ values (5,37100,'O','3-Oct-18',37040);
	insert into Organ values (6,37110,'A','3-Oct-18',37050);
	insert into Organ values (7,37120,'B','3-Oct-12',37060);
	insert into Organ values (8,37100,'AB','3-Oct-18',37070);
	insert into Organ values (9,37110,'O','3-Oct-18',37080);
	insert into Organ values (10,37120,'A','3-Oct-18',37090);
	insert into Organ values (11,37100,'B','3-Oct-13',37100);
	insert into Organ values (12,37110,'AB','3-Oct-18',37110);
	insert into Organ values (13,37120,'O','3-Oct-18',37120);
	insert into Organ values (14,37120,'A','3-Oct-18',37130);
	insert into Organ values (15,37110,'B','3-Oct-18',37140);
	insert into Organ values (16,37100,'AB','3-Oct-18',37150);
	insert into Organ values (17,37120,'O','3-Oct-18',37160);
	insert into Organ values (18,37100,'A','3-Oct-18',37170);
	insert into Organ values (19,37110,'B','3-Oct-18',37180);
	insert into Organ values (20,37110,'AB','3-Oct-18',37190);

	insert into SurgeonPatient values(37050, 37050);
	insert into SurgeonPatient values(37060, 37060);
	insert into SurgeonPatient values(37070, 37070);
	insert into SurgeonPatient values(37080, 37080);
	insert into SurgeonPatient values(37090, 37090);

