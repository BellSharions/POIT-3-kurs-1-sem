var http = require("http");
var fs = require("fs");
var url = require("url");

function factorial(n) {
    return (n > 1) ? n * factorial(n - 1) : 1;
  }

var calc = (result) => {process.nextTick(() => result)}

function GET_handler(req, res) {
    if (String(req.url).substr(0,5) == "/fact") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        let result;
        let q = url.parse(req.url, true).query;
        for(key in q) {
            result = q[key];
        }
        if(result != null)
            calc(res.end(JSON.stringify({
                "k": result,
                "fact": factorial(result)
            })));
        else res.end("Нет параметров в запросе");
    }
    else if (req.url == "/") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("fact.html"));
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