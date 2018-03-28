#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

step1=1000
step2=2000
step3=3000


./node_modules/.bin/babel-node get_xrp_node.js > xrp_cny_buy@china.tmp
#./node_modules/.bin/babel-node get_xrp_node.js.ripple_china > xrp_cny_buy@china.tmp
python3 check_xrp_idr.py > xrp_idr.re.tmp

./node_modules/.bin/babel-node get_xrp_node_sell.js > xrp_cny_sell@china.tmp
#./node_modules/.bin/babel-node get_xrp_node_sell.js.ripple_china > xrp_cny_sell@china.tmp

sort -n -k 1 xrp_cny_buy@china.tmp | awk -v step1=$step1 -v step2=$step2 -v step3=$step3 'BEGIN{acc_amt=0;acc_total=0;flag_step1=0;flag_step2=0;flag_step3=0}{if (flag_step1==0 && $2+acc_amt>step1) {total_step1=(step1-acc_amt)*$1+acc_total;flag_step1=1}if (flag_step2==0 && $2+acc_amt>step2) {total_step2=(step2-acc_amt)*$1+acc_total;flag_step2=1}if (flag_step3==0 && $2+acc_amt>step3) {total_step3=(step3-acc_amt)*$1+acc_total;flag_step3=1} acc_amt+=$2;acc_total+=$1*$2;}END{print total_step1,total_step2,total_step3}' > xrp_cny_buy@china.re


sort -n -k 1 -r xrp_cny_sell@china.tmp | awk -v step1=$step1 -v step2=$step2 -v step3=$step3 'BEGIN{acc_amt=0;acc_total=0;flag_step1=0;flag_step2=0;flag_step3=0}{if (flag_step1==0 && $2+acc_amt>step1) {total_step1=(step1-acc_amt)*$1+acc_total;flag_step1=1}if (flag_step2==0 && $2+acc_amt>step2) {total_step2=(step2-acc_amt)*$1+acc_total;flag_step2=1}if (flag_step3==0 && $2+acc_amt>step3) {total_step3=(step3-acc_amt)*$1+acc_total;flag_step3=1} acc_amt+=$2;acc_total+=$1*$2;}END{print total_step1/step1,total_step2/step2,total_step3/step3}' > xrp_cny_sell@china.re




grep buy xrp_idr.re.tmp | sed 's/buy//g' | sort -n -k 1 -r | awk -v step1=$step1 -v step2=$step2 -v step3=$step3 'BEGIN{acc_amt=0;acc_total=0;flag_step1=0;flag_step2=0;flag_step3=0}{if (flag_step1==0 && $2+acc_amt>step1) {total_step1=(step1-acc_amt)*$1+acc_total;flag_step1=1}if (flag_step2==0 && $2+acc_amt>step2) {total_step2=(step2-acc_amt)*$1+acc_total;flag_step2=1}if (flag_step3==0 && $2+acc_amt>step3) {total_step3=(step3-acc_amt)*$1+acc_total;flag_step3=1} acc_amt+=$2;acc_total+=$1*$2;}END{print total_step1*0.98703,total_step2*0.98703,total_step3*0.98703}' > xrp_idr_sell@indo.re


grep sell xrp_idr.re.tmp | sed 's/sell//g' | sort -n -k 1 | awk -v step1=$step1 -v step2=$step2 -v step3=$step3 'BEGIN{acc_amt=0;acc_total=0;flag_step1=0;flag_step2=0;flag_step3=0}{if (flag_step1==0 && $2+acc_amt>step1) {total_step1=(step1-acc_amt)*$1+acc_total;flag_step1=1}if (flag_step2==0 && $2+acc_amt>step2) {total_step2=(step2-acc_amt)*$1+acc_total;flag_step2=1}if (flag_step3==0 && $2+acc_amt>step3) {total_step3=(step3-acc_amt)*$1+acc_total;flag_step3=1} acc_amt+=$2;acc_total+=$1*$2;}END{print total_step1/step1,total_step2/step2,total_step3/step3}' > xrp_idr_buy@indo.re



echo -n `date '+%Y-%m-%d %H:%M:%S'` >> re.re

echo `cat xrp_cny_buy@china.re xrp_idr_sell@indo.re xrp_idr_buy@indo.re xrp_cny_sell@china.re | tr "\n" " " | awk -v step1=$step1 -v step2=$step2 -v step3=$step3 '{print "|China->Indo|"step1"|"$4/$1"|"step2"|"$5/$2"|"step3"|"$6/$3"|Indo->China|"step1"|"$7/$10/0.991026973"|"step2"|"$8/$11/0.991026973"|"step3"|"$9/$12/0.991026973}'` >> re.re



./check_sms.sh



