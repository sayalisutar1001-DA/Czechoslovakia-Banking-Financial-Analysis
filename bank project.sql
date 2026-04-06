create database bank_database;

use bank_database;

show tables;

select * from `account`;
select * from card;
select * from `client`;
select * from disposition;
select * from district;
select * from loan;
select * from `order`;
select * from transactions;


############################ Data Cleaning ############################ 

select * from transactions;

select count(*) from transactions 
where bank = "";

select date_add(`date`, interval 1 year) from transactions;  

update transactions
set `date` = date_add(`date`, interval 1 year);

select distinct year(`date`) from transactions;

select year(`date`), count(*) as total_blank
from transactions
where bank = "" 
group by year(`date`);

-- 2017  bank = "ADB Bank"
select * from transactions 
where bank = "" and year(`date`) = 2017;

update transactions
set bank = "ADB Bank" where bank = "" and year(`date`) = 2017;

-- replacing the null values of bank column for 2018 with 'Southern Bank'

select * from transactions 
where bank = "" and year(`date`) = 2018;

update transactions
set bank = 'Southern Bank' where bank = "" and year(`date`) = 2018;
 

-- replacing the null values of bank column for 2019 with 'Northern Bank'

select * from transactions 
where bank = "" and year(`date`) = 2019;

update transactions
set bank = 'Northern Bank' where bank = "" and year(`date`) = 2019;

-- 2020 

select * from transactions 
where bank = "" and year(`date`) = 2020;

-- replacing the null values of bank column for 2021 with 'DBS Bank'

select * from transactions 
where bank = "" and year(`date`) = 2021;

update transactions
set bank = 'DBS Bank' where bank = "" and year(`date`) = 2021;


-- replacing the null values of bank column for 2022 with 'SKY Bank'

select * from transactions 
where bank = "" and year(`date`) = 2022;


update transactions
set bank = 'SKY Bank' where bank = "" and year(`date`) = 2022;


## check point 

select year(`date`), count(*) as total_blank
from transactions
where bank = "" 
group by year(`date`);

select count(*) from transactions 
where bank = "";


####################### client's  table #################################

select * from `client`;

-- calculate the age of the client till the 2022 

alter table `client`
add column age smallint after Birth_date;

select * from `Client`;

select max(`date`) into @Max_date from transactions;

select @Max_date;

select timestampdiff(year, birth_date,@Max_date) age from `client`;

update `client` 
set age  = timestampdiff(year, birth_date,@Max_date);

select * from `client`;


#################################### Card Table TRANSFORMATION #################################

select * from card;

select distinct year(issued) from card;

/* update card 
set issued = date_add(issued, interval 1 year);  */



###############################################################################################

-- create table czec_demographic_data_kpi as

select 
    d.district_name,
    d.average_salary,
    round(avg(c.age), 0) as avg_age,
    sum(case when sex = 'male' then 1 else 0 end) as male_client,
    sum(case when sex = 'female' then 1 else 0 end) as female_client,
    count(distinct client_id) as total_client,
    round((sum(case when sex = 'female' then 1 else 0 end) /
           sum(case when sex = 'male' then 1 else 0 end)) * 100, 2) 
           as male_female_ratio_perc
from client c
inner join district d 
    on c.district_id = d.district_code
group by d.district_name, d.average_salary;

select * from czec_demographic_data_kpi;


select * from client;
select * from district;


create table demographic_data_kpi as
select 
    d.district_name,
    d.average_salary,
    round(avg(c.age), 2) as avg_age,
    count(distinct c.client_id) as total_client,
    sum(case when sex = 'male' then 1 else 0 end) as male_client,
    sum(case when sex = 'female' then 1 else 0 end) as female_client,
    round((sum(case when sex = 'female' then 1 else 0 end) /
           sum(case when sex = 'male' then 1 else 0 end)) * 100, 2) 
           as male_female_ratio_per
from client c
inner join district d 
    on c.district_id = d.district_code
group by d.district_name, d.average_salary;


select * from demographic_data_kpi;


#####################################


use bank_database;


select * from transactions;


create table acc_latest_txns_with_balance as
select ltd.*, txn.balance
from transactions as txn
inner join 
(
    select 
        account_id,
        year(date) as txn_year,
        month(date) as txn_month,
        max(date) as latest_txn_date
    from transactions
    group by 1,2,3
    order by 1,2,3
) as ltd 
on ltd.account_id = txn.account_id 
and ltd.latest_txn_date = txn.date
order by txn.account_id, ltd.txn_year, ltd.txn_month;


select * from acc_latest_txns_with_balance;


create table banking_kpi as 
select 
    alwb.txn_year,
    alwb.txn_month,
    t.bank,
    a.account_type,
    count(distinct alwb.account_id) as tot_account,
    count(t.trans_id) as tot_txns,
    sum(case when t.type = 'credit' then 1 else 0 end) as deposit_count,
    sum(case when t.type = 'withdrawal' then 1 else 0 end) as withdrawal_count,
    sum(alwb.balance) as tot_balance,
    round((sum(case when t.type = 'credit' then 1 else 0 end) / count(distinct t.trans_id)) * 100, 2) as deposit_perc,
    round((sum(case when t.type = 'withdrawal' then 1 else 0 end) / count(distinct t.trans_id)) * 100, 2) as withdrawal_perc,
    ifnull(sum(alwb.balance) / count(distinct alwb.account_id), 0) as avg_balance,
    round(count(distinct t.trans_id) / count(distinct alwb.account_id), 0) as tpa
from transactions as t
inner join acc_latest_txns_with_balance as alwb 
    on t.account_id = alwb.account_id
left join account as a 
    on t.account_id = a.account_id
group by alwb.txn_year, alwb.txn_month, t.bank, a.account_type
order by alwb.txn_year, alwb.txn_month, t.bank, a.account_type;





