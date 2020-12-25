window.onload = function() {
    document.getElementById("result").innerText += " HELLO";
}

async function GetJSON() {
    const f = await fetch("http://localhost:3000/json/jsonFile.json", {
		method: 'GET'
	});
    const result = await f.text();
    document.getElementById("JsonOrXml").innerText = result;
}

async function GetXML() {
    const f = await fetch("http://localhost:3000/xml/xmlFile.xml", {
		method: 'GET'
	});
    const result = await f.text();
    document.getElementById("JsonOrXml").innerText = result;
}
