var http = require("http");
let fs = require("fs");

var file = fs.createWriteStream("image.png");

let options = {
    host: "localhost",
    path: "/MyFile.png",
    port: 3000,
    method: "GET"
}

var req = http.request(options, res => {
    res.pipe(file);
});
req.on("error", e => {console.log("Error: ", e.message)});
req.end();