# db connect
wrds <- wrdsconnect(user=user, pass=pass)

# download fama-french + momentum and liquidity factors
# liq <- dbSendQuery(wrds,"select date,ps_vwf from FF.LIQ_PS") %>%
#   fetch(n=-1) %>%
#   mutate(DATE = as.Date(DATE)) %>%
#   filter(PS_VWF != -99) %>%
#   rename(date=DATE,liquidity=PS_VWF)

ff <- dbSendQuery(wrds,"select date as date,mktrf,smb,hml,umd,rf from FF.FACTORS_DAILY") %>%
  fetch(n=-1) %>%
  mutate(date=as.Date(date)) %>%
  filter(!is.na(umd))

# download CRSP facebook returns
# first find FB PERMNO

facebook_header <- dbSendQuery(wrds,"select permno, permco, cusip, htick, htsymbol, hcomnam from CRSP.MSFHDR where hcomnam like 'ALPHABET%'") %>%
  fetch(n=-1)

fb_data <- dbSendQuery(wrds, sprintf("select permno,ret as ret,date as date from CRSP.DSF where PERMNO = %s", facebook_header$PERMNO[2])) %>%
  fetch(n=-1) %>%
  mutate(date = as.Date(date)) %>%
  select(-PERMNO)

# merge data
# ret_data <- ff %>% inner_join(liq) %>% inner_join(fb_data) %>%
ret_data <- ff %>% inner_join(fb_data) %>%
  filter(!is.na(ret)) %>%
  mutate(exret = ret - rf)

# run a reg
model <- lm(formula = exret ~ mktrf + smb + hml + umd, data = ret_data)

capm <- lm(formula = exret ~ mktrf, data = ret_data)

# wow that's strange

# plot price index
ret_data %>% mutate(cumret = cumprod(1+ret)) %>% select(date,cumret) %>% plot(type = 'l')

ret_data %>% mutate(cumret = cumprod(1+smb+rf)) %>% select(date,cumret) %>% plot(type = 'l')

(coefficients(model)[1] + model$residuals + 1) %>% cumprod %>% plot(type='l')
