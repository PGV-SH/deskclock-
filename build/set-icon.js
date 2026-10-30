const fs = require('fs');
const path = require('path');
const ResEdit = require('resedit');

const exe = path.join(__dirname, 'dist', 'DeskClock-win32-x64', 'DeskClock.exe');
const data = fs.readFileSync(exe);
const PE = ResEdit.NtExecutable.from(data, { ignoreCert: true });
const res = ResEdit.NtExecutableResource.from(PE);

// Replace the Electron icon with our own (icon group id 1)
const iconFile = ResEdit.Data.IconFile.from(fs.readFileSync(path.join(__dirname, 'icon.ico')));
ResEdit.Resource.IconGroupEntry.replaceIconsForResource(
  res.entries, 1, 1033, iconFile.icons.map(i => i.data)
);

// Version info shown in Windows file properties
let vi = ResEdit.Resource.VersionInfo.fromEntries(res.entries)[0];
if (!vi) vi = ResEdit.Resource.VersionInfo.createEmpty();
vi.setFileVersion(1, 0, 0, 0);
vi.setProductVersion(1, 0, 0, 0);
vi.setStringValues({ lang: 1033, codepage: 1200 }, {
  CompanyName: 'Zohan',
  FileDescription: '极简时钟 - 全屏桌面时钟',
  ProductName: '极简时钟',
  FileVersion: '1.0.0.0',
  ProductVersion: '1.0.0.0',
  OriginalFilename: 'DeskClock.exe',
  InternalName: 'DeskClock',
  LegalCopyright: '© 2026 Zohan'
});
vi.outputToResourceEntries(res.entries);

res.outputResource(PE);
fs.writeFileSync(exe, Buffer.from(PE.generate()));
console.log('patched', exe);
