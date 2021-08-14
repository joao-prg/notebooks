Getting started
===============

#. make create_environment
#. make install_dependencies
#. brew install node
#. Install code formatter
    * Pycharm
        #. Preferences -> Tools -> External Tools -> Add
        #. Name: Code Formatter Tools
        #. Description: Automatic code formatting using isort and YAPF
        #. Arguments: "$FilePath$"
        #. Add a keymap
#. make install_jupyterlab_extensions
#. `Configure code formatters for JupyterLab <https://jupyterlab-code-formatter.readthedocs.io/en/latest/how-to-use.html>`_
#. `Configure jupyterlab-kite <https://github.com/kiteco/jupyterlab-kite>`_
