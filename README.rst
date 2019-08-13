====================================
 REANA example - CMS docker guide
====================================

.. image:: https://img.shields.io/travis/reanahub/reana-demo-cms-reco.svg
   :target: https://travis-ci.org/reanahub/reana-demo-cms-reco

.. image:: https://badges.gitter.im/Join%20Chat.svg
   :target: https://gitter.im/reanahub/reana?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge

.. image:: https://img.shields.io/github/license/reanahub/reana-demo-cms-reco.svg
   :target: https://raw.githubusercontent.com/reanahub/reana-demo-alice-cms-reco/master/LICENSE


About
======
This REANA reproducible analysis example demonstrates how to use the CMS
collaboration specific data analysis framework, and reproduces `this example <http://opendata.cern.ch/docs/cms-guide-docker>`_
on how to run CMS analysis using Docker.

Analysis structure
==================

Making a research data analysis reproducible basically means to provide
"runnable recipes" addressing (1) where is the input data, (2) what software was
used to analyse the data, (3) which computing environments were used to run the
software and (4) which computational workflow steps were taken to run the
analysis. This will permit to instantiate the analysis on the computational
cloud and run the analysis to obtain (5) output results.


1 & 2. Input data and Analysis code
------------------------------------

This example follows the CMS one, but it can be customized to data sets other
than the `DiMuonSpectrum <https://github.com/cms-opendata-analyses/DimuonSpectrum2011>`_.

3. Compute environment
----------------------
In order to be able to rerun the analysis even several years in the future, we
need to "encapsulate the current compute environment", for example to freeze the
software package versions our analysis is using. We shall achieve this by
preparing a `Docker <https://www.docker.com/>`_ container image for our analysis
steps.

This analysis example runs within the `CMSSW <http://cms-sw.github.io/>`_
analysis framework that was packaged for Docker in `cmsopendata
<https://hub.docker.com/u/cmsopendata>`_. The different images corresponds to
data sets taken in different years. Instructions can be found under
`this repo <http://opendata.cern.ch/docs/cms-guide-docker>`_.


4. Analysis workflow
--------------------

First, we have to set up the environment variables accordingly for the CMS
specific analysis. Although this is done in the docker image, `reana` overrides
them and they need to be reset. This is done by copying the
`cms entrypoint.sh script <https://github.com/clelange/cmssw-docker/blob/master/standalone/entrypoint.sh>`_:

.. code-block:: console

      $ source /opt/cms/cmsset_default.sh
      $ scramv1 project CMSSW CMSSW_5_3_32
      $ cd CMSSW_5_3_32/src
      $ eval `scramv1 runtime -sh`


The actual commands that are needed to carry out the analysis in the CMS
specific environment are:

.. code-block:: console

      $ mkdir WorkDir && cd ./WorkDir && git clone git://github.com/cms-opendata-analyses/$(inputs.repo).git && cd ./$(inputs.repo)
      $ scram b
      $ cmsRun demoanalyzer_cfg.py


The analysis is carried out in just one step:

.. figure:: https://raw.githubusercontent.com/dprelipcean/reana-demo-cms-docker-guide/master/docs/workflow.svg
   :alt: workflow.svg
   :align: center


5. Output results
-----------------

The demo will create ROOT file containing the analyzed data.

Local testing
=============

The workflow can be tested locally (i.e. outside reana), but it requires some
minor changes, i.e. removing the commands that set up again the CMS env
variables, namely:

.. code-block:: console

      $ source /opt/cms/cmsset_default.sh
      $ scramv1 project CMSSW CMSSW_5_3_32
      $ cd CMSSW_5_3_32/src
      $ eval `scramv1 runtime -sh`

Running the example on REANA cloud
==================================

We create the workflow files describing the above analysis structure with its
inputs, code, runtime environment, computational workflow steps and expected
outputs.

.. code-block:: console

    $ # create new virtual environment
    $ virtualenv ~/.virtualenvs/myreana
    $ source ~/.virtualenvs/myreana/bin/activate
    $ # install REANA client
    $ pip install reana-client
    $ # connect to some REANA cloud instance
    $ export REANA_SERVER_URL=https://reana.cern.ch/
    $ export REANA_ACCESS_TOKEN=XXXXXXX
    $ # create new workflow
    $ reana-client create -f reana.yaml
    $ export REANA_WORKON=workflow
    $ # start computational workflow
    $ reana-client start
    $ # ... should be finished in about a minute
    $ reana-client status
    $ # list workspace files
    $ reana-client ls
    $ # download output results
    $ reana-client download

Contributors
============

The list of contributors to this REANA example in alphabetical order:

- `Daniel Prelipcean <https://orcid.org/0000-0002-4855-194X>`_
- `Tibor Simko <https://orcid.org/0000-0001-7202-5803>`_
