library(googleAuthR)
library(googleAnalyticsR)

options(
  googleAuthR.scopes.selected = c('https://www.googleapis.com/auth/analytics.readonly')
)

gar_auth_service('C:\Users\user\Desktop\\ilab-izin.json',
                 scope = getOption('googleAuthR.scopes.selected'))

user_filter<- met_filter(metric = "users", operator = "GREATER_THAN", comparisonValue =  350, not = FALSE)

my_filter <- filter_clause_ga4(list(user_filter))


ga_data <- google_analytics(
  "123456",                                      
  date_range = c(Sys.Date() - 1, Sys.Date() - 1), 
  metrics = 'users',                          
  dimensions = 'mobileDeviceInfo',
  met_filters = my_filter,
  max = -1,                                       
  anti_sample = TRUE,                             
  anti_sample_batch = 3                           
)