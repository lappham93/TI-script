#!/bin/sh

IFS=';' #setting space as delimiter  
read -ra AOW <<<"$1" #reading str as an array as tokens separated by IFS  


echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Nhận yêu cầu sản xuất phần mềm sử dụng ngôn ngữ lập trình Nodejs, Vuejs để $i"
done 

echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Thiết kế màn hình dựa vào yêu cầu đặc tả màn hình từ phía khách hàng để $i"
done

echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Mã lệnh bằng ngôn ngữ lập trình Nodejs, Vuejs sử dụng yêu cầu đặc tả của khách hàng để $i"
done

echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Kiểm tra chạy thử kịch bản kiểm thử và tạo kịch bản để $i"
done
