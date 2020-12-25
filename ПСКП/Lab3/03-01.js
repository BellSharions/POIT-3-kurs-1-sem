var http = require("http");
var fs = require("fs");

var result = "unknown";
process.stdin.setEncoding("utf-8");
process.stdin.on("readable", () => {

    let chunk = null;
    while ((chunk = process.stdin.read()) != null) {
        if(chunk.trim() == "norm" && result != "norm") {
            process.stdout.write(`${result} -> norm\n`);
            result = "norm";
        }
        else if(chunk.trim() == "stop" && result != "stop") {
            process.stdout.write(`${result} -> stop\n`);
            result = "stop";
        }
        else if(chunk.trim() == "test" && result != "test") {
            process.stdout.write(`${result} -> test\n`);
            result = "test";
        }
        else if(chunk.trim() == "idle" && result != "idle") {
            process.stdout.write(`${result} -> idle\n`);
            result = "idle";
        }
        else if (chunk.trim() == "exit" && result != "exit") {
            process.stdout.write(`${result} -> exit\n`);
            result = "exit";
            process.exit(0);
        }
        else process.stdout.write("Wrong command\n");
    }
});

function GET_handler(req, res) {
    if (req.url == "/") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("index.html"));
    }
    else if (req.url == "/state") { 
	    if (result == "exit") server.close();
        else res.end(result);
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