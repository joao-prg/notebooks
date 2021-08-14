from setuptools import (
    find_packages,
    setup,
)

tests_requires = [
    'parameterized>=0.7.4,<1.0',
]

static_tests_requires = [
    'coverage==5.2.1',
    'flake8==3.7.9',
    'mypy==0.740',
    'pydocstyle==4.0.1',
]

code_formatting_requires = ['isort==5.4.2', 'yapf==0.30.0', 'black']

exclude_packages = ['tests*']

VERSION = '0.0.1'

with open('README.md', 'r') as fh:
    long_description = fh.read()


def is_version_valid(version_number: str) -> bool:
    """Validate version number.
    Parameters
    ----------
    version_number : str
        Version number to be validate.
    Returns
    -------
    bool
        True if the format is 0.0.0 or 0.0.0.0, otherwise False
    """
    parts = version_number.split('.')
    return (len(parts) == 3 or len(parts) == 4) and all([p.isdigit() for p in parts])


if not is_version_valid(VERSION):
    RuntimeError("Invalid TAG version, expected format '0.0.0'.")

setup(
    name='notebooks',
    version=VERSION,
    author='João Gonçalves',
    description='Data Science notebooks',
    long_description=long_description,
    long_description_content_type='text/markdown',
    packages=find_packages(exclude=exclude_packages),
    classifiers=['Programming Language :: Python :: 3.7'],
    install_requires=[
        'jupyterlab',
        'jupyterlab-git',
        'jupyterlab_code_formatter',
        'jupyterlab_execute_time',
        'jupyterlab-kite>=2.0.2',
        'jupyter_bokeh',
        'jupyter-dash',
        'jupyterlab-dash',
        'ipympl',
        'ipython-sql',
        'matplotlib',
        'plotly',
        'ipywidgets>=7.6',
        'bokeh',
        'dash',
        'pandas',
        'mlflow',
        'scikit-learn',
    ],
    zip_safe=False,
    python_requires='>=3.7',
    extras_require={
        'tests': tests_requires + static_tests_requires + code_formatting_requires,
    },
    tests_require=tests_requires,
)
