drop table azortzuweisung;
drop table ort;
drop table fahrt;

create table ort(
    ortid number(3) constraint pk_ort primary key,
    ortname varchar2(300) not null
);

create table fahrt(
    fahrtid number(5) constraint pk_fahrt primary key,
    fahrtdauer_min number(6) not null
);

create table azortzuweisung(
    fahrtid number(5) references fahrt(fahrtid),
    aort number(5) references ort(ortid),
    zort number(5) references ort(ortid),
    primary key(fahrtid, aort, zort)
);

insert into ort (ortid, ortname) values (1, 'vb');
insert into ort (ortid, ortname) values (2, 'ried');
insert into ort (ortid, ortname) values (3, 'linz');
insert into ort (ortid, ortname) values (4, 'wels');

insert into fahrt (fahrtid, fahrtdauer_min) values (1, 50);
insert into fahrt (fahrtid, fahrtdauer_min) values (2, 30);
insert into fahrt (fahrtid, fahrtdauer_min) values (3, 23);
insert into fahrt (fahrtid, fahrtdauer_min) values (4, 66);

insert into azortzuweisung (fahrtid, aort, zort) values (2, 3, 4);

select ortname from ort natural join azortzuweisung where aort=3 and zort=4;