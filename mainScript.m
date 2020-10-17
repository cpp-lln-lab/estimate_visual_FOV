% (C) Copyright 2020 CPP lab developpers

%% visual field of view estimator

% This script runs a simple routine that will display a red square on the screen
% that the user can move and rescale till it feels their whole field of view (FOV) on
% the screen.
%
% This can prove useful when the FOV is partly obstructed (like in an fMRI)
% experiment and hard to measure.

getOnlyPress = 1;

more off;

% Clear all the previous stuff
clc;
if ~ismac
    close all;
    clear Screen;
end

% make sure we got access to all the required functions and inputs
initEnv();

% set and load all the parameters to run the experiment
cfg = setParameters;

%%  Experiment

% Safety loop: close the screen if code crashes
try
    
    %% Init the experiment
    [cfg] = initPTB(cfg);
    
    disp(cfg);
    
    % Show experiment instruction
    standByScreen(cfg);
    
    % prepare the KbQueue to collect responses
    getResponse('init', cfg.keyboard.responseBox, cfg);
    
    getResponse('start', cfg.keyboard.responseBox);
    
    %% For Each Block
    
    while 1

        % Check for experiment abortion from operator
        checkAbort(cfg, cfg.keyboard.keyboard);
        
        fov = drawFieldOfVIew(cfg);
        
        Screen('flip', cfg.screen.win);
        
        % collect the responses and appends to the event structure for
        % saving in the tsv file
        responseEvents = getResponse('check', cfg.keyboard.responseBox, cfg, ...
            getOnlyPress);
        
        
    end
    
    getResponse('stop', cfg.keyboard.responseBox);
    getResponse('release', cfg.keyboard.responseBox);
    
    farewellScreen(cfg);
    
    cleanUp();
    
catch
    
    cleanUp();
    psychrethrow(psychlasterror);
    
end
