#!/usr/bin/env python3
import unittest
import pathlib as pl

from objectkeyvalue import get_object


path_file = './objectkeyvalue.py'


class TestCaseBase(unittest.TestCase):
    def assert_is_file(self, path):
        if not pl.Path(path).resolve().is_file():
            raise AssertionError("File does not exist: %s" % str(path))

    def test_is_file(self):
        path = pl.Path(path_file)
        self.assert_is_file(path)

    def test_get_object(self):
        self.assertEqual(get_object("x", '{"x": {"y": {"z": "1"}}}'), {
                         'y': {'z': '1'}}, "Should be {'y': {'z': '1'}}")


if __name__ == '__main__':
    unittest.main()
