var util = require('util');
var ee = require('events');

var db_data = [
    {id: 1, name: 'Dmitry'},
    {id: 2, name: 'Vitaly'},
    {id: 3, name: 'Artem'}
];

function DB() {
    this.select = () => {return db_data;};
    this.insert = (r) => {db_data.push(r);};
    this.put = (r) => {
        for(let i = 0; i < db_data.length; i++) {
            if(db_data[i].id == r.id) db_data.splice(i, 1, r);
        }
    }
    this.delete = (r) => {
        let obj;
        for(let i = 0; i < db_data.length; i++) {
            if(db_data[i].id == r) {
                obj = db_data[i];
                db_data.splice(i, 1);
            }
        }
        return obj;
    };
    this.commit = () => {console.log("commit");}
}

util.inherits(DB, ee.EventEmitter);

exports.DB = DB;