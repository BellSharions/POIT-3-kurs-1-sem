var http = require("http");
var fs = require("fs");
var data = require("./m05");
var url = require("url");
const { clear } = require("console");
const { threadId } = require("worker_threads");
const { EventEmitter } = require("events");

var db = new data.DB();

db.on("GET", (req, res) => {
    console.log("DB.GET");
    let result = db.select();
    let data = "";
    result.forEach(el => {
        data += `${el.id}-${el.name}</br>`;
    });
    res.end(data);
});
db.on("POST", (req, res) => {
    console.log("DB.POST");
    req.on("data", data => {
        let r = JSON.parse(data);
        db.insert(r);
        res.end(JSON.stringify(r));
    })
});
db.on("PUT", (req, res) => {
    console.log("DB.PUT");
    req.on("data", data => {
        let r = JSON.parse(data);
        db.put(r);
        res.end(JSON.stringify(r));
    })
});
db.on("DELETE", (req, res) => {
    console.log("DB.DELETE");
    let q = url.parse(req.url, true).query;
    for(key in q) {
        result = q[key];
    }
    res.end(JSON.stringify(db.delete(result)));
});
db.on("COMMIT", () => {
    db.commit();
});

var timer1 = null;
var timer2 = null;
var timer3 = null;
var requests = 0;
var commits = 0;
var obj = null;
var start = null;

var emitter = new EventEmitter();

process.stdin.setEncoding("utf-8");
process.stdin.on("readable", () => {
    let chunk = null;
    while ((chunk = process.stdin.read()) != null) {
        let result = new Array();
        result = chunk.split(" ");
        if(result[0].trim() == "sd" && result.length == 2 && !isNaN(Number(result[1].trim()))) {
            timer1 = setTimeout(() => {
                process.stdin.unref();
                if (timer2 != null) {timer2.unref();};
                if (timer3 != null) {timer3.unref();};
                server.close(() => {console.log("terminated");});
                server.emit("close");
            }, Number(result[1].trim()));
        }
        else if (result[0].trim() == "sd" && result.length == 1 && timer1 != null) {
            console.log("stop close server");
            clearTimeout(timer1);
            timer1 = null;
        }
        else if(result[0].trim() == "sc" && result.length == 2 && !isNaN(Number(result[1].trim()))) {
            timer2 = setInterval(() => {
                if (timer3 != null) {
                    commits++;
                }
                db.emit("COMMIT");
            }, Number(result[1].trim()));
        }
        else if (result[0].trim() == "sc" && result.length == 1 && timer2 != null) {
            console.log("commit is stopped");
            clearInterval(timer2);
            timer2 = null;
        }
        else if(result[0].trim() == "ss" && result.length == 2 && !isNaN(Number(result[1].trim()))) {
            start = new Date().toLocaleTimeString();
            timer3 = setTimeout(() => {
                obj = {
                   "start": start,
                   "finish": new Date().toLocaleTimeString(),
                   "request": requests,
                   "commit": commits
                }
                requests = 0;
                commits = 0;
                console.log("statistics end");
                clearTimeout(timer3);
                timer3 = null;
            }, Number(result[1].trim()));
        }
        else if (result[0].trim() == "ss" && result.length == 1 && timer3 != null) {
            obj = {
                "start": start,
                "finish": new Date().toLocaleTimeString(),
                "request": requests,
                "commit": commits
            }
            requests = 0;
            commits = 0;
            console.log("statistics is stopped");
            clearTimeout(timer3);
            timer3 = null;
        }
        else process.stdout.write("Wrong command\n");
    }
});

function GET_handler(req, res) {
    if (String(req.url).substr(0,7) == "/api/db")  {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        db.emit("GET", req, res);
    }
    else if (req.url == "/") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("index.html"));
    }
    else if (req.url == "/api/ss") {
        res.writeHead(200, {"Content-Type" : "text/plain; charset=utf-8"});
        if (timer3 != null) {
            obj = {
                "start": start,
                "finish": "-",
                "request": requests,
                "commit": commits
            }
        }
        res.end(JSON.stringify(obj));
    }
    else {
        OTHER_handler(req, res);
    }
}
function POST_handler(req, res) {
    if (String(req.url).substr(0,7) == "/api/db")  {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        db.emit("POST", req, res);
    }
    else {
        OTHER_handler(req, res);
    }
}
function PUT_handler(req, res) {
    if (String(req.url).substr(0,7) == "/api/db")  {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        db.emit("PUT", req, res);
    }
    else {
        OTHER_handler(req, res);
    }
}
function DELETE_handler(req, res) {
    if (String(req.url).substr(0,7) == "/api/db")  {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        db.emit("DELETE", req, res);
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
    res.setHeader('Connection', 'close');
    if (timer3 != null) {
        requests++;
    }
    switch (req.method) {
        case 'GET' : GET_handler(req, res); break;
        case 'POST' : POST_handler(req, res); break;
        case 'PUT' : PUT_handler(req, res); break;
        case 'DELETE' : DELETE_handler(req, res); break;
        default: OTHER_handler(req, res); break;
    }
};

var server = http.createServer();
 server.listen(5000, function(v) {console.log("server.listen(5000)")})
            .on("error", function(e) {console.log("server.listen(5000): error: ", e.code)})
            .on("request", http_handler);