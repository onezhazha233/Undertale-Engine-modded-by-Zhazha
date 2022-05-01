# UTE渣渣整合版
#
## 这啥玩意啊？
### 此为由我修改过的由糖萌芦开发的Undertale Engine，添加了一些原版ute没有的东西。
## 添加了什么？
### 添加了加框和减框，使得你可以制作异形框，但使用方法略复杂且视觉效果有些不足。
### 添加了由糖萌芦编写，我修改过数据的蓝魂。
## 咋用啊？
### 我在脚本里面写了一丁点注释，或许你能看懂吧，再要么上QQ问我。（我并不常用discord）
### 我QQ号是1561536469.
### 哦，要是你够幸运，说不定你可以在discord的ute群聊里面看到我活跃，但别指望我会帮你解决一堆屁事。
## 我找到了bug怎么办？
### 直接在QQ上找我吧，或者在github界面提交问题，我迟早会看的，尽管我并不一定会解决，毕竟我仅仅是整合了代码，而不是我写的。
## 目前已知的问题
### 减框速度太快会把灵魂卡到奇奇怪怪的地方，这个问题来源于ute原生的灵魂限制代码，要修复这个问题可能要重写部分代码所以我放着不管了
### 灵魂或者加框速度太快会穿过边角，我同样也修不了
#### 对了，还有感谢名单：
###### 绘制在减框上面的背景效果的代码来自于[Siki]
###### 减框原理+初步实现的代码来自于[穹c啋f汾]，他的b站uid是1438530442
###### 加框原理+完全实现代码由[奇迹丶零]移植入ute，原代码来自Gitee的jkjkil4，[奇迹丶零]的b站uid是375539491
###### 可旋转的表面效果的代码来自于[一只鸽子_Official]，他的b站uid是520829726
###### 由[1个渣渣]整合了这些代码，我的b站uid是25245703
###### 由[Sanesss]等人帮助测试
###### ute由[糖萌芦]编写

##### 你可以直接检测灵魂的[moving]变量来判断灵魂是否在移动（蓝魂滞空时一直都是移动状态）

## 以下是版本更新概要
##### v1.0 最初版本的整合版ute
##### v1.1 框可以修改外框和背景的颜色了，修复了主框无法改变坐标和角度的问题
##### v1.2 添加了圆形加框
##### v1.3 改进了加框顶点连接处的视觉效果，把加框的旋转改为了逆时针
##### v1.4 添加了圆角矩形的加框，本质上是两个矩形和四个圆形的组合
##### v1.5 创建矩形加框的脚本可以设置更多参数了（从只能设置宽窄改成了可以设置上下左右的大小），修复了同时销毁多个加框会报错的问题


# Undertale Engine modded by Zhazha
#
## Wat's this?
### It's Undertale Engine by TML which is modded by me,added something that not included in original Undertale Engine.
## Added wat?
### Added Extra-Board and Cover-Board,so you can make various shapes of board.
### Added bluesoul that was write by TML,and modified data by me.
## How to use it properly?
### I wrote some descriptions in the scripts,or you can ask me on QQ.(I don't use discord often)
### My QQ number is 1561536469.
### If you're lucky,maybe you can see me in Undertale Engine Group in discord,but don't expect I would solve your problems.
## I find the bug!
### Tell me on QQ or commit a issue on github,I will see it sooner or later.But I'm not sure I can solve them after all I was just integrated the codes,they are not written by me.
## Known problems
### If speed of Cover-Board is too fast,soul will be wrong position,the problem came from original codes of Undertale Engine,maybe rewrite codes if fix this problem so I left it alone.
### If speed of soul or Extra-Board is too fast,the soul will cross over the edges,I can't fix it too.

#### And the credits:
###### Codes to draw background effect are from [Siki].
###### Theory and codes of preliminary implementation of Cover-Board are from [穹c啋f汾],his Bilibili UID is 1438530442.
###### Theory and codes of completely implementation of Extra-Board are grafted from [奇迹丶零],the original codes are from [jkjkil4] from Gitee,[奇迹丶零]'s Bilibili UID is 375539491.
###### Code of rotatable surface effect are from [一只鸽子_Official],his Bilibili UID is 520829726.
###### [1个渣渣] integrated these codes,my Bilibili UID is 25245703.
###### Tested with the help of [saness] et al.
###### Undertale Engine by [TML].

##### You can emaxine [moving] variable directly to judge it's moving or not.(When the bluesoul is in the air,it's always moving)

## Update details
##### v1.0 The frist version of ute modded by zhazha
##### v1.1 You can modify the color of board,and fixed the problem that the position and angle can't be modified
##### v1.2 Added circle Extra-Board
##### v1.3 Fixed the visual effect of vertexes of Extra-Board,and the rotate direction is counterclockwise
##### v1.4 Added roundrect Extra-Board,it's a combination of 2 rects and 4 circles.
##### v1.5 You can set more arguments when you use "Battle_CreateBoardExtraRect"(from you can only set width and height to you can set length of up,down,left,right),and fixed a error problem when you destroy several Extra-Boards.