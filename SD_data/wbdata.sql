create database sustainable_dev;
use sustainable_dev;

#import tables agriculture, education, health, country_info
alter table energy rename column economy to country;
alter table education rename column economy to country;
alter table health rename column economy to country;
alter table sanitation rename column economy to country;

#Create a table combining the latest values (2018 or 2019) of all tables
create table indicators_combined (
select country_info.id as "country", country_info.incomeLevel as "income level", energy.YR2018 as energy, health.YR2019 as health, education.YR2019 as education, sanitation.YR2019 as sanitation
from country_info right join energy on country_info.id=energy.Country
left join health on energy.Country=health.Country
left join education on health.Country=education.Country 
left join sanitation on education.Country=sanitation.Country order by energy.YR2018 desc);

select * from indicators_combined;

#Create a temporary table with min and max values of each column
create temporary table min_max
select min(energy) as min_energy, max(energy) as max_energy, min(health) as min_health, max(health) as max_health, min(education) as min_education, max(education) as max_education, min(sanitation) as min_sanitation, max(sanitation) as max_sanitation
from indicators_combined;

select * from min_max;

#Add min and max values as a new column into the table with all data combined
alter table indicators_combined add column min_energy float;
update indicators_combined set min_energy=(select min_energy from min_max);

alter table indicators_combined add column max_energy float;
update indicators_combined set max_energy=(select max_energy from min_max);

alter table indicators_combined add column min_health float;
update indicators_combined set min_health=(select min_health from min_max);

alter table indicators_combined add column max_health float;
update indicators_combined set max_health=(select max_health from min_max);

alter table indicators_combined add column min_education float;
update indicators_combined set min_education=(select min_education from min_max);

alter table indicators_combined add column max_education float;
update indicators_combined set max_education=(select max_education from min_max);

alter table indicators_combined add column min_sanitation float;
update indicators_combined set min_sanitation=(select min_sanitation from min_max);

alter table indicators_combined add column max_sanitation float;
update indicators_combined set max_sanitation=(select max_sanitation from min_max);

#Create a copy of the table to insert the normalized values
create table norm_values(
select * from indicators_combined);

select * from norm_values;

#update the columns with min-max normalized values
update norm_values set energy=round((energy-min_energy)/(max_energy-min_energy), 2);
update norm_values set health=round((health-min_health)/(max_health-min_health), 2);
update norm_values set education=round((education-min_education)/(max_education-min_education), 2);
update norm_values set sanitation=round((sanitation-min_sanitation)/(max_sanitation-min_sanitation), 2);

#Create a new table with the normalized values
create table comp_indicator (
select country, `income level`, energy, health, education, sanitation from norm_values);

#Add a new cloumn to calculate the composite indicator
alter table comp_indicator add column comp_ind float;

#Composite indicator is calculated as the sum of all indicators
update comp_indicator set comp_ind=(energy+health+education+sanitation);

select * from comp_indicator order by comp_ind;



