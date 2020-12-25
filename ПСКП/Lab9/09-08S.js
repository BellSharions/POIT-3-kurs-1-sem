var http = require("http");
var mp = require("multiparty");
var fs = require("fs");

function GET_handler(req, res) {
    if (req.url = "/MyFile.png") {
        res.end(fs.readFileSync("MyFile.png"));
    }
    else OTHER_handler(req, res);
}

function OTHER_handler(req, res) {
    res.writeHead(405, {"Content-Type" : "text/plain; charset=utf-8"});
    res.end("Неверный метод");
}

var http_handler = function(req, res) {
    switch (req.method) {
        case 'GET' : GET_handler(req, res); break;
        case 'POST' : POST_handler(req, res); break;
        default: OTHER_handler(req, res); break;
    }
};

var server = http.createServer();
 server.listen(3000, function(v) {console.log("server.listen(3000)")})
            .on("error", function(e) {console.log("server.listen(3000): error: ", e.code)})
            .on("request", http_handler);