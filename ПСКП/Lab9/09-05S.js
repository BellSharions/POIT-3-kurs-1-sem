var http = require("http");
var parseString = require("xml2js").parseString;
var xmlbuilder = require("xmlbuilder");

var studentscalc = (obj) => {
    let rc = "<result>parse error</result>";
    try {
        let sum = 0;
        let concat = "";
        let xmldoc = xmlbuilder.create("response").att("request", obj.request.$.id);
        obj.request.x.map((e, i) => {
            sum += Number(e.$.value);
        });
        obj.request.m.map((e, i) => {
            concat += String(e.$.value);
        });
        xmldoc.ele("sum", {element: "x", result: sum});
        xmldoc.ele("concat", {element: "m", result: concat});

        rc = xmldoc.toString({pretty: true});
    }
    catch(e){console.log(e);}
    return rc;
}

function POST_handler(req, res) {
    if (req.url = "/") {
        let xmltxt = "";
        req.on("data", data => {xmltxt += data;});
        req.on("end", () => {
            parseString(xmltxt, (err, result) => {
                if(err) res.end("bad xml");
                else {
                    res.writeHead(200, {"Content-Type" : "text/xml; charset=utf-8"});
                    res.end(studentscalc(result));
                }
            });
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