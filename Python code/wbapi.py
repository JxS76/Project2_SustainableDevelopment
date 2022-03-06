#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar  4 11:54:25 2022

@author: ildem
"""

#%%
import pandas as pd
import matplotlib.pyplot as plt
import wbgapi as wb

wb.series.info()
wb.region.info()
wb.economy.info()
wb.source.info()

#get wb.economy.info as a data frame
income_levels=wb.economy.DataFrame()
print(income_levels)
country_info=income_levels.filter(items=['id', 'name', 'region', 'incomeLevel'])
print(country_info)
country_info.to_csv('~/Desktop/new_data/country_info.csv')


#look for a dataset related to education
wb.series.info(q="education")

#NY.ADJ.AEDU.GN.ZS     Adjusted savings: education expenditure (% of GNI)
education=wb.data.DataFrame('NY.ADJ.AEDU.GN.ZS',['FRA','USA','BRA', 'CHN', 'NGA'] , time=('2010', '2015', '2019'))
print(education)


normalized_education=(education-education.min())/(education.max()-education.min())
print(normalized_education)

(normalized_education.round(2)).to_csv('~/Desktop/new_data/education.csv')



#look for a dataset related to health
wb.series.info(q="health")

#SH.XPD.CHEX.GD.ZS  Current health expenditure (% of GDP)
health=wb.data.DataFrame('SH.XPD.CHEX.GD.ZS',['FRA','USA','BRA', 'CHN', 'NGA'] , time=('2010', '2015', '2019'))
print(health)

#normalize data using min-max normalization
normalized_health=(health-health.min())/(health.max()-health.min())
print(normalized_health)

(normalized_health.round(2)).to_csv('~/Desktop/new_data/health.csv')


#look for a dataset related to renewable energy
wb.series.info(q="energy")

#EG.FEC.RNEW.ZS        Renewable energy consumption (% of total final energy consumption)
energy=wb.data.DataFrame('EG.FEC.RNEW.ZS',['FRA','USA','BRA', 'CHN', 'NGA'] , time=('2010', '2015', '2018'))
print(energy)

#normalize data using min-max normalization
normalized_energy=(energy-energy.min())/(energy.max()-energy.min())
print(normalized_energy)
(normalized_energy.round(2)).to_csv('~/Desktop/new_data/energy.csv')


#look for a dataset related to sanitation
wb.series.info(q="sanitation")

#SH.STA.SMSS.ZS     People using safely managed sanitation services (% of population)
sanitation=wb.data.DataFrame('SH.STA.SMSS.ZS',['FRA','USA','BRA', 'CHN', 'NGA'] , time=('2010', '2015', '2019'))
print(sanitation)

#normalize data using min-max normalization
normalized_sanitation=(sanitation-sanitation.min())/(sanitation.max()-sanitation.min())
print(normalized_sanitation)

(sanitation.round(2)).to_csv('~/Desktop/new_data/sanitation.csv')


