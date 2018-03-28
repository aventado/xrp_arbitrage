'use strict';
const RippleAPI = require('ripple-lib').RippleAPI;

const api = new RippleAPI({
    server: 'wss://s1.ripple.com' // Public rippled server
});

//console.log("1")

api.connect().then(() =>{
    //console.log("11")
    const address = 'razqQKzJRdB4UxFPWf5NEpEG3WMkmwgcXA';
    const orderbook = {
        "base": {
            "currency": "XRP"
            

        },
        "counter": {
            "currency": "CNY",
            "counterparty": "razqQKzJRdB4UxFPWf5NEpEG3WMkmwgcXA"
        }
    };
    //console.log("111")

    return api.getOrderbook(address, orderbook).then(orderbook =>{
        //console.log("1111")
        var order_book={}
        for (var con in orderbook.bids)
        {
            var buy_price=parseFloat(orderbook.bids[con].properties.makerExchangeRate)
            var vol=parseFloat(orderbook.bids[con].specification.totalPrice.value)
            //console.log(buy_price)
	   				buy_price = 1 / buy_price
            //console.log(buy_price," ",vol)
            //console.log(vol)
            //console.log()
            if (isNaN(order_book[Math.ceil(buy_price*1000)/1000]))
            {
                order_book[Math.ceil(buy_price*1000)/1000]=vol
            }
            else
            {
                order_book[Math.ceil(buy_price*1000)/1000]+=vol
            }
        }


        for (var con in order_book)
        {


            //console.log(con," ",order_book[con]," ",order_book[con]/con)
            console.log(con," ",order_book[con]/con)
            //console.log(order_book[con])
            //console.log()


        }






    }).then(() =>{
        return api.disconnect();
    }).catch(console.error);

}).then(info =>{

    //console.log(info);
    //console.log('getAccountInfo done');

/* end custom code -------------------------------------- */
}).then(() =>{
    return api.disconnect();
}).then(() =>{
    //console.log('done and disconnected.');
}).catch(console.error);








