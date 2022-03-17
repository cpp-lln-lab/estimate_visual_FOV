function [x, y] = fovCenterRelativeCoord(cfg, fov)
    %
    % returns displacement of the fov center in pixels
    %
    % USAGE::
    %
    %  [x, y] = fovCenterRelativeCoord(cfg, fov)
    %
    % (C) Copyright 2022 CPP lab developpers

    x = (fov(1) + fovWidth(fov) / 2) - cfg.screen.center(1);
    y = (fov(2) + fovHeight(fov) / 2) - cfg.screen.center(2);

end
