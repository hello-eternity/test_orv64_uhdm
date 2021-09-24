drop database regression;
create database if not exists regression;

use regression;


-- global

create table if not exists regr_runs (
  run_id      varchar(100)   not null,
  regr_id     varchar(100)   not null,
  block_name  varchar(100)   not null,
  build_id    varchar(500)   not null,
  run_type    varchar(20)    not null,
  primary key (run_id)
);

create table if not exists regr (
  regr_id     varchar(100)   not null,
  primary key (regr_id)
);

create table if not exists builds (
  build_id    varchar(500)   not null,
  primary key (build_id)
);


-- for coverage

create table if not exists cov_runs (
  run_id      varchar(100)   not null,
  inst_hier   varchar(500)   not null,
  line_index  int            not null,
  file_name   varchar(500)   not null,
  line_num    int            not null,
  module_name varchar(100)   not null,
  cov_value   varchar(100)   not null,
  line_ignore int            not null,
  line_type   int            not null,
  line_group  int            not null,
  primary key (run_id, inst_hier, line_index, file_name, line_num)
);


-- for synthesis

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
  ended_at     TIMESTAMP,
  primary key (run_id)
);

-- for rtl_power

create table if not exists rtl_power_runs (
  run_id           varchar(100)   not null,
  total_leakage    float,
  total_internal   float,
  total_switching  float,
  total_total      float,
  comb_leakage     float,
  comb_internal    float,
  comb_switching   float,
  comb_total       float,
  seq_leakage      float,
  seq_internal     float,
  seq_switching    float,
  seq_total        float,
  bb_leakage       float,
  bb_internal      float,
  bb_switching     float,
  bb_total         float,
  mem_leakage      float,
  mem_internal     float,
  mem_switching    float,
  mem_total        float,
  io_leakage       float,
  io_internal      float,
  io_switching     float,
  io_total         float,
  clock_leakage    float,
  clock_internal   float,
  clock_switching  float,
  clock_total      float,
  ended_at         TIMESTAMP,
  primary key (run_id)
);


-- foreign keys

alter table regr_runs add foreign key (regr_id) references regr(regr_id);
alter table regr_runs add foreign key (build_id) references builds(build_id);

alter table synth_runs add foreign key (run_id) references regr_runs(run_id);

alter table cov_runs add foreign key (run_id) references regr_runs(run_id);


