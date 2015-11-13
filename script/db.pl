#!/usr/bin/perl
qx(cat script/create_database.sql|mysql -uroot);
qx(perl script/db_to_model.pl);
qx(cat script/sample_data.sql|mysql -uroot);
