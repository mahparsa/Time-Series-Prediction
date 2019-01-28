load mgdata.dat
time = mgdata(:, 1);
ts = mgdata(:, 2);

trn_data = zeros(500, 5);
chk_data = zeros(500, 5);

% prepare training data
load mgdata.dat
time = mgdata(:, 1);
ts = mgdata(:, 2);

trn_data = zeros(250, 5);
chk_data = zeros(700, 5);

% prepare training data
start = 18;
trn_data(:, 1) = ts(start:start+250-1); 
start = start + 30;
trn_data(:, 2) = ts(start:start+250-1); 
start = start + 30;
trn_data(:, 3) = ts(start:start+250-1); 
start = start + 30;
trn_data(:, 4) = ts(start:start+250-1); 


% prepare checking data
start = 358;
chk_data(:, 1) = ts(start:start+700-1); 
start = start + 30;
chk_data(:, 2) = ts(start:start+700-1); 
start = start + 30;
chk_data(:, 3) = ts(start:start+700-1); 
start = start + 30;
chk_data(:, 4) = ts(start:start+700-1); 

n=3
p=n;
DataSize = 950;
TrainSize =250;
TestSize =700;
N=250
Nt=950
U = zeros(N, n+1)
TrainP = trn_data;
%TestP = P(TrainSize+1:DataSize,:);
TestP = chk_data;
M=[TrainP;TestP ];

aa1=M;
U=M
minU=min(U)
maxU=max(U)
for i=1:size(U,2)
    Pn(:,i)=(U(:,i)- minU(i))./(maxU(i)-minU(i))
end  
aan=Pn
trnN=aan(1:N,1:p)
CekN=aan(N+1:Nt,1:p)
OUTT=aan(N+1:Nt,p+1)
Out=aan(1:N,p+1)

fismat=genfis1([trnN,Out],2);
fismat2 = anfis([trnN,Out],fismat,[2000,0.000000001,0.0001,0.9,1.1],[]);

OO= evalfis(CekN, fismat2);
toc
PERT=mse(OUTT-OO);
ROOTPERT=norm(OO-OUTT)/sqrt(length(OO));
ET=OO;
EET =ET.*(maxU(p+1)-minU(p+1))+minU(p+1); 
ERROR=EET-chk_data(:,p+1);
PER=mse(ERROR);
ROOTPER=norm(EET-chk_data(:,p+1))/sqrt(length(EET));
NMSE=(NT*PER)/(mse(chk_data(:,p+1)-mean(chk_data(:,p+1)))*NT);
AVE=(1/NT)*sum( abs(ERROR)./abs(chk_data(:,p+1)) )*100;
Corr=corrcoef(EET,chk_data(:,p+1))
