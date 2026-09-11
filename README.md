# UTE 渣渣整合版

一个基于 **Undertale Engine** 深度修改的 Undertale 同人游戏开发模板。

<img width="640" height="480" alt="Sprite-0001" src="https://github.com/user-attachments/assets/720ced79-752d-4b30-b75a-cdc76b7068c8" />
<img width="640" height="480" alt="Sprite-0007" src="https://github.com/user-attachments/assets/e90293b4-fa4b-47dd-a2b8-8a0e80e18840" />


## 这是什么？

**UTE 渣渣整合版** 是由 **糖萌芦** 开发的 Undertale Engine 的修改版本。

本项目在原版 UTE 的基础上扩展并重写了多个核心系统，为使用 **GameMaker Studio 2** 制作 Undertale 风格同人游戏提供更加完整的开发基础。

项目重点扩展了战斗框、蓝魂、板子、对话、过场事件、商店、存档、本地化以及调试器等系统。

## 功能

### 战斗系统

* 自定义形状战斗框
* 异形战斗框
* 圆形及圆角矩形战斗框
* 战斗框颜色与透明度控制
* 自定义战斗框尺寸
* 重写蓝魂系统
* 重写板子系统
* `global.is_moving` 灵魂移动状态检测
* 尽可能还原原版 Undertale 的 KR 系统
* 随机战斗菜单文本
* 敌人位置检测
* 多敌人战斗支持

<img width="640" height="480" alt="Sprite-0002" src="https://github.com/user-attachments/assets/722d4be3-ecf8-4615-9311-1b5c3d8340f4" />

### 对话与文字

* 新版打字机系统
* 文字旋转
* 文字对齐
* 改进的 `char` 系统
* 主世界对话框
* 内置骷髅兄弟字体支持

<img width="640" height="480" alt="Sprite-0003" src="https://github.com/user-attachments/assets/59d51f50-2c97-46ff-823c-5f0bf79813b8" />
<img width="640" height="480" alt="Sprite-0013" src="https://github.com/user-attachments/assets/a658bcd0-dbe7-4a21-a912-c82f9a8c2365" />

### 主世界与事件

* 过场事件系统
* 提示系统
* 改进的玩家移动

<img width="640" height="480" alt="Sprite-0006" src="https://github.com/user-attachments/assets/749307e9-96eb-4a59-b0e8-2b14c7e70930" />
<img width="640" height="480" alt="Sprite-0004" src="https://github.com/user-attachments/assets/263ed574-402c-4946-ade1-5cfb99de1918" />

### 商店、存档与本地化

* 商店系统
* 重写的本地化系统
* 重写的存档 / Flag 系统
* 更好的可读性与扩展性

<img width="640" height="480" alt="Sprite-0005" src="https://github.com/user-attachments/assets/f05a7aa6-cd94-4e17-a6aa-84d7e571eb13" />

### 开发工具

* 内置 Debugger
* 房间切换
* 调试信息

长按 **Tab + H** 可以在引擎输出窗口或控制台中查看 Debugger 的使用说明。

<img width="640" height="480" alt="Sprite-0012" src="https://github.com/user-attachments/assets/338f09a3-c8ff-44c8-978f-82232bf2b6ae" />
<img width="640" height="480" alt="image" src="https://github.com/user-attachments/assets/c6e9f63b-a903-4aa5-99fc-e22259f476c1" />

## 示例

项目内置多个测试房间和功能示例，用于展示各个系统的使用方式。

这些示例也可以作为制作 Undertale 同人游戏时的参考。

<img width="640" height="480" alt="Sprite-0011" src="https://github.com/user-attachments/assets/3a8d76c3-da36-464b-a15a-e97a1d954d9e" />
<img width="960" height="540" alt="Sprite-0009" src="https://github.com/user-attachments/assets/3fa56e73-221f-4be9-b560-ba10aeb81bc2" />


## 开始使用

本项目的基本使用方式与原版 Undertale Engine 相似。

由于本项目进行了大量修改，**无法通过 YYMPS 等方式迁移到其他工程**。

请直接下载本项目，并在该工程的基础上进行开发。

## 已知问题

目前没有已知的严重问题。

由于项目仍缺少充分测试，未来可能发现其他问题。

如果发现 Bug，请通过 GitHub Issue 反馈。

## 鸣谢

* **糖萌芦** — Undertale Engine 原作者，以及 GMU 系列相关功能
* **VMSIOnGithub** — 新版异形战斗框系统
* **这是纸鸢** — 商店、本地化及调试器系统
* **Sanesss 等人** — 旧版本测试与反馈
* **1个渣渣** — 项目整合、修改及其他功能开发
