#!/bin/bash

#选择打包版本（Y：test环境）
echo -n "Do you want to test version?y/n"
read isTest

CHANNELID=(appstore)
for ((i=0;i<${#CHANNELID[@]};i++))
do

#工程绝对路径
project_path=$(pwd)


#编译的configuration，默认为Release
build_config=Release

param_pattern=":nc:o:t:ws:"
OPTIND=2
while getopts $param_pattern optname
do
case "$optname" in
"n")
should_clean=y
;;
"c")
tmp_optind=$OPTIND
tmp_optname=$optname
tmp_optarg=$OPTARG
OPTIND=$OPTIND-1
if getopts $param_pattern optname ;then
echo  "Error argument value for option $tmp_optname"
exit 2
fi
OPTIND=$tmp_optind

build_config=$tmp_optarg

;;
"o")
tmp_optind=$OPTIND
tmp_optname=$optname
tmp_optarg=$OPTARG

OPTIND=$OPTIND-1
if getopts $param_pattern optname ;then
echo  "Error argument value for option $tmp_optname"
exit 2
fi
OPTIND=$tmp_optind

cd $tmp_optarg
output_path=$(pwd)
if [ ! -d $output_path ];then
echo "Error!The value of option o must be an exist directory."
exit 2
fi

;;
"w")
workspace_name='*.xcworkspace'
ls $project_path/$workspace_name &>/dev/null
rtnValue=$?
if [ $rtnValue = 0 ];then
build_workspace=$(echo $(basename $project_path/$workspace_name))
else
echo  "Error!Current path is not a xcode workspace.Please check, or do not use -w option."
exit 2
fi

;;
"s")
tmp_optind=$OPTIND
tmp_optname=$optname
tmp_optarg=$OPTARG

OPTIND=$OPTIND-1
if getopts $param_pattern optname ;then
echo  "Error argument value for option $tmp_optname"
exit 2
fi
OPTIND=$tmp_optind

build_scheme=$tmp_optarg

;;
"t")
tmp_optind=$OPTIND
tmp_optname=$optname
tmp_optarg=$OPTARG

OPTIND=$OPTIND-1
if getopts $param_pattern optname ;then
echo  "Error argument value for option $tmp_optname"
exit 2
fi
OPTIND=$tmp_optind

build_target=$tmp_optarg

;;


"?")
echo "Error! Unknown option $OPTARG"
exit 2
;;
":")
echo "Error! No argument value for option $OPTARG"
exit 2
;;
*)
# Should not occur
echo "Error! Unknown error while processing options"
exit 2
;;
esac
done


#build文件夹路径
build_path=${project_path}/build
#生成的app文件目录
appdirname=Release-iphoneos
if [ $build_config = Debug ];then
appdirname=Debug-iphoneos
fi
if [ $build_config = Distribute ];then
appdirname=Distribute-iphoneos
fi
#编译后文件路径(仅当编译workspace时才会用到)
compiled_path=${build_path}/${appdirname}

#是否clean
if [ "$should_clean" = "y" ];then
xcodebuild clean
fi

xcodebuild clean

#组合编译命令
build_cmd='xcodebuild'

if [ "$build_workspace" != "" ];then
#编译workspace
if [ "$build_scheme" = "" ];then
echo "Error! Must provide a scheme by -s option together when using -w option to compile a workspace."
exit 2
fi

build_cmd=${build_cmd}' -workspace '${build_workspace}' -scheme '${build_scheme}' -configuration '${build_config}' CONFIGURATION_BUILD_DIR='${compiled_path}' ONLY_ACTIVE_ARCH=NO'

else
#编译project
build_cmd=${build_cmd}' -configuration '${build_config}
if [ "$build_target" != "" ];then
build_cmd=${build_cmd}' -target '${build_target}
fi

fi



#编译工程
cd $project_path

#app文件名称
appname=$(basename ./${appdirname}/*.app)

#app文件中Info.plist文件路径
app_infoplist_path=${build_path}/${appdirname}/${appname}/Info.plist

#更新项目plist文件
updateplist= $(/usr/libexec/PlistBuddy -c "set :channelid ${CHANNELID[$i]}" ${project_path}/BoXiu/BoXiu-Info.plist)
if [ "$isTest" = "y" ];then
updateplist= $(/usr/libexec/PlistBuddy -c "set :Test_Version YES" ${project_path}/BoXiu/BoXiu-Info.plist)
else
updateplist= $(/usr/libexec/PlistBuddy -c "set :Test_Version NO" ${project_path}/BoXiu/BoXiu-Info.plist)
fi

$build_cmd || exit

#进入build路径
cd $build_path

mkdir ipa-build

#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${app_infoplist_path})

#取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${app_infoplist_path})

#通过app文件名获得工程target名字
target_name=$(echo $appname | awk -F. '{print $1}')

#IPA名称
#ipa_name="${target_name}_${bundleShortVersion}_${build_config}${bundleVersion}_$(date +"%Y%m%d")"
#ipa_name="${bundleShortVersion}_${build_config}${bundleVersion}_${CHANNELID[$i]}"
ipa_name="${build_config}${bundleVersion}_${CHANNELID[$i]}"

#xcrun打包
xcrun -sdk iphoneos PackageApplication -v ./${appdirname}/*.app -o ${build_path}/ipa-build/${ipa_name}.ipa || exit

cp ${build_path}/ipa-build/${ipa_name}.ipa ~/Desktop/${ipa_name}.ipa
rm -rf ${build_path}
cd $project_path
echo "Copy ipa file successfully to the path $output_path/${ipa_name}.ipa"

done
