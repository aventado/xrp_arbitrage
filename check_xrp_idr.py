# encoding: UTF-8
import re
import requests
import json
import os
import time
import traceback
import hashlib
import hmac
import urllib
import urllib.parse
import urllib.request
import numpy as np
import pandas as pd
import datetime
from dateutil.relativedelta import relativedelta


import logging

from logging.handlers import RotatingFileHandler

logger = logging.getLogger('main')
logger.setLevel(logging.INFO)
main_log_handler = logging.FileHandler("check_xrp_idr.log", mode="w")
main_log_handler.setLevel(logging.DEBUG)
formatter = logging.Formatter("%(asctime)s - %(filename)s[line:%(lineno)d] - %(levelname)s: %(message)s")
main_log_handler.setFormatter(formatter)
logger.addHandler(main_log_handler)


def http_get_request(url, params, add_to_headers=None):

    try:
        headers = {
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            "Accept-Encoding": "gzip, deflate",
            "Accept-Language": "zh-CN,zh;q=0.8,en;q=0.6,ja;q=0.4,id;q=0.2,zh-TW;q=0.2",
            "Cache-Control": "max-age=0",
            "Connection": "keep-alive",
            "Upgrade-Insecure-Requests": "1",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.78 Safari/537.36"
        }
        if add_to_headers:
            headers.update(add_to_headers)
        postdata = urllib.parse.urlencode(params)
        response = requests.get(url, postdata, headers=headers, timeout=10)

        time.sleep(0.2)

        if response.status_code == 200:
            # print("ok")
            return response.json()
        else:
            raise Exception("httpGet failed, detail is:%s" % response.text)
    except:
        logger.error(traceback.format_exc())


def get_depth_xrp_idr_buy():
    try:
        params = ""
        url = "https://vip.bitcoin.co.id/api/xrp_idr/depth"

        temp_retun = http_get_request(url, params)

        # btc_idr的买入价格depth-----bid
        btc_idr_market_buy = dict()
        btc_idr_market_buy = temp_retun.get("buy")

        return btc_idr_market_buy

    except:
        logger.error(traceback.format_exc())

def get_depth_xrp_idr_sell():
    try:
        params = ""
        url = "https://vip.bitcoin.co.id/api/xrp_idr/depth"

        temp_retun = http_get_request(url, params)

        # btc_idr的买入价格depth-----bid
        btc_idr_market_buy = dict()
        btc_idr_market_buy = temp_retun.get("sell")

        return btc_idr_market_buy

    except:
        logger.error(traceback.format_exc())

if __name__ == "__main__":
    depth = get_depth_xrp_idr_buy()
    for i in range(len(depth)):
        print("buy",depth[i][0],depth[i][1])

    depth = get_depth_xrp_idr_sell()
    for i in range(len(depth)):
        print("sell",depth[i][0],depth[i][1])










