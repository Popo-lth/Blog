#使用VIM

---

为什么有那么多编辑器我要使用vim？因为当我想保存文件时总是习惯性的：wq，即使我正在使用eclipse什么的~

其实使用熟练使用vim可以让你完全摆脱鼠标，摆脱小键盘，摆脱方向键，你的手不用离开那块键盘区域就能完成你能想到的任何事情。

不过vim并不算是个很友好的编辑器，刚开始使用你会觉得它十分特别非常极其的操蛋。你会想怎么会有人用这种东西，还不如notepad，不如gedit，更不如我比较喜欢用的sublime Text。但是如果你强迫自己使用一到两周后慢慢你会发现这东西真是让人爱不释手。

刚开始使用这货的时候，也是各种蛋疼~去看各种VIM命令大全，VIM命令手册等等的吧，收效甚微，看了也记不住。后来慢慢觉得命令不是看会的，而是用会的。不要去记那些命令是什么，而是当你需要什么样的命令时再去找这样的命令，甚至你可以创造一个这样的命令。

##VIM的三种模式

不过基本的还是要稍微介绍一下的。比如vim的模式。一打开vim什么都不动就是普通（Normal）模式，这个时候是不能输入的，刚开始用你会觉得妈的打开个编辑器还不让我写。不要着急~按一下i就可以插入了，这时候就进入了编辑（Insert ）模式。退出编辑模式可以使用[ESC]，按下[ESC]后回到Normal模式，这时候输“：”就会进入命令模式了，比如：q是退出。现在使用这个命令应该是退不出来了，因为已经编辑了，所以可以使用：q！，加上感叹号之后可以强制命令执行，当然你要是想保存的可以使用：wq，w是写入，q是退出，写入之后就可以退出了吧。执行以下卧槽还不行，木有文件名，vim也不知道写到哪里啊，跟上文件名，使用：wq filename，这个时候就能退出了，这时候当前目录下就会出现名字为filename的文件了，cat一下就是你刚才写的内容，当然你要是毛都没写那在：q的时候就退出了~

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.01.gif?raw=true)

小节：三种模式，普通模式，编辑模式，命令模式，普通模式可以使用一下快捷键，命令模式可以使用命令，比如刚才的w和q，编辑模式就不啰嗦了。

##光标移动命令

了解了vim的模式可以用了吧？不行~你是不知道怎么移动光标呢。。。那用方向键不行吗？可以是可以的~但是这样手要移动的距离就远了，效率不高了。vim有很多移动光标用的快捷键，也有很多类似的命令，这里可能介绍不全，太多了，我只说我常用的。

h，j，k，l 这四个键就是移动光标用的快捷键，当然要记得快捷键是在普通模式下用的。用之前可以习惯性按一下[ESC]，h在最左边，所以h是左移，l在最右边，所以l是右移，j有个钩，看上去就是个下移的货，K就只能上移了，快来试一下吧。除了这几个快捷键还有很多

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.02.jpg?raw=true)

随便试几下，感受一下，刚开始肯定不习惯，但是一定要管住自己的手，不要去使用方向键，慢慢去习惯。当然移动光标的方法有很多。

常用快捷键： 

|命令|说明|
|:---|:---|
|gg|移动到文件开头|
|G|移动到文件末尾|
|Ctrl + e|向下滚动一行|
|Ctrl + y|向上滚动一行|
|Ctrl + d|向下滚动半个屏幕|
|Ctrl + u|向上滚动半个屏幕|
|Ctrl + f|向下滚动一个屏幕|
|Ctrl + b|向上滚动一个屏幕|
|-(减号)|移动到上面一行的开始|
|\+ / ENTURN(回车)|移动到下面一行的开始|
|^ / 0|移动到行开头|$|移动到行末尾|
|w|向右移动一个单词|
|W|向右移动一个以空格为分隔符的单词|
|b|向左移动一个单词|
|B|向左移动一个以空格为分隔符的单词|
|e|向右移动到一个单词的结尾|
|E|向右移动到一个以空格为分隔符的单词的结尾|
|t(c)|向右移动到指定字符(c)之前的一个字符|
|T(c)|向左移动到指定字符(c)之后的一个字符|
|f(c)|向右移动到指定字符(c)|
|F(c)|向左移动到指定字符(c)|
|numG|移动到第num行(与：num类似)|
|H / M / L|移动到屏幕 顶部 / 中部 / 底部|
|``(ESC下面那个按键)|光标回到之前的位置|

这些快捷键不需要一次都记住，看个大概就好，差不多知道有哪些功能就行，等到需要用了回来找一下，然后去用，这样印象深刻才能记得住。上面的快捷键中可能w,b,e三个快捷键的大小写的功能有点绕，用个图片来说明一下，w和W之间的却别，b，e两个与w类似，建议自己尝试一下。

