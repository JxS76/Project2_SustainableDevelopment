create database SD;
use SD; 
#import tables agriculture, education, health, country_info
alter table energy rename column economy to Country;
alter table education rename column economy to Country;
alter table health rename column economy to Country;
alter table sanitation rename column economy to Country;

#Compare the education expenditure over the years 
select education.*, country_info.incomeLevel
from education left join country_info on education.Country=country_info.id;

#Compare the education and health expenditure in 2019 
select country_info.id, country_info.region, country_info.incomeLevel, education.YR2019 as education, health.YR2019 as health  
from education left join health on education.Country=health.Country
left join country_info on education.Country=country_info.id;

##Compare the renewable energy consumption over the years
select energy.*, country_info.region
from energy left join country_info on energy.Country=country_info.id order by energy.YR2018 desc;

#Create a table combining the latest values (2018 or 2019) for all tables
create table combined (
select energy.Country, energy.YR2018 as energy, health.YR2019 as health, education.YR2019 as education, sanitation.YR2019 as sanitation
from energy  left join health on energy.Country=health.Country
left join education on health.Country=education.Country 
left join sanitation on education.Country=sanitation.Country order by energy.YR2018 desc);

select * from combined;

select Country, (energy + health +education + sanitation) as composite_indicator from combined group by Country;