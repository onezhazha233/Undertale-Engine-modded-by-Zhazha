<details>
<summary>UTE渣渣整合版</summary>
## 这啥玩意啊？
### 此为由我修改过的由糖萌芦开发的Undertale Engine，添加了一些原版ute没有的东西。
## 添加了什么？
### 添加了加框和减框，使得你可以使用异形框。
### 添加了由我编写的蓝魂和板子。
### 添加了一些更便利的东西，如绕点旋转函数、获取框中心坐标函数、杂项管理器等。
### 添加了我编写的商店系统
### 修复了原版ute的部分bug。

## 咋用啊？
### 我在脚本里面写了一丁点注释，或许你能看懂吧，再要么上QQ问我。（我并不常用discord）
### 我QQ号是1561536469。
### 哦，要是你够幸运，说不定你可以在discord的ute群聊里面看到我活跃，但别指望我会帮你解决一堆屁事。
## 我找到了bug怎么办？
### 直接在QQ上找我吧，或者在github界面提交问题，我迟早会看的，尽管我并不一定会解决，毕竟我仅仅是整合了代码，而不是我写的。
## 目前已知的问题
### 减框速度太快会把灵魂卡到奇奇怪怪的地方，这个问题来源于ute原生的灵魂限制代码，要修复这个问题可能要重写部分代码所以我放着不管了。
### 灵魂或者加框速度太快会穿过边角，我同样也修不了。
### 减框透明度改变规律出于未知原因是非线性的。
### 在框内绘制图像时设置的透明度变化规律是非线性的，你可以通过将world中

	application_surface_draw_enable(false)

### 设置为true来解决，但修改后边框无法正常工作。或是将battle_board预绘制中

	surface_set_target(_surface);{
		draw_clear_alpha(color_bg,0);
	}surface_reset_target();

### 的0改为1，但修改后无法修改背景透明度。

## 对了，还有感谢名单：
###### 绘制在减框上面的背景效果的代码来自于[Siki]
###### 减框原理+初步实现的代码来自于[穹c啋f汾]，他的b站uid是1438530442
###### 加框原理+完全实现代码由[奇迹丶零]移植入ute，原代码来自Gitee的[jkjkil4]，[奇迹丶零]的b站uid是375539491
###### 由[1个渣渣]整合了这些代码，我的b站uid是25245703
###### 由[Sanesss]等人帮助测试
###### ute由[糖萌芦]编写
###### 新的打字机由[Zean]改造

###### 剩下部分由[1个渣渣]编写

#### 你可以直接检测[global.is_moving]变量来判断灵魂是否在移动（蓝魂滞空时一直都是移动状态）

## 以下是版本更新概要
##### v1.0 最初版本的整合版ute
##### v1.1 框可以修改外框和背景的颜色了，修复了主框无法改变坐标和角度的问题
##### v1.2 添加了圆形加框
##### v1.3 改进了加框顶点连接处的视觉效果，把加框的旋转改为了逆时针
##### v1.4 添加了圆角矩形的加框，本质上是两个矩形和四个圆形的组合
##### v1.5 创建矩形加框的脚本可以设置更多参数了（从只能设置宽窄改成了可以设置上下左右的大小），修复了同时销毁多个加框会报错的问题
##### v1.6 减框从可以设置宽窄改成了可以设置上下左右，也就是和原版ute的主框一样
##### v1.7 用列表替换了存放框的数组，可能完全修复了销毁报错问题
##### v1.8 重写了蓝魂和板子从而修复甩灵魂无效的问题
##### v1.9 可改变框的背景和框架透明度，但减框透明度改变规律出于未知原因是非线性的，设置需谨慎
##### v1.10 增加了菜单文本候选功能，可添加候选文本，游戏会在玩家回合开始时随机选择一个进行显示；增加了获取敌人位置功能，可根据敌人位置来判断对话框创建位置。这两个功能适用于多敌人战斗
##### v1.11 更换了新的打字机，新的打字机支持文字旋转、设置对齐等功能；增加了商店系统
</details>

