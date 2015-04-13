#!/bin/bash
# FileName:makeGif.sh
# Author:liutianhao.pro@gmail.com

#工作目录
localpath="/home/popo/picture/recordMyDesktop"
#把录像文件拿到工作目录下
mv ~/out.ogv $localpath
#分解成多张jpg
mplayer -ao null $localpath/out.ogv -vo jpeg:outdir=$localpath
#多张jpg合成一张gif图片
convert $localpath/*.jpg $localpath/out.gif
#压缩gif图片
convert $localpath/out.gif -fuzz 10% -layers Optimize $localpath/optimized.gif
#清理
rm $localpath/*.jpg -f
rm $localpath/out.ogv -f
rm $localpath/out.gif -f
