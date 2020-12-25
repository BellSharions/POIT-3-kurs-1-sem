var http = require("http");

function GET_handler(req, res) {
    if (req.url == "/") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(`<h1>Hello World</h1>`);
    }
    else {
        OTHER_handler(req, res);
    }
}

function OTHER_handler(req, res) {
    res.writeHead(405, {"Content-Type" : "text/plain; charset=utf-8"});
    res.end("Неверный метод");
}

var http_handler = function(req, res) {
    switch (req.method) {
        case 'GET' : GET_handler(req, res); break;
        default: OTHER_handler(req, res); break;
    }
};

var server = http.createServer();
 server.listen(3000, function(v) {console.log("server.listen(3000)")})
            .on("error", function(e) {console.log("server.listen(3000): error: ", e.code)})
            .on("request", http_handler);