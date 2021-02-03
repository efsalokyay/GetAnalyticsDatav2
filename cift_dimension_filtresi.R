library(googleAuthR)
library(googleAnalyticsR)

options(
  googleAuthR.scopes.selected = c('https://www.googleapis.com/auth/analytics.readonly')
)

gar_auth_service('C:\Users\user\Desktop\\ilab-izin.json',
                 scope = getOption('googleAuthR.scopes.selected'))

source_filter <- dim_filter(dimension="source",operator="EXACT",expressions="google", caseSensitive = FALSE, not = FALSE)
device_filter <- dim_filter("deviceCategory","REGEXP","desktop|tablet",  FALSE , FALSE)

my_filter <- filter_clause_ga4(list(source_filter,device_filter), operator = "AND")


ga_data <- google_analytics(
  "123456",                                      
  date_range = c(Sys.Date() - 1, Sys.Date() - 1), 
  metrics = 'sessions',                          
  dimensions = c('medium','deviceCategory'),
  dim_filters = my_filter,
  max = -1,                                       
  anti_sample = TRUE,                             
  anti_sample_batch = 3                           
)