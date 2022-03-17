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

%% Experiment

% Safety loop: close the screen if code crashes
try

    %% Init the experiment
    [cfg] = initPTB(cfg);

    % step size to move and scale the field of view rectangle
    cfg.stepSize = floor(cfg.screen.winHeight * 0.05);

    unfold(cfg);

    % Show experiment instruction
    standByScreen(cfg);

    % prepare the KbQueue to collect responses
    getResponse('init', cfg.keyboard.responseBox, cfg);

    getResponse('start', cfg.keyboard.responseBox);

    % draw the field of view rectangle centered on the screen
    % after that it will not be centered anymore.
    centerOnScreen = true;
    fov = drawFieldOfVIew(cfg, centerOnScreen);
    cfg.screen.effectiveFieldOfView = fov;
    Screen('flip', cfg.screen.win);
    centerOnScreen = false;

    keepGoing = true;

    % we let the user update the position of the screen and we let the
    % exerimenter press space when they are done.
    while keepGoing

        % Check for experiment abortion from operator
        checkAbort(cfg, cfg.keyboard.keyboard);

        % draw rectangle on screen
        drawFieldOfVIew(cfg, centerOnScreen);
        Screen('flip', cfg.screen.win);

        % collect response and update FOV value
        responseEvents = getResponse('check', ...
                                     cfg.keyboard.responseBox, ...
                                     cfg);

        [cfg, keepGoing] = updateFov(cfg, responseEvents);

    end

    %% clean up and close
    getResponse('stop', cfg.keyboard.responseBox);
    getResponse('release', cfg.keyboard.responseBox);

    farewellScreen(cfg);

    cleanUp();

    %% Print output to screen

    % in pixels
    fov = cfg.screen.effectiveFieldOfView;

    fprintf(1, ['Field of view in pixel:\n' ...
                ' top left: %i %i\n', ...
                ' bottom right: %i %i\n\n'], ...
            fov(1), fov(2), ...
            fov(3), fov(4));

    fprintf(1, ['Field of view in pixel:\n', ...
                ' width: %i\n', ...
                ' height: %i\n\n'], ...
            fovWidth(fov), ...
            fovHeight(fov));

    % in degrees of visual angles
    cfg.screen = pixToDeg('effectiveFieldOfView', cfg.screen, cfg);
    fovDegVA = cfg.screen.effectiveFieldOfViewDegVA;

    fprintf(1, ['Field of view in degrees of visual angles:\n' ...
                ' top left: %i %i\n', ...
                ' bottom right: %i %i\n\n'], ...
            fovDegVA(1), fovDegVA(2), ...
            fovDegVA(3), fovDegVA(4));

    fprintf(1, [ ...
                'Field of view in degrees of visual angle:\n', ...
                ' width: %i\n', ...
                ' height: %i\n\n'], ...
            fovWidth(fovDegVA), ...
            fovHeight(fovDegVA));

catch

    cleanUp();
    psychrethrow(psychlasterror);

end
