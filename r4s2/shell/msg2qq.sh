#!/bin/bash


http_address="$(cat /tmp/r4s2/onebot_address):$(cat /tmp/r4s2/onebot_port_http)"

type_exists(){
	if [ ! "$p_msg" ]; then
		help
		exit 0
	fi
}

upload_file(){

	declare -g path=$(curl -X POST $http_address/upload_file \
	-H "Content-Type: multipart/form-data" \
	-F "file=@$p_file" -s |jq -r '.data' | jq -r '.file')

	echo "文件在服务器缓存中的路径:  $path"

	if [ "$path" = "null"  ]; then
		echo "响应文本流中没有检索到键值 \"data\" \"file\""
		exit 0
	fi

	echo "缓存路径: \"$path\""

	if [ ! "$p_n" ]; then
		p_n=$(echo "$p_file" | rev | cut -d '/' -f1 | rev)
	fi

	echo "文件的标注名称: \"$p_n\""
}

upload_img(){

	declare -g path=$(curl -X POST $http_address/upload_file \
	-H "Content-Type: multipart/form-data" \
	-F "file=@$p_img" -s |jq -r '.data' | jq -r '.file')

	echo "文件在服务器缓存中的路径:  $path"

	if [ "$path" = "null"  ]; then
		echo "响应文本流中没有检索到键值 \"data\" \"file\""
		exit 0
	fi

	echo "缓存路径: \"$path\""

	if [ ! "$p_n" ]; then
		p_n=$(echo "$p_img" | rev | cut -d '/' -f1 | rev)
	fi
}

help() {
	echo -e "	-h			打印命令详细信息" 1>&2
	echo -e	"	-t [整数]		必须的：\n					目标QQ号或群号" 1>&2
	echo -e "	-g			这是一个群聊类型的消息" 1>&2
	echo -e "	-n [字符串]		可选的：\n					文件的标注名称，留空以使用本机的本地文件名称" 1>&2

	echo -e "\n	至少需要指定一个'操作类型'选项"
	echo -e "		-f [文件路径]		操作类型：发送一个文件" 1>&2
	echo -e "		-s [字符串]		操作类型：发送文本消息\n					要发送的文本" 1>&2
	echo -e "		-i [图片路径]		操作类型：发送图片消息\n					要发送的图片" 1>&2
}

# 默认是私聊类型，发送私聊消息
while getopts "ht:gf:n:s:i:" opt; do
	case ${opt} in
		h)
			help
			exit 0
			;;
		t)
			p_t="$OPTARG"
			;;
		g)
			group_msg=true
			;;
		f)
			p_file="$OPTARG"
			;;
		n)
			p_n="$OPTARG"
			;;
		s)
			p_msg="$OPTARG"
			;;
		i)
			p_img="$OPTARG"
			;;
		\?)
			help
			echo -e "\n\n必须指定一个参数" >&2
			exit 0

			;;
		:)
			echo -e "\n\n需要一个参数！	使用 -h 选项来获取帮助"
			exit 0
			;;
	esac
done

shift $((OPTIND -1))

#echo "参数1: $p_t"
#echo "参数2: $group_msg"
#echo "参数3: $p_file"
#echo "参数4: $p_n"
#echo "参数5: $p_msg"
#echo "参数6: $p_img"

#echo "剩余参数: $@"

if [ "$group_msg" ]; then
	echo -e "[群聊消息]"
	if [ "$p_file" ]; then
		# 先从本地上传到服务器
		upload_file

		curl -X POST $http_address/upload_group_file \
		-H "Content-Type: application/json" \
		-d "{\"group_id\": \"$p_t\",\"file\":\"$path\", \"name\":\"$p_n\"}"
    echo -e "\n"
		exit 0
	elif [ "$p_msg" ]; then
		type_exists

		curl -X POST $http_address/send_group_msg \
		-H "Content-Type: application/json" \
		-d "{\"group_id\": \"$p_t\",\"message\":\"$p_msg\"}"
    echo -e "\n"
		exit 0
	elif [ "$p_img" ]; then
		# 先从本地上传到服务器
		upload_img

		curl -X POST $http_address/send_group_msg \
		-H "Content-Type: application/json" \
		-d "{\"group_id\":\"$p_t\",\"message\":{\"type\":\"image\",\"data\":{\"file\":\"file://$path\"}}}"
    echo -e "\n"
		exit 0
	fi
	help
	echo -e "\n\n至少需要指定一种操作类型！"
else
	echo -e "[私聊消息]"
	if [ "$p_file" ]; then
		# 先从本地上传到服务器
		upload_file

		curl -X POST $http_address/upload_private_file \
		-H "Content-Type: application/json" \
		-d "{\"user_id\": \"$p_t\",\"file\":\"$path\", \"name\":\"$p_n\"}"
		exit 0
    echo -e "\n"
	elif [ "$p_msg" ]; then
		type_exists

		curl -X POST $http_address/send_private_msg \
		-H "Content-Type: application/json" \
		-d "{\"user_id\": \"$p_t\",\"message\":\"$p_msg\"}"
    echo -e "\n"
		exit 0
	elif [ "$p_img" ]; then
		# 先从本地上传到服务器
		upload_img

		curl -X POST $http_address/send_private_msg \
		-H "Content-Type: application/json" \
		-d "{\"user_id\":\"$p_t\",\"message\":{\"type\":\"image\",\"data\":{\"file\":\"file://$path\"}}}"
    echo -e "\n"
		exit 0
	fi

	help
	echo -e "\n\n至少需要指定一种操作类型！"

fi
