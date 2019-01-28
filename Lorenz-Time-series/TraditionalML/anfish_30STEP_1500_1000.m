TS = LTS(2900:5500,1);
DataSize = 2500;
TrainSize = 1500;
TestSize = 1000;
for i=91:2590
    M(i-90,:) = [TS(i-90,1) TS(i-60,1) TS(i-30,1) TS(i,1)];
end
TrainP = M(1:TrainSize,:);
TestP = M(TrainSize+1:DataSize,:);
TestTime = 45.01:0.01:55.00;
N =2500;  %%N show the sample data(training data)
n =3;   %%p show the number of input data 
U =zeros(N, n+1);
aa1=M;
U=M;
minU=min(U);
maxU=max(U);
for i=1:size(U,2)
    Pn(:,i)=(U(:,i)- minU(i))./(maxU(i)-minU(i));
end
N=TrainSize;
Nt=DataSize;
NT=TestSize;
Pn=aa1
p=3;
trnN=Pn(1:N,1:p);
CekN=Pn(N+1:Nt,1:p);
S1=trnN;
ST=CekN;
OUTT=Pn(N+1:Nt,p+1);
Ea=zeros(1,NT);
Eo=zeros(1,NT);
Out=Pn(1:N,p+1);

trnN=Pn(1:N,1:p);
CekN=Pn(N+1:Nt,1:p);
S1=trnN;
ST=CekN;
OUTT=Pn(N+1:Nt,p+1);
Out=Pn(1:N,p+1);
chk_data=M(N+1:Nt,p+1);
for i=1:N
Ath1(i)=max(S1(i,:))
end
tic
fismat=genfis1([trnN,Out],2);
fismat2 = anfis([trnN,Out],fismat,[300,0.000001,0.1,0.9,1.1],[]);
% R=[0.25 0.97 0.25   ]
% Bou=[0 0 0 ; 1 1 1]
% fismat=genfis2(Xin,Xout,R,Bou);
% fismat2 = anfis(trnData,[499,0.0001,0.01,0.9,1.1]) 
OO= evalfis(CekN, fismat2);
toc
PERT=mse(OUTT-OO);
ROOTPERT=norm(OO-OUTT)/sqrt(length(OO));
EET=OO;
ERROR=EET-chk_data;
PER=mse(ERROR);
ROOTPER=norm(EET-chk_data)/sqrt(length(EET));
NMSE=(NT*PER)/(mse(chk_data'-mean(chk_data))*NT);
AVE=(1/NT)*sum( abs(ERROR)./abs(chk_data) )*100;
Corr=corrcoef(EET,chk_data);
    
% 
% ROOTPERT=norm(OO-TESTDAT(:,5))/sqrt(length(OO))
