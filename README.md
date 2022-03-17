# Template repository for matlab analysis project

This script runs a simple routine that will display a red square on the screen
that the user can move and rescale till it feels their whole field of view (FOV)
on the screen. This can prove useful when the FOV is partly obstructed (like in
an fMRI) experiment and hard to measure.

![](./images/fov.svg)

## Content

```bash
├── .git
├── .github  # where you put anything github related
│   └── workflows # where you define your github actions
│       └── moxunit.yml # a yaml file that defines a github action
├── lib # where you put the code from external libraries (mathworks website or other github repositories)
│   └── README.md
├── src # where you put your code
│   ├── README.md
│   └── miss_hit.cfg
├── tests # where you put your unit tests
|   ├── README.md
|   └── miss_hit.cfg
├── .travis.yml # where you define the continuous integration done by Travis
├── LICENSE
├── README.md
├── miss_hit.cfg # configuration file for the matlab miss hit linter
└── initEnv.m # a .m file to set up your project (adds the right folder to the path)
```

## How to install and run

Install
```
git clone --recurse-submodules https://github.com/cpp-lln-lab/estimate_visual_FOV.git
```

Set parameters in `setParameters.m`

Run
```
mainScript
```
