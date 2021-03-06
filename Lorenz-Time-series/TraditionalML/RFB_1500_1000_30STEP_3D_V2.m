TS = LTS(2900:5500,1);
DataSize = 2500;
TrainSize = 1500;
TestSize = 1000;
for i=61:2560
    M(i-60,:) = [ TS(i-60,1) TS(i-30,1) TS(i,1)];
end

TrainP = M(1:TrainSize,:);
TestP = M(TrainSize+1:DataSize,:);
TestTime = 45.01:0.01:55.00;
N =1500;  %%N show the sample data(training data)
n =2;   %%p show the number of input data 
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
p=2;
trnN=Pn(1:N,1:p);
CekN=Pn(N+1:Nt,1:p);
S1=trnN;
ST=CekN;
OUTT=Pn(N+1:Nt,p+1);
OUT=Pn(1:N,p+1);
tic;
net = newgrnn(S1',OUT');
toc;
TT=sim(net,ST');
plot(TT,'-r');
hold on
plot(OUTT,'-b');
PERT=mse(TT-OUTT');
ROOTPERT=norm(OUTT'-TT)/sqrt(length(TT));
EET=TT;
ERROR=EET-OUTT';
PER=mse(ERROR);
ROOTPER=norm(EET-OUTT')/sqrt(length(EET));
NMSE=(NT*PER)/(mse(OUTT-mean(OUTT))*NT);
AVE=(1/NT)*sum( abs(ERROR)./abs(OUTT') )*100;
Corr=corrcoef(EET,OUTT);
