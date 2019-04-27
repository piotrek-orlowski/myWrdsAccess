wrds_connect <- function(){
  wrds <<- DBI::dbConnect(odbc::odbc(), "wrds-postgres")
}

wrds_disconnect <- function(){
  DBI::dbDisconnect(wrds)
  }
