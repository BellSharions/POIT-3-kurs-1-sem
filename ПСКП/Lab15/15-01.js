var http = require("http");
const MongoClient = require("mongodb").MongoClient;
var url = require("url");

const mongoClient = new MongoClient("mongodb://localhost:27017/", {useNewUrlParser: true, useUnifiedTopology: true});

mongoClient.connect(function(err, client) {
    const db = client.db("bstu");
    const pulpit = db.collection("pulpit");
    const faculty = db.collection("faculty");

    if(err) return console.log(err);

    function GET_handler(req, res) {
        if (req.url == "/pulpits") {
            pulpit.find({}).toArray(function(err, result) {
                console.log("Данные получены из pulpit");
                res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                res.end(JSON.stringify(result));
            });
        }
        else if (req.url == "/faculties") {
            faculty.find({}).toArray(function(err, result) {
                console.log("Данные получены из faculty");
                res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                res.end(JSON.stringify(result));
            });
        }
        else if ( req.url == "/close") {
            res.writeHead(200, {"Content-Type" : "text/plain; charset=utf-8"});
            res.end("Соединение с MongoDB закрыто");
            client.close();
        }
        else {
            OTHER_handler(req, res);
        }
    }

    function POST_handler(req, res) {
        if(req.url == "/faculties") {
            let result = "";
            req.on("data", data => {result += data;});
            req.on("end", () => {
                let obj = JSON.parse(result);
                faculty.insertOne(obj, function(err, result) {
                    console.log("Добавлена запись в faculty");
                    res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                    res.end(JSON.stringify(result.ops));
                });
            });
        }
        else if(req.url == "/pulpits") {
            let result = "";
            req.on("data", data => {result += data;});
            req.on("end", () => {
                let obj = JSON.parse(result);
                pulpit.insertOne(obj, function(err, result) {
                    console.log("Добавлена запись в pulpit");
                    res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                    res.end(JSON.stringify(result.ops));
                });
            });
        }
        else OTHER_handler(req, res);
    }

    function PUT_handler(req, res) {
        if(req.url == "/faculties") {
            let result = "";
            req.on("data", data => {result += data;});
            req.on("end", () => {
                let obj = JSON.parse(result);
                faculty.findOneAndUpdate(
                    {faculty: obj.faculty},
                    {$set: {faculty_name: obj.faculty_name}},
                    {
                        returnOriginal: false
                    },
                    function(err, result) {
                        console.log("Запись обновлена в faculty");
                        res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                        res.end(JSON.stringify(result.value));
                    }
                );
            });
        }
        else if (req.url == "/pulpits") {
            let result = "";
            req.on("data", data => {result += data;});
            req.on("end", () => {
                let obj = JSON.parse(result);
                pulpit.findOneAndUpdate(
                    {pulpit: obj.pulpit},
                    {$set: {pulpit_name: obj.pulpit_name, faculty: obj.faculty}},
                    {
                        returnOriginal: false
                    },
                    function(err, result) {
                        console.log("Запись обновлена в pulpit");
                        res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                        res.end(JSON.stringify(result.value));
                    }
                );
            });
        }
        else OTHER_handler(req, res);
    }

    function DELETE_handler(req, res) {
        if(String(req.url).includes("faculties")) {
            let code = decodeURI(url.parse(req.url, true).pathname).split("/")[2];
            faculty.findOneAndDelete(
                {faculty: code},
                function(err, result) {
                    console.log("Удалена запись из faculties");
                    res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                    res.end(JSON.stringify(result.value));
                }
            );
        }
        else if(String(req.url).includes("pulpits")) {
            let code = decodeURI(url.parse(req.url, true).pathname).split("/")[2];
            pulpit.findOneAndDelete(
                {pulpit: code},
                function(err, result) {
                    console.log("Удалена запись из pulpit");
                    res.writeHead(200, {"Content-Type" : "text/json; charset=utf-8"});
                    res.end(JSON.stringify(result.value));
                }
            );
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
            case 'PUT' : PUT_handler(req, res); break;
            case 'DELETE' : DELETE_handler(req, res); break;
            default: OTHER_handler(req, res); break;
        }
    };

    var server = http.createServer();
    server.listen(3000, function(v) {console.log("server.listen(3000)")})
        .on("error", function(e) {console.log("server.listen(3000): error: ", e.code)})
        .on("request", http_handler);
});