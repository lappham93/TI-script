#!/bin/sh

IFS=';' #setting space as delimiter  
LANG='PHP và Vuejs'
read -ra AOW <<<"$1" #reading str as an array as tokens separated by IFS  


echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Nhận yêu cầu sản xuất phần mềm sử dụng ngôn ngữ lập trình $LANG để phát triển $i."
done 

echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Phân tích và thiết kế màn hình theo yêu cầu đặc tả từ phía khách hàng để phát triển $i."
done

echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Viết mã lệnh bằng ngôn ngữ lập trình $LANG sử dụng yêu cầu đặc tả của khách hàng để phát triển $i."
done

echo ""
for i in "${AOW[@]}"; #accessing each element of array  
do  
echo "Tạo và chạy kịch bản kiểm thử cho $i."
done
