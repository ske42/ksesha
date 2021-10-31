#!/usr/bin/bash
echo ${@}
[[ -z $(echo $2 |egrep -o '.jpg|jpeg') ]] && echo это не картинка && exit 1
TEXT=${1}
FILE=${2}
FONTSIZE=${4}
FONT=${5}
[[ -z ${FONTSIZE} ]] && FONTSIZE=40

#----
file_name=$(echo ${FILE}|cut -d. -f1)
# Здесь позиционируем текст, я заебся подбери как прально
image_size=$(identify ${FILE}\
 |grep -oE ' [0-9]{1,4}x[0-9]{1,4} ')
w=$(echo $image_size|cut -dx -f2)
h=$(echo $image_size|cut -dx -f1)
text_len=$(echo ${TEXT}|wc -m)
char_len=$(( ${FONTSIZE}/2))
dw=$(( ${w} - (${text_len} * ${char_len} ) ))
[[ ${dw} -le 0 ]] && dw=0
dh=$(( ${h} - ${FONTSIZE} ))
#-----
convert ${FILE} -pointsize ${FONTSIZE} \
-annotate 0x0+${dw}+${h}\
  ${TEXT} ${file_name}_anotate.jpg

# 5=25
# 4=53
# 3=80
# 2=98
# 1= 110
