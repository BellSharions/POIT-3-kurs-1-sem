var http = require("http");
var parseString = require("xml2js").parseString;
var xmlbuilder = require("xmlbuilder");

var xmltext = '<request id = "28">' +
                '<x value = "5"/>' +
                '<x value = "2"/>' +
                '<m value = "a"/>' +
                '<m value = "b"/>' +
                '<m value = "c"/>' +
            '</request>'

let options = {
    host: "localhost",
    path: "/",
    port: 3000,
    method: "POST",
    headers: {
        "content-type": "application/xml", "accept":"application/xml"
    }
}

const req = http.request(options, res => {
    console.log(`${res.statusCode}: ${res.statusMessage}`);
    let data = "";
    res.on("data", chunk => {
        data += chunk.toString("utf8");
    });
    res.on("end", () => {
        console.log(`\n${data}`);
    });
});

req.on("error", e => {console.log("Error: ", e.message)});
req.end(xmltext);