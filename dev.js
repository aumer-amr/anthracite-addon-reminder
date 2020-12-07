require('dotenv').config();

const package = require('./package.json');
const fs = require('fs');
const path = require('path');
const ncp = require('ncp').ncp;

ncp.limit = 16;

if (!process.env.wowdir) {
    console.error("wowdir is not set");
    return 1;
}

const addondir = path.join(process.env.wowdir, package['addon-name']);

if (fs.existsSync(addondir)) {
    return fs.rm(addondir, { recursive: true, force: true }, () => {
        copy();
    });
} else {
    copy();
}

function copy(){
    ncp("./src", addondir, (err) => {
        if (err) return console.error(err);
        
        console.log("Updated in client, please /reload");
    });
}