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
        'file': 'MyFile.txt'
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
req.write('Content-Disposition: form-data; name="file"; filename="MyFile.txt"\r\n\r\n');
req.write(fs.readFileSync("MyFile.txt") + "\r\n");
req.write("--" + boundary + "--\r\n");
req.end();