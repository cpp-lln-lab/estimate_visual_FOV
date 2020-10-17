% (C) Copyright 2020 CPP lab developpers

function [cfg, keepGoing] = updateFov(cfg, responseEvents)

    % TODO will check if the space bar has been pressed too.
    % this makes this function do too many things so this could be factored out
    % later
    keepGoing = true;

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

                case 'space'
                    keepGoing = false;

            end

        end
    end

    % ensure that the rectangle does not go outside the window
    fov(fov < 0) = 0;

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
