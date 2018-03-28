#!/bin/bash
c2i_value_remind=2130
c2i_short_amt=3
c2i_long_amt=5

i2c_value_remind=2070
i2c_begin=3
i2c_end=5

cur_ts=`date '+%Y-%m-%d %H:%M:%S'`

temp_cmd="tail -$c2i_short_amt re.re | awk -F\| -v remind=\"$c2i_value_remind\" 'BEGIN{sum=0}{if (\$4>remind) sum+=1}END{print sum}'"
echo $temp_cmd
lian_short=`echo $temp_cmd | /bin/bash`
echo $lian_short

temp_cmd="tail -$c2i_long_amt re.re | awk -F\| -v remind=\"$c2i_value_remind\" 'BEGIN{sum=0}{if (\$4>remind) sum+=1}END{print sum}'"
lian_long=`echo $temp_cmd | /bin/bash`



last_c2i=`tail -1 re.re | awk -F\| '{print $4}'`
last_i2c=`tail -1 re.re | awk -F\| '{print $11}'`


echo $lian_long

#if [ $lian_short -eq $c2i_short_amt ] &&  [ $lian_long -lt $c2i_long_amt ]
if [ $lian_short -eq $c2i_short_amt ]
then
	echo "send c2i sms"
	`python3 /root/btc/wx_monitor/wx.py --content "$cur_ts [XRP搬砖提醒]中国->印尼，比率已经超过$c2i_value_remind,可以开搞！目前比率为$last_c2i"`
fi



tail -$i2c_end re.re | awk -F\| -v remind=$i2c_value_remind -v i2c_begin=$i2c_begin 'BEGIN{sum=0}{if ($11<remind) sum+=1}END{print "sum=",sum}'
tail -$i2c_end re.re | awk -F\| -v remind=$i2c_value_remind -v i2c_begin=$i2c_begin 'BEGIN{sum=0}{if ($11<remind) sum+=1}END{if (sum>i2c_begin) print "1";else print "0"}'

i2c_send=`tail -$i2c_end re.re | awk -F\| -v remind=$i2c_value_remind -v i2c_begin=$i2c_begin 'BEGIN{sum=0}{if ($11<remind) sum+=1}END{if (sum>i2c_begin) print "1";else print "0"}'`
if [ $i2c_send -eq 1 ]
then 
	echo "send i2c sms"
	`python3 /root/btc/wx_monitor/wx.py --content "$cur_ts [XRP搬砖提醒]印尼->中国，比率已经跌破$i2c_value_remind,可以开搞！目前比率为$last_i2c"`
fi
