require("dotenv").config();
const axios = require("axios").default();

const txHash = "0x0000000000000000000";
axios({
    method: "get",
    url: `https://api.polygonscan.com/api?module=transaction&action=gettxreceiptstatus&txhash=${txHash}&apikey=${process.env.POLYGONSCAN_API_KEY}`,
    responseType: "json",
}).then(function (response) {
    if (response.data.message = "OK") {
        console.log(
            `The transaction receipt status of ${txHash} is ${response.data.result.status == 1 ? `success` : `fail`}`
        );
    }
});