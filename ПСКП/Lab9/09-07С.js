var http = require("http");
let fs = require("fs");

let boundary = "-----dmitrysuraho";

let options = {
    host: "localhost",
    path: "/",
    port: 3000,
    method: "POST",
    headers: {
        'content-type': 'multipart/form-data; boundary=' + boundary
    },
    form: {
        'file': 'MyFile.png'
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

req.write("--" + boundary + "\r\n");
req.write('Content-Disposition: form-data; name="file"; filename="MyFile.png"\r\n');
req.write('Content-Type: application/octet-stream\r\n\r\n');

let stream = new fs.ReadStream("D:\\Labs\\ПСКП\\Lab9\\MyFile.png");
stream.on("data", chunk => {req.write(chunk);})
stream.on("end", () => {req.end("\r\n--" + boundary + "--\r\n"); });