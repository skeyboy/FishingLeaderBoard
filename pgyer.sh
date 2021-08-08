#!/bin/bash
location=$(pwd)
echo "清理……"
file="${location}/build/FishingLeaderBoard.ipa"
rm -rf "${file}"
echo "打包……"
fastlane fish
echo "打包完成，准备上传……"
#file="@${location}/build/FishingLeaderBoard.ipa"
#echo "${file}"
#curl -F "file=${file}" -F "_api_key=26c2b54eda974d583ffc7893079df776" -F "buildPassword=123456" -F "buildInstallType=2" https://www.pgyer.com/apiv2/app/upload

echo "上传完成……"
open -a "/Applications/Safari.app" https://www.pgyer.com/BRLc
