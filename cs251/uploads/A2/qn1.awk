#!/usr/bin/gawk
BEGIN{
	state = 0;
	ans = 0;
	ans2=0;
}
{
	flag = 0;
	if(state==1) flag = 1;
	for(i=1;i<=NF;i++){
		if(state == 0 ){
			if($i ~ /[^"']\/\*/ || $i ~ /^\/\*/ ){
				if($i ~ /\/\*.*\*\// || $i ~ /^\/\*.*\*\//){
					flag=1;
				}
				else {
					state =1;
				}
				flag = 1;
			}
			else if($i ~ /[^"']\/\// || $i ~ /^\/\// ){
				flag=1;
				break;
			}
			else if($i ~ /[^']"/|| $i ~ /^"/){
				if($i ~ /".*"/){
					ans2++;
				}
				else {
					state =2;
				}
			}
			else if($i ~ /'/){
				if($i ~ /'.*'/){
					ans2++;
				}
				else {
					state =3;
				}
			}
			
		}
		else if(state==2){
			if($i ~ /"/){
				state=0;
				ans2++;
			}
		}
		else if(state==3){
			if($i ~ /'/){
				state=0;
				ans2++;
			}
		}
		else if(state==1){
			if($i ~ /\*\//){
				state=0;
			}
		}
		
   }
   if(flag==1){
	   		ans++;
	   }
}
END{
	print ans
	print ans2
}
