var http = require("http");

let options = {
    host: "localhost",
    path: "/",
    port: 3000,
    method: "GET"
}

const req = http.request(options, res => {
    console.log(`${res.statusCode}: ${res.statusMessage}\n${res.socket.remoteAddress}: ${res.socket.remotePort}`);
    let data = "";
    res.on("data", chunk => {
        data += chunk.toString("utf8");
    });
    res.on("end", () => {
        console.log(`\ndata = ${data}`);
    });
});

req.on("error", e => {console.log("Error: ", e.message)});
req.end();