<details>
<summary>Undertale Engine modded by Zhazha</summary>
## Wat's this?
### It's Undertale Engine by TML which is modded by me,added something that not included in original Undertale Engine.
## Added wat?
### Added Extra-Board and Cover-Board,so you can make various shapes of board.
### Added bluesoul and platform written by me.
### Added something to make you code your game more convenient, such as rotate function, get center positionof board, misc manager.
### Added shop system made by me.
### Fixed some bugs of original ute.

## How to use it properly?
### I wrote some descriptions in the scripts,or you can ask me on QQ.(I don't use discord often)
### My QQ number is 1561536469.
### If you're lucky,maybe you can see me in Undertale Engine Group in discord,but don't expect I would solve your problems.
## I find the bug!
### Tell me on QQ or commit a issue on github,I will see it sooner or later.But I'm not sure I can solve them after all I was just integrated the codes,they are not written by me.
## Known problems
### If speed of Cover-Board is too fast,soul will be wrong position,the problem came from original codes of Undertale Engine,maybe rewrite codes if fix this problem so I left it alone.
### If speed of soul or Extra-Board is too fast,the soul will cross over the edges,I can't fix it too.
### The change of alpha of Cover-Board is nonlinear
### The change of alpha of image which be drawn in board is nonlinear, you can modifiy the code of world object

	application_surface_draw_enable(false)

### set it to true to fix, but the border won't work correctly. or modifiy the code of battle_board in pre draw

	surface_set_target(_surface);{
		draw_clear_alpha(color_bg,0);
	}surface_reset_target();

### set 0 to 1, but you can't change alpha_bg.

## And the credits:
###### Codes to draw background effect are from [Siki].
###### Theory and codes of preliminary implementation of Cover-Board are from [Qcf],his Bilibili UID is 1438530442.
###### Theory and codes of completely implementation of Extra-Board are grafted from [Miracle],the original codes are from [jkjkil4] from Gitee,[Miracle]'s Bilibili UID is 375539491.
###### [Onezhazha] integrated these codes,my Bilibili UID is 25245703.
###### Tested with the help of [saness] et al.
###### Undertale Engine by [TML].
###### New typer adapted from [Zean].

###### Other by [Onezhazha].

### You can detect variable [global.is_moving] directly to judge it's moving or not.(When the bluesoul is in the air,it's always moving)

## Update details
##### v1.0 The frist version of ute modded by zhazha
##### v1.1 You can modify the color of board,and fixed the problem that the position and angle can't be modified
##### v1.2 Added circle Extra-Board
##### v1.3 Fixed the visual effect of vertexes of Extra-Board,and the rotate direction is counterclockwise
##### v1.4 Added roundrect Extra-Board,it's a combination of 2 rects and 4 circles.
##### v1.5 You can set more arguments when you use "Battle_CreateBoardExtraRect"(from you can only set width and height to you can set length of up,down,left,right),and fixed a error problem when you destroy several Extra-Boards.
##### v1.6 Extended arguments of Cover-Board,from [xscale] and [yscale] to [up],[down],[left] and [right],codes are from original ute, in fact.
##### v1.7 Replaced array with list which was made to save the boards,maybe completely fixed the error when you destroy boards.
##### v1.8 Rewrited bluesoul and platform so that fixed bug of unavailing slam soul.
##### v1.9 You can change the alpha of background and frame of board, but the change of alpha of Cover-Board is nonlinear, be careful when you change it.
##### v1.10 Added menu dialog candidate system, you can add multiple dialogs and when an enemy's turn ends(your turn start), random one of dialogs will be displayed; Added some functions to get enemy's position, make you decide where to create battle_dialog_enemy easier. These two systems are suitable to multiple enemies battle.
##### v1.11 Added advanced typer with functions of change the angle and align of text and so on; Added shop system 
</details>