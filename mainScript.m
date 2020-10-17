% (C) Copyright 2020 CPP lab developpers

%% visual field of view estimator

% This script runs a simple routine that will display a red square on the screen
% that the user can move and rescale till it feels their whole field of view (FOV) on
% the screen.
%
% This can prove useful when the FOV is partly obstructed (like in an fMRI)
% experiment and hard to measure.


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
    
    centerOnScreen = true;
    fov = drawFieldOfVIew(cfg, centerOnScreen);
    cfg.screen.effectiveFieldOfView = fov;
    Screen('flip', cfg.screen.win);
    
    while 1
        
        % Check for experiment abortion from operator
        checkAbort(cfg, cfg.keyboard.keyboard);
        
        % draw rectangle on screen
        centerOnScreen = false;
        drawFieldOfVIew(cfg, centerOnScreen);
        Screen('flip', cfg.screen.win);
        
        % collect response and update FOV value
        getOnlyPress = 1;
        responseEvents = getResponse('check', ...
            cfg.keyboard.responseBox, ...
            cfg, ...
            getOnlyPress);
        
        fov = cfg.screen.effectiveFieldOfView;
        
        if isfield(responseEvents, 'keyName')
            
            for iEvent = 1:size(responseEvents, 1)
                
                switch responseEvents(iEvent).keyName
                    
                    % move right
                    case cfg.keyboard.keyToMoveRight
                        fov([1 3]) = fov([1 3]) + cfg.stepSize;
                        
                    % move left
                    case cfg.keyboard.keyToMoveLeft
                        fov([1 3]) = fov([1 3]) - cfg.stepSize;
                    
                    % move up
                    case cfg.keyboard.keyToMoveUp
                        fov([2 4]) = fov([2 4]) + cfg.stepSize;
                        
                    % move down    
                    case cfg.keyboard.keyToMoveDown
                        fov([2 4]) = fov([2 4]) - cfg.stepSize; 
                        
                    % scale up
                    case cfg.keyboard.keyToScaleUp
                        fov([1 2]) = fov([1 2]) - cfg.stepSize;
                        fov([3 4]) = fov([3 4]) + cfg.stepSize;
                        
                    % scale down
                    case cfg.keyboard.keyToScaleDown
                        fov([1 2]) = fov([1 2]) + cfg.stepSize;
                        fov([3 4]) = fov([3 4]) - cfg.stepSize;
                        
                end

            end
        end
        
        % ensure that the rectangle does not go outside the window
        fov(fov<0) = 0;
        
        if fov(3) > cfg.screen.winWidth
            fov(3) = cfg.screen.winWidth;
        end
        
        if fov(4) > cfg.screen.winHeight
            fov(4) = cfg.screen.winHeight;
        end
        
        % ensures that rectangle values are possible
        % top-left values must be smaller than bottom-right
        if fov(1) > fov(3)
            fov(1) = fov(3) - 5;
        end
        if fov(2) > fov(4)
            fov(2) = fov(4) - 5;
        end

        % reallocat back to cfg for reuse by drawFieldOfVIew
        cfg.screen.effectiveFieldOfView = fov;

    end
    
    getResponse('stop', cfg.keyboard.responseBox);
    getResponse('release', cfg.keyboard.responseBox);
    
    farewellScreen(cfg);
    
    cleanUp();
    
catch
    
    cleanUp();
    psychrethrow(psychlasterror);
    
end
