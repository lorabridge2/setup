#!/bin/bash
sudo ./install_apt.sh
pip3 install pipenv --user
pipenv install
pipenv run ./install_galaxy.sh
