% %% Character Recognition
% 
% 
% [X,T] = prprob;
% 
% %%
% % graficamos A primera letra del alfabeto
% 
% plotchar(X(:,1))
% 
% %% Creating the Neural Network
% 
% setdemorandstream(pi);
% 
% net1 = feedforwardnet(25);
% view(net1)
% 
% %% Training the first Neural Network
% 
% net1.divideFcn = '';
% net1 = train(net1,X,T);
% 
% %% Training the Second Neural Network
% 
% 
% numNoise = 30;
% Xn = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*0.2,0),1);
% Tn = repmat(T,1,numNoise);
% 
% %%
% % version con ruido de  A.
% 
% figure
% plotchar(Xn(:,1))
% 
% %%
% %  created and trained.
% 
% net2 = feedforwardnet(25);
% net2 = train(net2,Xn,Tn);

%% Testing Both Neural Networks

noiseLevels = 0:.05:1;
numLevels = length(noiseLevels);
percError1 = zeros(1,numLevels);
percError2 = zeros(1,numLevels);
for i = 1:numLevels
  Xtest = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*noiseLevels(i),0),1);
  Y1 = net1(Xtest);
  percError1(i) = sum(sum(abs(Tn-compet(Y1))))/(26*numNoise*2);
  Y2 = net2(Xtest);
  percError2(i) = sum(sum(abs(Tn-compet(Y2))))/(26*numNoise*2);
end

figure
plot(noiseLevels,percError1*100,'--',noiseLevels,percError2*100);
title('Percentage of Recognition Errors');
xlabel('Noise Level');
ylabel('Errors');
legend('Network 1','Network 2','Location','NorthWest')

