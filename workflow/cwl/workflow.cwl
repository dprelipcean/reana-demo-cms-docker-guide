#!/usr/bin/env cwl-runner

# Note that if you are working on the analysis development locally, i.e. outside
# of the REANA platform, you can proceed as follows:
#
#   # ToDo: check these local commands
#   $ cd reana-demo-cms-reco
#   $ mkdir cwl-local-run
#   $ cd cwl-local-run
#   $ cp -a ../workflow/cwl/input.yml .
#   $ cwltool --outdir="results" ../workflow/cwl/workflow.cwl ../workflow/cwl/input.yml
#   $ firefox ../results/plot.png


cwlVersion: v1.0
class: Workflow

inputs:
  repo: string

outputs:
  step1.log:
    type: File
    outputSource:
      step1/step1.log

steps:
  step1:
    run: step1.cwl
    in:
      repo: repo
    out: [step1.log]
