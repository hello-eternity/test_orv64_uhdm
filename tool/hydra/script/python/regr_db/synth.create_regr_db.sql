drop database regression;
create database if not exists regression;

use regression;

create table if not exists regr (
  regr_id     varchar(100)   not null,
  primary key (regr_id)
);

create table if not exists regr_runs (
  run_id      varchar(100)   not null,
  regr_id     varchar(100)   not null,
  block_name  varchar(100)   not null,
  build_id    varchar(500)   not null,
  run_type    varchar(20)    not null,
  primary key (run_id)
);

create table if not exists builds (
  build_id    varchar(500)   not null,
  primary key (build_id)
);

-- create table if not exists rtl_checksums (
--   build_id    int            not null,
--   file_name   varchar(500)   not null,
--   checksum    char(32)       not null,
--   primary key (build_id, file_name, checksum)
-- );

create table if not exists synth_runs (
  run_id       varchar(100)   not null,
  total_area   float,
  cell_area    float,
  comb_area    float,
  buf_area     float,
  noncomb_area float,
  macro_area   float,
  net_area     float,
  port_count   int,
  net_count    int,
  cell_count   int,
  comb_count   int,
  seq_count    int,
  macro_count  int,
  buf_count    int,
  ref_count    int,
  freq         float,
  setup_wns    float,
  setup_tns    float,
  setup_count  int,
  hold_wns     float,
  hold_tns     float,
  hold_count   int,
  primary key (run_id)
);

alter table regr_runs add foreign key (regr_id)  references regr(regr_id);
alter table regr_runs add foreign key (build_id) references builds(build_id);

--alter table rtl_checksums add foreign key (build_id) references build(build_id);

alter table synth_runs add foreign key (run_id) references regr_runs(run_id);

