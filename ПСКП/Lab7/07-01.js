var http = require("http");
var stat = require("./m07-01")("./static");

function GET_handler(req, res) {
    if (stat.isStatic("html", req.url)) stat.sendFile(req, res, {"Content-Type": "text/html; charset=utf-8"});
    else if (stat.isStatic("css", req.url)) stat.sendFile(req, res, {"Content-Type": "text/css; charset=utf-8"});
    else if (stat.isStatic("js", req.url)) stat.sendFile(req, res, {"Content-Type": "text/javascript; charset=utf-8"});
    else if (stat.isStatic("docx", req.url)) stat.sendFile(req, res, {"Content-Type": "application/msword; charset=utf-8"});
    else if (stat.isStatic("png", req.url)) stat.sendFile(req, res, {"Content-Type": "image/png; charset=utf-8"});
    else if (stat.isStatic("mp4", req.url)) stat.sendFile(req, res, {"Content-Type": "video/mp4; charset=utf-8"});
    else if (stat.isStatic("json", req.url)) stat.sendFile(req, res, {"Content-Type": "application/json; charset=utf-8"});
    else if (stat.isStatic("xml", req.url)) stat.sendFile(req, res, {"Content-Type": "application/xml; charset=utf-8"});
    else stat.writeHTTP404(res);
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