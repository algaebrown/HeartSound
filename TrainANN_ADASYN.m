% train neural net
%%originally created: 20160501
% last modified: 20160611


load inputs;
load targets;

[trainInd,valInd,testInd] = dividerand(3038,90,0,10);
inputstest=(inputs(testInd,:))';
targetstest=(targets(testInd,:))';


[inputsADA, targetsADA] = useADASYN(inputs(trainInd,:), targets(trainInd,:));

inputs=[inputs(trainInd,:);inputsADA]';
targets=[targets(trainInd,:);targetsADA]';

t=[];
for a=1:length(targets)
    if targets(a)==1
       t(1:2,a)=[1;0];%[1;0]abnormal(1)
    else
        t(1:2,a)=[0;1];
    end
end

targets=t;

t=[];
for a=1:length(targetstest)
    if targetstest(a)==1
       t(1:2,a)=[1;0];%[1;0]abnormal(1)
    else
        t(1:2,a)=[0;1];
    end
end

targetstest=t;
% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by NPRTOOL
%
% This script assumes these variables are defined:
%
%   cancerInputs - input data.
%   cancerTargets - target data.



% Create a Pattern Recognition Network
hiddenLayerSize = 35;
net = patternnet(hiddenLayerSize);


% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputstest);
errors = gsubtract(targetstest,outputs);
performance = perform(net,targetstest,outputs)

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotconfusion(targets,outputs)
% figure, ploterrhist(errors)

%evaluate performance
Y=net(inputstest);
plotconfusion(targetstest,Y);