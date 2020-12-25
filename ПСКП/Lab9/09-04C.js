var http = require("http");

let json = JSON.stringify(
    {
        __comment: "Запрос",
        x: 5,
        y: 2,
        s: "Сообщение",
        m: ["a", "b", "c", "d"],
        o: {surname: "Иванов", name: "Иван"}
    }
);

let options = {
    host: "localhost",
    path: "/",
    port: 3000,
    method: "POST",
    headers: {
        "content-type": "application/json", "accept":"application/json"
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
req.end(json);