**使用w（小写）**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.02.gif?raw=true)

**使用W（大写）**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.03.gif?raw=true)

常用命令：

+ :num（行号）     比如:15就是跳到15行的第一个字符
+ :$                       移动到文件末尾

说到这再啰嗦一句，要分清楚命令和快捷键，命令要先进入命令模式，也就是先按“ : ”然后输入命令。快捷键是在普通模式下，也就是按完ESC之后可以直接按键。

脱离了方向键的束缚这下可以让你的双手安安心心的放在主键盘区域了。现在学会了模式切换稍微回顾一下：

+ [ ESC ]进入普通模式，可以使用快捷键。
+ [ : ]冒号进入命令模式，可以使用命令。
+ [ i ]进入编辑模式，可以编写文本。

学会模式切换，光标移动，还有基本命令就可以编写文本或者程序了，只是效率还不够高，用起来不太方便。没关系，慢慢来，弄VIM这事一定不能急，我第一次用的时候差点把键盘砸了。

##添加和修改文本

要想给文件添加文本就要进入编辑模式（其实也不一定），进入编辑模式的快捷键可不只是i。

+ i / I        在光标前插入  /  在该行第一个非空白字符前插入
+ a / A     在光标后插入  /  在该行行尾插入
+ o / O    在当前行的下面新建一行  /  在当前行的上面新建一行
+ r / R     替换光标指定的字符（一次替换一个）  /   替换从当前光标所在的字符开始，直到按ESC键结束

这四个字母的效果都比较简单，可以自己试一下，这里演示一下 r 和 R 。

**使用r（小写）**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.04.gif?raw=true)

**使用R（大写）**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.05.gif?raw=true)

这四个字母除了 r 和 R 都能使VIM进入编辑模式。编写代码或者文本还需要不断地修改或者删除文本，VIM有各种各样的删除快捷键和命令。

+ x / X           删除光标所在字符 /  删除光标前面一个字符

这个两个快捷键都可以通过连续按键达到持续删除的效果，要注意看光标所在字符。

**使用x（小写）**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.06.gif?raw=true)

**使用X（大写）**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.07.gif?raw=true)

可以看出来 x（小写）会删掉光标所在字符， X （大写）则不会。当然要是觉得连续按不方便可以直接在前面加重复因子，说得这么高大上，其实就是在前面加数字比如：6x 就是相当于按6次x，效果就是删掉6个字符了。前面的数字可以很大不局限于一位数，比如99x也可以的，不过我觉得十以上的你也不会一个字符一个字符的数到你想删除的地方吧。小心眼花~

再看两个字母 c / C 和 d / D 

这两个字母的用法差不多，效果也差不多，稍微有点区别的就是使用 c / C 相关的快捷键后会直接从命令模式进入编辑模式，而 d / D 相关的则依然停留在普通模式。

+ cc / dd                    删除一整行
+ C, c$ / D, d$           从光标当前位置删除到行尾

cc / dd 也是可以使用重复因子的，比如：5cc / 5dd

在删除多行时除了使用上面的快捷键之外还可以使用命令。

+ :num1,num2d          删除行号num1和num2之间的所有行，包含num1和num2。（命令要在命令模式下使用，先按“ : ”）

注意 c$ / d$ 是 d / c 与另一个快捷键 $ 的结合，$ 的作用是把光标移到行尾，所以联想一下别的移动快捷键组合一下：

+ c0, c^ / d0, d^
+ cw / dw      
+ cW / dW
+ ce / de
+ ...

这种快捷键还有很多，你可以自己来尝试组合，并观察效果。

(c)代表一个字符

+ ct(c) / dt(c)        从光标当前位置删除到当前行的下一个字符(c)，不包括(c)。
+ cf(c) / df(c)        从光标当前位置删除到当前行的下一个字符(c)，包括(c)。

这里交叉演示一下ct(c) 和 df(c) ，除了要看清 t 和 f 的区别，还要注意之前说的 c 和 d 的区别。当然也可以使用 T 和 F ，方向相反而已。

**使用ct<**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.08.gif?raw=true)

**使用df<**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.09.gif?raw=true)

**注意字符“ < ”的删除情况和左下角显示的“插入”，这表示VIM进入了编辑模式。**

+ s / S         删除当前字符并进入编辑模式（相当于快捷键 x + i 的组合） /  删除当前行并进入编辑模式（相当于快捷键组合dd + O）

这两个命令也是可是使用重复因子的，具体效果自己尝试。

改变字母的大小写也是比较常见的需求，所以VIM当然会有对应的快捷键。

+ ~              光标所在字符变成大写或小写，与字母原状态相反。并且光标右移。
+ gu / gU   

