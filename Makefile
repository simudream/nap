.PHONY: help clean clean-pyc clean-build list test test-all coverage docs release sdist

help:
	@echo "clean - execute all clean tasks"
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "clean-coverage - remove coverage artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "test-all - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "release - package and upload a release"
	@echo "dist - package"

clean: clean-build clean-pyc clean-coverage

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

clean-coverage:
	rm -f .coverage

lint:
	flake8 nap test

test:
	py.test

test-all:
	tox

coverage:
	py.test --cov nap -v --cov-report term-missing

release: clean coverage test-all
	python scripts/make-release.py

dist: clean
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist
