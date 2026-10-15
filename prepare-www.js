// Copies the map library (Leaflet) into www/lib so the app works without internet.
const fs=require('fs'), path=require('path');
const src=path.join(__dirname,'..','node_modules','leaflet','dist'), dst=path.join(__dirname,'..','www','lib');
fs.mkdirSync(dst,{recursive:true});
for(const f of ['leaflet.js','leaflet.css']) fs.copyFileSync(path.join(src,f),path.join(dst,f));
fs.cpSync(path.join(src,'images'),path.join(dst,'images'),{recursive:true});
console.log('Leaflet copied to www/lib');
