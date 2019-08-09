====================================
 REANA example - CMS reconstruction
====================================

.. image:: https://img.shields.io/travis/reanahub/reana-demo-cms-reco.svg
   :target: https://travis-ci.org/reanahub/reana-demo-cms-reco

.. image:: https://badges.gitter.im/Join%20Chat.svg
   :target: https://gitter.im/reanahub/reana?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge

.. image:: https://img.shields.io/github/license/reanahub/reana-demo-cms-reco.svg
   :target: https://raw.githubusercontent.com/reanahub/reana-demo-alice-cms-reco/master/LICENSE


About
======
The workflow was adapted from the `CMS docker guide <http://opendata.cern.ch/docs/cms-guide-docker>`_

Analysis structure
==================

Making a research data analysis reproducible basically means to provide
"runnable recipes" addressing (1) where is the input data, (2) what software was
used to analyse the data, (3) which computing environments were used to run the
software and (4) which computational workflow steps were taken to run the
analysis. This will permit to instantiate the analysis on the computational
cloud and run the analysis to obtain (5) output results.


1. Input data
-------------

2. Analysis code
----------------

3. Compute environment
----------------------

4. Analysis workflow
--------------------

5. Output results
-----------------


Local testing
=============

Running the example on REANA cloud
==================================

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
    $ reana-client create -n my-analysis
    $ export REANA_WORKON=my-analysis
    $ # start computational workflow
    $ reana-client start
    $ # ... should be finished in about a minute
    $ reana-client status
    $ # list workspace files
    $ reana-client list
    $ # download output results
    $ reana-client download results/plot.png

Contributors
============

The list of contributors to this REANA example in alphabetical order:

- `Daniel Prelipcean <https://orcid.org/0000-0002-4855-194X>`_
- `Kati Lassila-Perini <>`_
- `Tibor Simko <https://orcid.org/0000-0001-7202-5803>`_
