#!/usr/bin/env python3
import os
from subprocess import getstatusoutput, getoutput


import unittest
import pathlib as pl

from challenge import get_object as go


prg = './challenge.py'

class TestCaseBase(unittest.TestCase):
    def assertIsFile(self, path):
        if not pl.Path(path).resolve().is_file():
            raise AssertionError("File does not exist: %s" % str(path))

    def test(self):
        path = pl.Path(prg)
        self.assertIsFile(path)

    def test_go(self):
        self.assertEqual(go("x", '{"x": {"y": {"z": "1"}}}'), {'y': {'z': '1'}}, "Should be {'y': {'z': '1'}}")



if __name__ == '__main__':
    unittest.main()
 