#!/bin/bash

cat scallop.stats | grep flux_refgtf3_150M_75r_500f > simu-gtf3-75r-500f-scallop
cat scallop.stats | grep flux_refgtf3_150M_75r_300f > simu-gtf3-75r-300f-scallop

cat scallop.stats | grep flux_refgtf3_150M_100r_500f > simu-gtf3-100r-500f-scallop
cat scallop.stats | grep flux_refgtf3_150M_100r_300f > simu-gtf3-100r-300f-scallop

cat scallop.stats | grep flux_refgtf0_150M_75r_500f > simu-gtf0-75r-500f-scallop
cat scallop.stats | grep flux_refgtf0_150M_75r_300f > simu-gtf0-75r-300f-scallop

cat scallop.stats | grep flux_refgtf0_150M_100r_500f > simu-gtf0-100r-500f-scallop
cat scallop.stats | grep flux_refgtf0_150M_100r_300f > simu-gtf0-100r-300f-scallop


cat stringtie.stats | grep flux_refgtf3_150M_75r_500f > simu-gtf3-75r-500f-stringtie
cat stringtie.stats | grep flux_refgtf3_150M_75r_300f > simu-gtf3-75r-300f-stringtie

cat stringtie.stats | grep flux_refgtf3_150M_100r_500f > simu-gtf3-100r-500f-stringtie
cat stringtie.stats | grep flux_refgtf3_150M_100r_300f > simu-gtf3-100r-300f-stringtie

cat stringtie.stats | grep flux_refgtf0_150M_75r_500f > simu-gtf0-75r-500f-stringtie
cat stringtie.stats | grep flux_refgtf0_150M_75r_300f > simu-gtf0-75r-300f-stringtie

cat stringtie.stats | grep flux_refgtf0_150M_100r_500f > simu-gtf0-100r-500f-stringtie
cat stringtie.stats | grep flux_refgtf0_150M_100r_300f > simu-gtf0-100r-300f-stringtie

