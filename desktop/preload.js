const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('deskClock', {
  isApp: true,
  setWake: (on) => ipcRenderer.send('wake', !!on),
  quit: () => ipcRenderer.send('quit')
});
