var http = require("http");
var mp = require("multiparty");

function POST_handler(req, res) {
    if (req.url = "/") {
        let form = new mp.Form({uploadDir: "./static"});
        form.on("field", (name, value) => {
            
        });
        form.on("file", (name, file) => {           
        });
        form.on("error", (err) => {
            res.writeHead(200, {"Content-Type" : "text/plain; charset=utf-8"});
            res.end(`${err}`);
        });
        form.on("close", () => {
            res.writeHead(200, {"Content-Type" : "text/plain; charset=utf-8"});
            res.end("Файл получен");
        });
        form.parse(req);
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