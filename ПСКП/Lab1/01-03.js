var http = require("http");

let headers = (r) => {
    let rc = '';
    for(key in r.headers) rc += `${key}: ${r.headers[key]}`;
    return rc;
}

function GET_handler(req, res) {
    if (req.url == "/") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.write(`метод ${req.method}</br>
                uri ${req.url}</br>
                версия ${req.httpVersion}</br>`);
        res.end(headers(req));
    }
    else {
        OTHER_handler(req, res);
    }
}

function POST_handler(req, res) {
    if (req.url == "/") {
        let buf = "";
        req.on("data", (data) =>{buf+=data;})
        req.on("end", () => { res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"}); res.end(`SERVER: ${buf}`); });
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
        case 'POST' : POST_handler(req, res); break;
        default: OTHER_handler(req, res); break;
    }
};

var server = http.createServer();
 server.listen(3000, () => {console.log("server.listen(3000)")})
            .on("error", () => {console.log("server.listen(3000): error: ", e.code)})
            .on("request", http_handler);