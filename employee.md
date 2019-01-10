```
CREATE TABLE ResourceTbl (
    resno       varchar(8) primary key,
    resname     varchar(50) not null,
    rate        float not null,
    CHECK (rate > 0)
);
```

![screenshot](./employee.png)