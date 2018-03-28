import requests
import argparse
import time



import logging

logger = logging.getLogger('main')
logger.setLevel(logging.INFO)
logfile = "send_sms.log"
rotateHandler = logging.FileHandler(logfile)
formatter = logging.Formatter("%(asctime)s - %(filename)s[line:%(lineno)d] - %(levelname)s: %(message)s")
rotateHandler.setFormatter(formatter)
logger.addHandler(rotateHandler)

logger.info("begin to send....")


parser=argparse.ArgumentParser()

parser.add_argument('--content',required=True,help='sms content')
parser.add_argument('--hp_no',default='XXXXXX',help='hp no')

args=parser.parse_args()
logger.info("args are:{0}".format(args))


sms_content=args.content
hp_no=args.hp_no

sessions = requests.session()

url = 'http://api.clickatell.com/http/sendmsg?user=XXXXX&password=XXXXX&api_id=XXXXX&to='+str(hp_no)+'&text='+sms_content
logger.info("url used to send is {0}".format(url))

pro_res = sessions.get(url)

logger.info("sent finished!result is {0}".format(pro_res.content))
logger.info("quit!")
logger.info("")




