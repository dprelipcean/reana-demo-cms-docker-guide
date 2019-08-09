class: CommandLineTool
cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: cmsopendata/cmssw_5_3_32

baseCommand:
  - /bin/zsh

inputs:
  - id: repo
    type: string

arguments:
  - position: 0
    prefix: '-c'
    valueFrom: |
      pwd && ls ;\
      mkdir WorkDir && cd ./WorkDir && git clone git://github.com/cms-opendata-analyses/$(inputs.repo).git && cd ./$(inputs.repo) ;\
      scram b ;\
      cmsRun demoanalyzer_cfg.py

outputs:
  - id: step1.log
    type: stdout

stdout: step1.log
