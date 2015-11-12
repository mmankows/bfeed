#!/bin/bash
perl -MDBIx::Class::Schema::Loader=make_schema_at,dump_to_dir:lib -e 'make_schema_at("BFeed::Model", { debug => 1 }, [ "dbi:mysql:dbname=bfeed_data","root", "" ])'

