get_wrds_dbnames <- function(){
  res <- DBI::dbSendQuery(wrds, "select distinct table_schema
                   from information_schema.tables
                   where table_type ='VIEW'
                   or table_type ='FOREIGN TABLE'
                   order by table_schema"
                          )
  data <- DBI::dbFetch(res, n = -1)
  data
}

get_wrds_table_names <- function(db_name){
  res <- DBI::dbSendQuery(wrds, sprintf("select distinct table_name
                          from information_schema.columns
                          where table_schema='%s'
                          order by table_name", db_name))
  data <- DBI::dbFetch(res, n = -1)
  data
}

get_wrds_colnames <- function(db_name, table_name){
  res <- DBI::dbSendQuery(wrds, sprintf("select distinct column_name from information_schema.columns where table_schema='%s' and table_name='%s'", db_name, table_name))
  data <- DBI::dbFetch(res, n = -1)
  data
}
