echo "-------------------------"
echo "User Name: JeonHwanSeok"
echo "Student Number: 12223810"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "-------------------------"
while :
do
	echo "Enter your choice [ 1-9 ] "
	read choice

	if [ $choice -eq 1 ]; then
		echo "Please enter 'movie id'(1~1682):"
		read movieid
		cat u.item | awk -F'\|' 'NR == "'$movieid'" {print $0}'

	elif [ $choice -eq 2 ]; then
		echo "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n):"
		read two
		if [ "$two" == "y" ]; then
			cat u.item | awk -F'\|' '$7==1 {print $1, $2 > "new_item"}'
			cat new_item | awk 'NR<11 {print $0}'
		fi

	elif [ $choice -eq 3 ]; then
		echo "Please enter 'movie id'(1~1682):"
		read movieid
		cat u.data | awk '$2=="'$movieid'" {print $3 > "new_data"}'
		cat new_data | awk '{sum+=$1;num++} END {printf "average rating of '$movieid': %.5f\n",sum/num}'>new_data_result
		cat new_data_result | awk '{print $0}'

	elif [ $choice -eq 4 ]; then
		echo "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n):"
		read four
		if [ "$four" == "y" ]; then
			cat u.item | awk -F'\|' 'NR<11 {print $1"|"$2"|"$3"|"$4"|"$6"|"$7"|"$8"|"$9"|"$10"|"$11"|"$12"|"$13"|"$14"|"$15"|"$16"|"$17"|"$18"|"$19"|"$20"|"$21"|"$22"|"$23"|"$24}' > del_item
			cat del_item
		fi

	elif [ $choice -eq 5 ]; then
		echo "Do you want to get the data about users from 'u.user'?(y/n):"
		read five
		if [ "$five" == "y" ]; then
			cat u.user | awk -F'\|' 'NR<11 {print $0}' > new_user
			sed 's/M/male/' new_user > new_user2
			sed 's/F/female/' new_user2 > new_user3
			cat new_user3 | awk -F'\|' '{print "user",$1,"is",$2,"years old",$3,$4}'
		fi

	elif [ $choice -eq 6 ]; then
		echo "Do you want to Modify the format of 'release data' in 'u.item'?(y/n):"
		read six
		if [ "$six" == "y" ]; then
			cat u.item | awk 'NR>1672 {print $0}' > new_item
			sed 's/01-Jan-1995/19950101/' new_item > new_item1
			sed 's/01-Jan-1962/19620101/' new_item1 > new_item2
			sed 's/25-Oct-1996/19961025/' new_item2 > new_item3
			sed 's/01-Jan-1996/19960101/' new_item3 > new_item4
			sed 's/20-Sep-1996/19960920/' new_item4 > new_item5
			sed 's/06-Feb-1998/19980206/' new_item5 > new_item6
			sed 's/01-Jan-1998/19980101/' new_item6 > new_item7
			sed 's/01-Jan-1994/19940101/' new_item7 > new_item8
			sed 's/08-Mar-1996/19960308/' new_item8 > new_item9
			cat new_item9
		fi
	
	elif [ $choice -eq 7 ]; then
		echo "Please enter the 'user id'(1~943):"
		read userid
		cat u.data | awk '$1=="'$userid'" {print $2}' > new_data
		cat new_data | sort -n -t "|"
		cat new_data | awk 'NR<11 {print $0}' > new_data_2

	elif [ $choice -eq 9 ]; then
		echo "Bye!"
		break
	fi
done
