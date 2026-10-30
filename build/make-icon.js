const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#15171c"/>
      <stop offset="1" stop-color="#08090b"/>
    </linearGradient>
  </defs>
  <rect x="8" y="8" width="496" height="496" rx="112" fill="url(#bg)"/>
  <circle cx="256" cy="256" r="168" fill="none" stroke="#f3f0ea" stroke-width="7" opacity="0.9"/>
  ${[0, 90, 180, 270].map(a => {
    const r = (a - 90) * Math.PI / 180;
    const x1 = 256 + 186 * Math.cos(r), y1 = 256 + 186 * Math.sin(r);
    const x2 = 256 + 206 * Math.cos(r), y2 = 256 + 206 * Math.sin(r);
    return `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="#f3f0ea" stroke-width="7" opacity="0.55"/>`;
  }).join('')}
  <line x1="256" y1="256" x2="256" y2="150" stroke="#f3f0ea" stroke-width="14" stroke-linecap="round" transform="rotate(-60 256 256)"/>
  <line x1="256" y1="256" x2="256" y2="104" stroke="#f3f0ea" stroke-width="9" stroke-linecap="round" transform="rotate(60 256 256)"/>
  <line x1="256" y1="270" x2="256" y2="96" stroke="#e8c07a" stroke-width="6" stroke-linecap="round" transform="rotate(198 256 256)"/>
  <circle cx="256" cy="256" r="13" fill="#e8c07a"/>
</svg>`;

(async () => {
  fs.writeFileSync(path.join(__dirname, 'icon.png'), await sharp(Buffer.from(svg)).resize(512, 512).png().toBuffer());

  const sizes = [16, 24, 32, 48, 64, 128, 256];
  const images = [];
  for (const size of sizes) {
    images.push({ size, png: await sharp(Buffer.from(svg)).resize(size, size).png().toBuffer() });
  }

  // ICONDIR + one PNG-compressed entry per size
  const dir = Buffer.alloc(6, 0);
  dir.writeUInt16LE(0, 0);          // reserved
  dir.writeUInt16LE(1, 2);          // type: icon
  dir.writeUInt16LE(images.length, 4);

  const entries = [];
  let offset = 6 + 16 * images.length;
  for (const img of images) {
    const e = Buffer.alloc(16, 0);
    e.writeUInt8(img.size === 256 ? 0 : img.size, 0);
    e.writeUInt8(img.size === 256 ? 0 : img.size, 1);
    e.writeUInt8(0, 2);            // palette
    e.writeUInt8(0, 3);            // reserved
    e.writeUInt16LE(1, 4);         // planes
    e.writeUInt16LE(32, 6);        // bits per pixel
    e.writeUInt32LE(img.png.length, 8);
    e.writeUInt32LE(offset, 12);
    offset += img.png.length;
    entries.push(e);
  }
  const ico = Buffer.concat([dir, ...entries, ...images.map(i => i.png)]);
  fs.writeFileSync(path.join(__dirname, 'icon.ico'), ico);
  console.log('icon.ico', ico.length, 'bytes,', sizes.join('/'));
})();
