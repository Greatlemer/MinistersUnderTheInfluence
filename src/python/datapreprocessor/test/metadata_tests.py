import unittest
from datapreprocessor.metadata import (
    convert_metadata_row_to_dict
)

class ConvertMetadataRowToDictTestCase(unittest.TestCase):

    def test_matches_columns_to_correct_keys(self):

        # This needs to map the column structure set out by the php harvester.
        expected_output = {
            'type': 'Col1',
            'title': 'Col2',
            'office': 'Col3',
            'collection': 'Col4',
            'date_published': 'Col5',
            'source_url': 'Col6',
        }
        metadata_row = ['Col1', 'Col2', 'Col3', 'Col4', 'Col5', 'Col6']

        metadata_dict = convert_metadata_row_to_dict(metadata_row)

        self.assertEqual(expected_output, metadata_dict)