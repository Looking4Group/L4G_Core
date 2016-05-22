SET(trinitydatabase_STAT_SRCS
   Database.cpp
   Database.h
   DatabaseEnv.h
   DatabaseImpl.h
   Field.cpp
   Field.h
   QueryResult.cpp
   QueryResult.h
   QueryResult.cpp
   QueryResultMysql.cpp
   QueryResultMysql.h
   DatabaseMysql.h
   DatabaseMysql.cpp
   SQLStorage.cpp
   SQLStorage.h
   SQLStorageImpl.h
   SqlPreparedStatement.cpp
   SqlPreparedStatement.h
   SqlDelayThread.cpp
   SqlDelayThread.h
   SqlOperations.cpp
   SqlOperations.h
   dbcfile.cpp
   dbcfile.h
)

add_library(trinitydatabase STATIC ${trinitydatabase_STAT_SRCS})
