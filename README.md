# xrp_arbitrage
the auto scan of arbitrage of XRP(ripple,cryptocurrency) between two exchanges 自动检测XRP价差的套利程序


*********说明*********
可以自动检测两个交易对XRP-CNY，XRP-IDR之间是否存在价差，如果超过指定的价差，则发短信或者调用微信(wechat)借口下发提醒
can auto scan the gap between XRP-CNY and XRP-IDR in two exchanges, if exceeds, then invoke API of Wechat or send sms to remind


*********文件说明*********
1) exe_get.sh
自动检测的主程序，里面会使用node.js和python调用2个文件，检测XRP-CNY和XRP-IDR的价差
the main process to auto scan, it will invoke other 2 files, to check the gap between XRP-CNY and XRP-IDR

2) get_xrp_node_sell.ripple_china.js
使用node.js获取ripple中国（交易所）的XRP-CNY的卖单报价
using node.js to acquire XRP-CNY ask order in ripple china(exchanges)

3) get_xrp_node.ripple_china.js
使用node.js获取ripple中国（交易所）的XRP-CNY的买单报价
using node.js to acquire XRP-CNY bid order in ripple china(exchanges)

4) check_xrp_idr.py
使用python获取印尼交易所的XRP-IDR的卖单和买单报价
using python to acquire XRP-IDR bid/ask order in Indo exchanges

5) check_sms.sh
提醒器，如果价差大于指定值，则发短信或者调用微信(wechat)借口下发提醒
reminder, if exceeds the limit assigned, then invoke API of Wechat or send sms to remind

6) package.json
安装node.js的指定包，用于调用ripple的API

7) send_sms.py
发短信的API文件
the API file for sending SMS


*********备注***********
1）需要安装node.js和ripple指定的API依赖包
2）wechat微信的API文件在另外的repository里面









