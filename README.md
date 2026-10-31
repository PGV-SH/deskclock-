# 极简时钟 · DeskClock

把闲置的平板、旧手机、旧电脑变成一台优雅的桌面时钟。单文件网页内核，同一套界面同时支持 **Windows / macOS / Android / 浏览器**。

![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Android%20%7C%20Web-blue)
![License](https://img.shields.io/badge/license-CC%20BY--NC%204.0-orange)

## 功能特性

### 12 种表盘样式
罗马盘 · 极简盘 · 大数字 · 翻页卡 · 世界钟 · 文字钟 · 圆环钟 · 上下数字 · 二进制钟 · 点阵钟 · 左右数字 · 大字日期

### 个性化
- **自定义背景图片**：选一张喜欢的照片当表盘背景，本地压缩保存，不上传
- **世界时钟**：22 个城市任意勾选（最多 6 个），同时显示各地时间
- **4 套主题**：暗夜 / 纸白 / 墨蓝 / 暖光，另有 6 种强调色
- **显示细节**：24 小时制、秒显、日期、平滑秒针均可开关

### 为长期亮屏而设计
- **防烧屏**：画面周期性缓慢位移，保护 OLED 屏
- **屏幕常亮**：阻止设备休眠（桌面端使用系统级电源管理）
- **夜间自动调暗**：22:00 – 7:00 自动降低亮度
- **闲置自动隐藏界面**：几秒无操作后隐藏所有按钮，只留纯粹的时钟

## 下载

在 [Releases](../../releases) 页面下载对应平台的安装包：

| 平台 | 文件 | 说明 |
| --- | --- | --- |
| Windows | `DeskClock-Setup-1.0.0.exe` | 安装程序（自动创建桌面快捷方式） |
| Windows | `DeskClock-Windows.zip` | 免安装便携版，解压即用 |
| macOS（Apple 芯片） | `DeskClock-1.0.0-arm64.dmg` | M1/M2/M3/M4 系列 |
| macOS（Intel） | `DeskClock-1.0.0-x64.dmg` | Intel 处理器 |
| Android | `DeskClock-1.0.0.apk` | Android 8.0 及以上 |
| iOS | `DeskClock-1.0.0-unsigned.ipa` | iOS 15+，需自行签名安装 |

## 使用说明

- **桌面端（Windows / macOS）**：启动后自动进入全屏（kiosk）模式；按 `Esc` 退出全屏，macOS 可用 `Cmd+Ctrl+F` 切换
- **Android**：双击返回键退出
- **快捷键**：

| 按键 | 功能 |
| --- | --- |
| `1` – `9` | 快速切换表盘 |
| `←` `→` | 上一个 / 下一个表盘 |
| `F` / 双击画面 | 全屏切换 |
| `S` | 打开 / 关闭设置 |
| `T` | 循环切换主题 |
| `空格` | 立即隐藏界面 |

## 技术说明

- 内核为单文件 HTML/CSS/JS，无第三方 JS 库，无任何网络请求，**不收集任何数据**
- 桌面端基于 [Electron](https://www.electronjs.org/) 打包；Android 端为原生 WebView 封装
- 图标、表盘、UI 全部为自绘 SVG/CSS

## 版权信息

**© 2026 Zohan**

本项目以 **[CC BY-NC 4.0（署名-非商业性使用）](https://creativecommons.org/licenses/by-nc/4.0/deed.zh-hans)** 协议开源，详见 [LICENSE](LICENSE)：

- ✅ 可以自由使用、复制、修改、二次开发
- ✅ 二次开发/转载时必须**署名原作者 Zohan**，并附上本仓库链接
- ❌ **禁止商用**：不得将本项目或其修改版打包出售、用于付费应用或以任何方式盈利分发
- 背景图片功能中用户自行选择的图片，其版权由用户自行负责

### 第三方组件致谢

本软件使用了以下开源组件，感谢其作者：

| 组件 | 许可证 | 用途 |
| --- | --- | --- |
| [Electron](https://www.electronjs.org/) | MIT | Windows / macOS 桌面运行时 |
| [Chromium](https://www.chromium.org/) | BSD | 内置于 Electron 的渲染引擎 |

上述组件的完整许可证文本已随安装包附带（`LICENSE`、`LICENSES.chromium.html`）。
<img width="2560" height="1351" alt="e0f79a6ca12d65bb8c321fc8c8d3c67f" src="https://github.com/user-attachments/assets/ba3ee772-13bb-4756-8e32-fa7b234ff445" />
<img width="2560" height="1351" alt="c23d3274b71e9b85cc2a4052af14f2a3" src="https://github.com/user-attachments/assets/376d656b-5f4d-4bc1-9a67-fb223fe95e22" />
<img width="1710" height="1112" alt="截屏2026-10-31 12 00 37" src="https://github.com/user-attachments/assets/658ee62a-3b79-4eaa-828b-c9165662f57d" />
<img width="2560" height="1350" alt="80e0c3cf641d6223d452512781314ca6" src="https://github.com/user-attachments/assets/700eaf87-42af-4f9c-8992-e4d678543dda" />
<img width="2560" height="1350" alt="9f28df44c9253eb511189ba6bfcc8b14" src="https://github.com/user-attachments/assets/c1763dca-6c9b-46d3-ac2a-5d11fb9f8491" />


