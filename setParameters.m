% (C) Copyright 2020 CPP visual motion localizer developpers

function [cfg] = setParameters()

    % visual field of view estimator

    % Initialize the parameters and general configuration variables
    cfg = struct();

    %% Debug mode settings

    cfg.debug.do = true; % To test the script out of the scanner, skip PTB sync
    cfg.debug.smallWin = false; % To test on a part of the screen, change to 1
    cfg.debug.transpWin = true; % To test with trasparent full size screen

    cfg.verbose = 1;

    %% Engine parameters

    cfg.testingDevice = 'mri';
    cfg.eyeTracker.do = false;
    cfg.audio.do = false;

    cfg = setMonitor(cfg);

    % Keyboards
    cfg = setKeyboards(cfg);

    cfg.screen.effectiveFieldOfView = [0 0 800 600]; % in pixels 
    
    % step size to move and scale the field of view rectangle
    cfg.stepSize = 10;

    % Instruction
    cfg.task.instruction = 'Move and scale red rectangle till it fills your field of view.';



end

function cfg = setKeyboards(cfg)
    
    cfg.keyboard.escapeKey = 'ESCAPE';
    cfg.keyboard.responseKey = { ...
                                'r', 'g', 'y', 'b', ...
                                'd', 'n', 'z', 'e', ...
                                't'};
                            
    cfg.keyboard.keyToMoveUp = 'r';
    cfg.keyboard.keyToMoveDown = 'g';
    cfg.keyboard.keyToMoveRight = 'y';
    cfg.keyboard.keyToMoveLeft = 'b';
    
    cfg.keyboard.keyToScaleUp = 'd';
    cfg.keyboard.keyToScaleDown = 'n';    
                            
    cfg.keyboard.keyboard = [];
    cfg.keyboard.responseBox = [];

end

function cfg = setMonitor(cfg)

    % Monitor parameters for PTB
    cfg.color.white = [255 255 255];
    cfg.color.black = [0 0 0];
    cfg.color.red = [255 0 0];
    cfg.color.grey = mean([cfg.color.black; cfg.color.white]);
    cfg.color.background = cfg.color.black;
    cfg.text.color = cfg.color.white;

    % Monitor parameters
    cfg.screen.monitorWidth = 50; % in cm
    cfg.screen.monitorDistance = 40; % distance from the screen in cm

    if strcmpi(cfg.testingDevice, 'mri')
        cfg.screen.monitorWidth = 25;
        cfg.screen.monitorDistance = 95;
    end

end
