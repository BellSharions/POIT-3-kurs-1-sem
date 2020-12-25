var http = require("http");
var query = require("querystring");

let parms = query.stringify({x:22, y:8, s:"HELLO"});

let options = {
    host: "localhost",
    path: "/",
    port: 3000,
    method: "POST"
}

const req = http.request(options, res => {
    console.log(`${res.statusCode}: ${res.statusMessage}`);
    let data = "";
    res.on("data", chunk => {
        data += chunk.toString("utf8");
    });
    res.on("end", () => {
        console.log(`\n${data}`);
    });
});

req.on("error", e => {console.log("Error: ", e.message)});

req.write(parms);

req.end();