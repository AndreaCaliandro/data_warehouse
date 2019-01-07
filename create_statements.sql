CREATE TABLE Customer (
    custno      varchar(8) primary key,
    custname    varchar(50) not null,
    address     varchar(50) not null,
    Internal    char(1) not null,
    contact     varchar(50) not null,
    phone       char(7) not null,
    city        varchar(50) not null,
    state       char(2) not null,
    zip         char(10) not null
);

CREATE TABLE Facility (
    facno       varchar(8) primary key,
    facname     varchar(50) not null,
    CONSTRAINT UNIfacname UNIQUE (facname)
);

CREATE TABLE Location (
    locno       varchar(8) primary key,
    facno       varchar(8) not null,
    locname     varchar(50) not null,
    FOREIGN KEY (facno) REFERENCES Facility(facno)
);

CREATE TABLE EventRequest (
    eventno     varchar(8) primary key,
    dateheld    date not null,
    datereq     date not null,
    facno       varchar(8) not null,
    custno      varchar(8) not null,
    dateauth    date,
    status      varchar(50) not null,
    estcost     float not null,
    estaudience integer not null,
    budno       varchar(8),
    FOREIGN KEY (facno) REFERENCES Facility(facno),
    FOREIGN KEY (custno) REFERENCES Customer(custno),
    CHECK (status IN ('Pending', 'Denied', 'Approved')),
    CHECK (estaudience > 0)
);

CREATE TABLE Employee(
    empno       varchar(8) primary key,
    empname     varchar(50) not null,
    department  varchar(50) not null,
    email       varchar(50) not null,
    phone       varchar(50) not null
);

CREATE TABLE EventPlan (
    planno      varchar(8) primary key,
    eventno     varchar(8)  not null,
    workdate    date not null,
    notes       varchar(255),
    activity    varchar(50) not null,
    empno       varchar(8),
    FOREIGN KEY (eventno) REFERENCES EventRequest(eventno),
    FOREIGN KEY (empno) REFERENCES Employee(empno)
);

CREATE TABLE ResourceTbl (
    resno       varchar(8) primary key,
    resname     varchar(50) not null,
    rate        float not null,
    CHECK (rate > 0)
);

CREATE TABLE EventPlanLine (
    PlanNo varchar(8) not null,
    LineNo varchar(8) not null,
    TimeStart datetime not null,
    TimeEnd datetime not null,
    NumberFld integer not null,
    LocNo varchar(8) not null,
    ResNo varchar(8) not null,
    CONSTRAINT PK_EventPlanLine PRIMARY KEY (PlanNo, LineNo),
    CHECK (TimeStart < TimeEnd),
    FOREIGN KEY (PlanNo) REFERENCES EventPlan(planno),
    FOREIGN KEY (LocNo) REFERENCES Location(locno),
    FOREIGN KEY (ResNo) REFERENCES ResourceTbl(resno)
);