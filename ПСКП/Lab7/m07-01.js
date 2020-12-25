var fs = require("fs");

function Stat(sfn) {
    this.writeHTTP404 = (res) => {
        res.statusCode = 404;
        res.end("Resourse not found");
    }
    this.isStatic = (ext, fn) => {return (new RegExp(`^\/.+\.${ext}$`)).test(fn);}
    this.sendFile = (req, res, headers) => {
        fs.access(`${sfn}${req.url}`, fs.constants.R_OK, err => {
            if(err) this.writeHTTP404(res);
            else {
                res.writeHead(200, headers);
                fs.createReadStream(`${sfn}${req.url}`).pipe(res);
            }
        });
    }
}

module.exports = (parm) => {return new Stat(parm);}