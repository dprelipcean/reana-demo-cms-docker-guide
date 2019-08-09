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
      source /opt/cms/cmsset_default.sh ;\
      scramv1 project CMSSW CMSSW_5_3_32 ;\
      cd CMSSW_5_3_32/src ;\
      eval `scramv1 runtime -sh` ;\
      mkdir WorkDir && cd ./WorkDir && git clone git://github.com/cms-opendata-analyses/$(inputs.repo).git && cd ./$(inputs.repo) ;\
      scram b ;\
      cmsRun demoanalyzer_cfg.py

outputs:
  - id: DoubleMu.root
    type: File
    outputBinding:
      glob: CMSSW_5_3_32/src/WorkDir/$(inputs.repo)/DoubleMu.root
  - id: step1.log
    type: stdout

stdout: step1.log
