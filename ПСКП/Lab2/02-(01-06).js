var http = require("http");
var fs = require("fs");

function GET_handler(req, res) {
    if (req.url == "/html") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("index.html"));
    }
    else if (req.url == "/png") {
        res.writeHead(200, {"Content-Type" : "image/jpeg; charset=utf-8"});
        res.end(fs.readFileSync("pic.png"));
    }
    else if (req.url == "/api/name") {
        res.writeHead(200, {"Content-Type" : "text/plain; charset=utf-8"});
        res.end("Сураго Дмитрий Александрович");
    }
    else if (req.url == "/xmlhttprequest") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("XMLHTTPRequest.html"));
    }
    else if (req.url == "/fetch") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("fetch.html"));
    }
    else if (req.url == "/jquery") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("jquery.html"));
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
 server.listen(5000, function(v) {console.log("server.listen(5000)")})
            .on("error", function(e) {console.log("server.listen(5000): error: ", e.code)})
            .on("request", http_handler);