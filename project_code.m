%Throughput comparison of OMA and user pairing based NOMA scheme


clf;
thrpt = 0;
pow = 0;
d = [];
totalUsers = 200;


%generate distance as written in article


%decide dmin and dmax
dmin = 5; 
dmax = 10;


for i = 1 : totalUsers
    d(i) = generateRandCust(dmax,dmin);
end
%according to article, Pi/N0 = L2d^(-L1)
%take L1 = 3, L2 = 1000 as example
%N0 = 1

N0 = 1;
L1 = 3;
L2 = 1000;
P = [];
thrptArr = [];
P = (N0*L2).*(d.^(-L1));
P1 = sort(P);


printf("Max after sorting : %d", max(P));
userGrps = []; 

for i = 1 : (totalUsers/2)
    for j = 1 : 2
        if j==1
            userGrps(i,j) = P1(i);
        else
            userGrps(i,j) = P1(totalUsers-i+1);
        end
    end
end

for noOfUserGrp = 1 : totalUsers/2
  thrpt = 0;  
  for i = 1 : noOfUserGrp
   pow = 0;  
   for j = 1 : 2
      pow += userGrps(i, j);
   end
    thrpt +=  (log10( 1 + noOfUserGrp*pow))/(log10(2));
    
  end
  thrptArr(noOfUserGrp) = (1/noOfUserGrp)*thrpt;
end
thrptArr
plot([2:2:totalUsers],thrptArr, '-x', "markersize", 1.1);
hold on;


%OMA

thrptOmaArr = [];
thrptOma = 0;


%new scheme
counter1 = 1;
userGrps1 = [];
userGrps
for ii = 1 : (totalUsers/2)
    for jj = 1 : 2
        if jj==1
            userGrps1(counter1) = userGrps(ii, jj);
        else
            userGrps1(counter1) = userGrps(ii, jj);
        end
        counter1++;
    end
end

userGrps1

for totalUserCount = 1 : totalUsers
  for i = 1 : totalUserCount
      
    thrptOma += log10((1+(totalUserCount*userGrps1(i))))/log10(2);
  end   
  thrptOmaArr(i) = (1/totalUserCount)*thrptOma;
  thrptOma = 0; 
end
thrptOmaArr
size(thrptOmaArr)
plot([2:2:totalUsers],thrptOmaArr(2:2:totalUsers) ,"o-", "markersize", 1.1);
xlabel('number of users');
xlim([2 totalUsers]);
ylabel('system throughput(bits/symbol)');
legend('proposed scheme', 'OMA');

title("Throughput comparison");
