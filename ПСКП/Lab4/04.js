var http = require("http");
var fs = require("fs");
var data = require("./m04");
var url = require("url");

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

function GET_handler(req, res) {
    if (String(req.url).substr(0,7) == "/api/db")  {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        db.emit("GET", req, res);
    }
    else if (req.url == "/") {
        res.writeHead(200, {"Content-Type" : "text/html; charset=utf-8"});
        res.end(fs.readFileSync("index.html"));
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