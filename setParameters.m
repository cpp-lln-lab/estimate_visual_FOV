% (C) Copyright 2020 CPP visual motion localizer developpers

function [cfg] = setParameters()

    % visual field of view estimator

    % Initialize the parameters and general configuration variables
    cfg = struct();
    
    cfg = checkCppPtbCfg(cfg);

    %% Debug mode settings

    cfg.debug.smallWin = false; % To test on a part of the screen, change to 1
    cfg.debug.transpWin = false; % To test with trasparent full size screen

    %% Engine parameters

    cfg.testingDevice = 'mri';
    cfg.eyeTracker.do = false;
    cfg.audio.do = false;
    
    cfg.userIsExperimenter = 1;

    cfg = setMonitor(cfg);

    % Keyboards
    cfg = setKeyboards(cfg);

    cfg.screen.effectiveFieldOfView = [0 0 800 600]; % in pixels
    
    if cfg.userIsExperimenter
        
        % Instruction
        cfg.task.instruction = [ 'Guide the experimenter on how to move the red rectagnle \n', ...
            'until is fully visible on the screen.' ];
        
    else 
                
        % Instruction
        cfg.task.instruction = [ ...
            'Move and scale red rectangle to fill your field of view:\n\n', ...
            '  - Right hand:\n', ...
            '    - index: move right\n', ...
            '    - major: move left\n', ...
            '    - ring finger: move up\n', ...
            '    - little: move down\n\n', ...
            '  - Left hand:\n', ...
            '    - index: scale up\n', ...
            '    - major: scale down\n\n', ...
            'Let us know when you are done.'];
        
    end
    
end

function cfg = setKeyboards(cfg)

    cfg.keyboard.escapeKey = 'ESCAPE';
    cfg.keyboard.responseKey = { ...
                                'r', 'g', 'y', 'b', ...
                                'd', 'n', 'z', 'e', ...
                                'LeftArrow', 'RightArrow', ...
                                'UpArrow', 'DownArrow', ...
                                'p', 'm', ...
                                't', 'space'};

                            
    if cfg.userIsExperimenter             
        
        % move
        cfg.keyboard.keyToMoveUp = 'UpArrow';
        cfg.keyboard.keyToMoveDown = 'DownArrow';
        cfg.keyboard.keyToMoveRight = 'RightArrow';
        cfg.keyboard.keyToMoveLeft = 'LeftArrow';

        %scale
        cfg.keyboard.keyToScaleUp = 'p';
        cfg.keyboard.keyToScaleDown = 'm';
        
    else 
        
        % Right hand (move)

        % index
        cfg.keyboard.keyToMoveUp = 'r';
        % major
        cfg.keyboard.keyToMoveDown = 'g';
        % ring finger
        cfg.keyboard.keyToMoveRight = 'y';
        % little finger
        cfg.keyboard.keyToMoveLeft = 'b';
        
        % Left hand
        
        % index
        cfg.keyboard.keyToScaleUp = 'd';
        % major
        cfg.keyboard.keyToScaleDown = 'n';
        
    end

    cfg.keyboard.keyboard = [];
    cfg.keyboard.responseBox = [];

end

function cfg = setMonitor(cfg)

    % Monitor parameters for PTB
    cfg.color = cppPtbDefaults('color');
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
