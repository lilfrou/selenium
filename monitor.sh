echo " "
echo " "
HOSTNAME=`visamane`
#PSQL="/opt/PostgreSQL/9.3/bin/psql"
PORT=5432
HOST="localhost"
DB="postgres
USER="postgres"
echo "Enter the Time in minutes ,For example if you give 10 means script will displayed what are the query is running more than 10 minutes";
read time
echo "------***WHAT ARE THE QUERY IS RUNING MORE THAN $time MINUTES***------"
$PSQL -d $DB -U $USER -p $PORT <<EOF
\pset format wrapped
SELECT pid, now() - query_start as "runtime", usename, datname, state, query
  FROM  pg_stat_activity
  WHERE now() - query_start > '$time minutes'::interval
 ORDER BY runtime DESC;

EOF

echo " "
echo " "
echo " "

echo "------***CHECKING dISK SPACE***------"
        df -h

echo " "
echo " "
echo " "

echo "------***CHECKING RAM USAGE***------"
       free -h

echo " "
echo " "
echo " "
echo "Enter the dead tuble count for example if you give 5000 display the table count how many table having more than 5000 dead tubles in database ";
read count
echo "------***HOW MANY TABLES HAVING MORE THAN $count DEAD TUBLES PARTICULAR DATABASE***------"


$PSQL -d $DB -U $USER -p $PORT <<EOF
\c mhrorpar
select count(*) from pg_stat_all_tables where n_dead_tup > $count;
EOF

echo " "

$PSQL -d $DB -U $USER -p $PORT <<EOF
\c mhroraur
select count(*) from pg_stat_all_tables where n_dead_tup >$count;
EOF

echo " "

$PSQL -d $DB -U $USER -p $PORT <<EOF
\c mhroryav
select count(*) from pg_stat_all_tables where n_dead_tup >$count;
EOF

echo " "

$PSQL -d $DB -U $USER -p $PORT <<EOF
\c mhrorlat
select count(*) from pg_stat_all_tables where n_dead_tup >$count;
EOF

echo " "

$PSQL -d $DB -U $USER -p $PORT <<EOF
\c mhrornan
select count(*) from pg_stat_all_tables where n_dead_tup >$count;
EOF

echo " "

$PSQL -d $DB -U $USER -p $PORT <<EOF
\c mhrornad
select count(*) from pg_stat_all_tables where n_dead_tup >$count;
EOF
