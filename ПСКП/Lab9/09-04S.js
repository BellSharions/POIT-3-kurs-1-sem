var http = require("http");

function POST_handler(req, res) {
    if (req.url = "/") {
        let obj = "";
        req.on("data", data => {obj += data;});
        req.on("end", () => {
            let result = JSON.parse(obj);
            let comment = "Ответ";
            let sum = result.x + result.y;
            let concat = `${result.s}: ${result.o.surname}, ${result.o.name}`;
            let length = result.m.length;
            res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
            res.end(JSON.stringify(
                {
                    "__comment": comment,
                    "x_plus_y": sum,
                    "Concatination_s_o": concat,
                    "Length_m": length
                }
            ));
        });
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