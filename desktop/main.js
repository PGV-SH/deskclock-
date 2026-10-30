const { app, BrowserWindow, ipcMain, powerSaveBlocker, Menu } = require('electron');
const path = require('path');

let win = null;
let blockerId = null;
const WINDOWED = process.env.DESKCLOCK_WINDOWED === '1';

function startBlocker(){
  if (blockerId === null || !powerSaveBlocker.isStarted(blockerId)){
    blockerId = powerSaveBlocker.start('prevent-display-sleep');
  }
}
function stopBlocker(){
  if (blockerId !== null && powerSaveBlocker.isStarted(blockerId)){
    powerSaveBlocker.stop(blockerId);
  }
  blockerId = null;
}

function createWindow(){
  win = new BrowserWindow({
    width: 1280,
    height: 800,
    minWidth: 640,
    minHeight: 480,
    backgroundColor: '#0a0a0c',
    show: false,
    autoHideMenuBar: true,
    title: '极简时钟',
    icon: path.join(__dirname, 'icon.ico'),
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
      backgroundThrottling: false,
      spellcheck: false
    }
  });

  win.loadFile(path.join(__dirname, 'index.html'));

  win.once('ready-to-show', () => {
    win.show();
    if (WINDOWED) win.maximize();
    else win.setKiosk(true);
  });

  // Esc leaves full screen, F11 toggles it back, Alt+F4 quits.
  win.webContents.on('before-input-event', (event, input) => {
    if (input.type !== 'keyDown' || !win) return;
    if (input.key === 'Escape' && win.isKiosk()){
      win.setKiosk(false);
      win.maximize();
    } else if (input.key === 'F11'){
      win.setKiosk(!win.isKiosk());
    }
  });

  win.on('closed', () => { win = null; });
}

function setupMenu(){
  if (process.platform === 'darwin'){
    Menu.setApplicationMenu(Menu.buildFromTemplate([{
      label: '极简时钟',
      submenu: [
        { role: 'about', label: '关于极简时钟' },
        { type: 'separator' },
        { label: '切换全屏', accelerator: 'Cmd+Ctrl+F', click: () => { if (win) win.setKiosk(!win.isKiosk()); } },
        { type: 'separator' },
        { label: '退出极简时钟', accelerator: 'Cmd+Q', click: () => app.quit() }
      ]
    }]));
  } else {
    Menu.setApplicationMenu(null);
  }
}

app.whenReady().then(() => {
  setupMenu();
  startBlocker();
  createWindow();
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => app.quit());

ipcMain.on('wake', (event, on) => {
  if (on) startBlocker(); else stopBlocker();
});

ipcMain.on('quit', () => app.quit());
