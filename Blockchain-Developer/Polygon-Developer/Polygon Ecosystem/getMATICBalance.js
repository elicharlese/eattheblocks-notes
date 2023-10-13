require("dotenv").config();
const axios = require("axios").default();
const BN = require("bignumber.js");

const eoa = "0x000000000000000000000000";
axios({
    method: "get",
    url: `https://api.polygonscan.com/api?module=account&action=balance&address=${eoa}&tag=latest`,
    responseType: "json",
}).then(function (response) {
    if (response.data.message == "OK") {
        const balanceInMATIC = new BN(response.data.result).div(new BN(10).pow(new BN(18)));
        console.log(`The balance of ${eoa} is ${balanceInMATIC} MATIC`)
    }
});