#!/usr/bin/gawk
BEGIN{
}
function extract_IP(IP)
{
       split(IP, ip, /\.[0-9]+$/);
       return ip[1]          
  
}
function extract_PORT(IP)
{
       split(IP, ipxx, /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\./);
       return ipxx[2]          
  
}
function solve(conn){
	retransmitted[conn]++;
	retransmitted[conn]--;
	if(tr[conn]!=1){
		len[conn]=0;
		return;
	}
	end = -1;
	n = asorti(ans[conn], dest)
	for ( x in dest){
		i=dest[x];
		if(i>=end){
			end = ans[conn][i];
		}
		else if(ans[conn][i]>=end){
			retransmitted[conn]+=end-i;
			end = ans[conn][i];
		}
		else{
			retransmitted[conn]+=ans[conn][i]-i;
		}
	}
}
func subx(x,y){
	split(x,xhms,/:/);
	split(y,yhms,/:/);
	return 3600*(xhms[1]-yhms[1])+60*(xhms[2]-yhms[2])+(xhms[3]-yhms[3]);
}
function pri(A,B,conn){
	solve(conn);
	print packets[conn],"  ",data_packets[conn],"  ",len[conn]," ",retransmitted[conn];
	tim = subx(t2[conn],t1[conn]);
	xput = (len[conn]-retransmitted[conn])/tim;
	print xput;
}
{
	if($8 ~ /seq/ && $NF !=0 ){
		conn = $3" "$5;
		packets[conn]++;
		data_packets[conn]++;
		split($9,s,/:/);
		split(s[2],t,/,/);
		len[conn]+=$NF;
		ans[conn][s[1]]++;
		ans[conn][s[1]]--;
		if(ans[conn][s[1]]!=0){
			if(ans[conn][s[1]]>t[1]){
				retransmitted[conn]+=t[1]-s[1];
			}
			else{
				retransmitted[conn]+=ans[conn][s[1]]-s[1];
				ans[conn][s[1]] = t[1];
			}
		}
		else {
			ans[conn][s[1]] = t[1];
		}
		tr[conn]=1;
		if(chkk[conn]!=1){
			t1[conn]=$1;
			t2[conn]=$2;
			chkk[conn]=1;
		}
		else {
			if(subx($1,t1[conn])<0){
				t1[conn] = $1;
			}
			else if(subx($1,t2[conn])>0){
				t2[conn] = $1;
			}
		}
	}
	else{
		conn = $3" "$5;
		packets[conn]++;
		data_packets[conn]++;
		data_packets[conn]--;
		if(chkk[conn]!=1){
			t1[conn]=$1;
			t2[conn]=$2;
			chkk[conn]=1;
		}
		else {
			if(subx($1,t1[conn])<0){
				t1[conn] = $1;
			}
			else if(subx($1,t2[conn])>0){
				t2[conn] = $1;
			}
		}
	}
}
END{
	for (conn in packets){
		if(done[conn]==1){
			continue;
		}
		split(conn,ips,FS);
		A = ips[1];
		split(ips[2],ips2,/:/);
		B = ips2[1];
		
		reverse_setup = B" "A":"ips2[2];
		done[reverse_setup] = 1;
		print "Connection (A =", extract_IP(A),":",extract_PORT(A),"B = ",extract_IP(B),":",extract_PORT(B),")";
		print "--------------------";
		print " ";
		print "A-->B";
		pri(A,B,conn);
		print " ";
		print "B-->A";
		pri(B,A,reverse_setup);

	}
}