这个“ ~ ”同样可以使用重复因子，但是我还是不喜欢去数字符，所以连续按就好了。

gu 和 gU可以像c 和 d 一样在后面加移动快捷键，把当前位置到指定位置的字母全部改变，比较直观的是gu就是变成小写，gU是变成大写。比如gu\$ / gU\$

##复制与粘贴

复制快捷键y和d有点相似：

+ yy, Y          复制当前行
+ y0, y^       
+ y$
+ ...

跟 d 差不多，同样可以在前面加重复因子，同样可以接移动快捷键，具体效果自己yy吧。而且复制多行的命令也类似：

+ :num1,num2y          复制行号num1和num2之间的所有行，包含num1和num2。（命令要在命令模式下使用，先按“ : ”，其实我这条也是从前面 yy 过来的）

粘贴快捷键 

p / P       粘贴至光标后，若复制整行则粘贴在当前行的下面。 /   粘贴至光标前，若复制整行则粘贴在当前行的上面。

其实不只是 yy  后可以使用 p / P，dd之后也是可以的，你就当成是剪切吧。

**快捷键组合 dd + j + j + p**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.10.gif?raw=true)

##搜索与替换（命令）

搜索命令

+ :/rexp                      向前搜索rexp
+ :?rexp                      向后搜索rexp
+ :n                              重复最近一次搜索 
+ :N                             重复最近一次搜索，但方向相反
+ :/                              向前重复最近一次搜索
+ :？                            向后重复最近一次搜索
+ :%                             查找对应的括号如：(  ) , [  ] , {  }

替换命令

替换命令的通用格式是   :[address]s/old/new[/gc]


+ address                 行编号或者由都好分割的两个行编号，" . "代表当前行，" $ "代表最后一行，" % "代表全文，默认为当前行。
+  old / new              被替换的字符串 / 替换后的字符串
+ c                             替换前是否需要确认
+ g                             全局替换，每行不止替换一处。

**比如使用   :%s/class/Class/gc**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.11.gif?raw=true)

**也可以用来做注释用。 :%s/^/#/g**


![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.12.gif?raw=true)

##区块模式

首先按esc进入命令行模式下，按下Ctrl + v，进入列（也叫区块）模式；在行首使用上下键选择需要注释的多行。

然后可以进行删除或者插入等操作，比如也来个多行注释吧。

选择多行后按 I （大写），然后写注释符号，按下ESC，稍等一下注释就出来了。

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.13.gif?raw=true)

##其他快捷键和命令

VIM还有很多快捷键和命令，这里不可能说全，[如图](http://coolshell.cn//wp-content/uploads/2009/03/vim.png)

下面在列举几个常用的吧。


+ J（大写）                将当前行与下一行连接起来
+ .                                重复上一次命令
+ u                               撤销（可连续使用）
+ Ctrl + r                    取消上一次撤销（可连续使用）
+ Ctrl + P / Ctrl + n  插入模式下使用的快捷键，补全一个词，p是向上搜索，n是向下搜索。
+ Ctrl + xl                   插入模式下使用的快捷键，补全一行，Ctrl + P / Ctrl + n 选择上一个或者下一个匹配。

**使用快捷键组合 J + . (连续三次) + u(连续四次) + \[Ctrl + r\]\(连续四次\)**

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.14.gif?raw=true)

**使用Ctrl + P / Ctrl + n 和 使用Ctrl + xl **

![enter image description here](https://github.com/Popo-lth/Blog/blob/master/img/howtousevim/vim.20140525.15.gif?raw=true)

命令

+ :w ， :w filename， :q! ， :wq          这四个命令前面都说过了，不再赘述。 
+ :x                将工作缓存区内容写入当前文件并退出（与快捷键 ZZ 相同），功能与 :wq 相同。
+  :sp / :vsp   横向分屏，竖向分屏。
+  :e                打开另一个文件
+ :ls                查看已经打开的文件。
+ :!bash         执行shell命令

关于分屏和打开多文件建议查看博客：[http://coolshell.cn/articles/11312.html](http://coolshell.cn/articles/11312.html)

终极命令 **:help**

##配置文件

可以通过对VIM配置文件进行修改来达到打开自动配置的效果。比如显示行号。一般修改当前用户的配置文件就可以了，路径" ~/.vimrc "，如果文件不存在可以新建一个。

```
set ts=4
set expandtab
set ai
set nu
let mapleader=","
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
```

这是一份非常简单的配置文件。里面配置了tab是4个空格，自动缩进，显示行号等等~还有映射。通过映射我们可以设计自己的命令。通过配置文件也可以配置VIM的插件，VIM的插件系统可是十分强大，足够让你打造一个完美的开发环境。快去尝试吧。﻿


