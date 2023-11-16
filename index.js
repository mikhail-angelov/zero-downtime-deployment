const http = require("http");

const host = 'localhost';
const port = process.env.PORT || 3000;
const version = process.env.VER;

const requestListener = function (req, res) {
    console.log(`request: ${req.url} from ${version}`);
    res.setHeader("Content-Type", "application/json");
    res.writeHead(200);
    res.end(JSON.stringify({
        version,
        url: req.url,
        method: req.method,
        params: req.params,
        headers: req.headers,
    }));
};

const server = http.createServer(requestListener);
server.listen(port, () => {
    console.log(`Server is running on http://${host}:${port}, version: ${version}`);
});
