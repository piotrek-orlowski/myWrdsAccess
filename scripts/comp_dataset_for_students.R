# This downloads compustat data for the students

wrds <- wrdsconnect(user=user, pass=pass)

comp <- dbSendQuery(conn = wrds
                    , statement = "select gvkey, datadate, fyear, at, ceq, che, dltt, dvt, csho, prcc_f from COMP.FUNDA where datadate < 20011231")

comp <- fetch(comp, n = -1)

library(dplyr)

comp <- comp %>% mutate(datadate = as.Date(datadate)) %>% mutate(datadate = format(datadate,"%Y%m%d"))
