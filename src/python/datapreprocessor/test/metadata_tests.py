from mock import mock_open, patch, sentinel
import unittest
from datapreprocessor.metadata import (
    convert_metadata_row_to_dict,
    process_file_from_metadata,
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


class ProcessFileFromMetadataTestCase(unittest.TestCase):

    def setUp(self):
        self.sample_data = {
            'type': 'Col1',
            'title': 'Col2',
            'office': 'Col3',
            'collection': 'Col4',
            'date_published': 'Col5',
            'source_url': 'http://base_url.com/some/url/file_number/filename.ext',
        }

    @patch('datapreprocessor.metadata.csv.reader')
    @patch('datapreprocessor.metadata.open', new_callable=mock_open())
    def test_opens_correct_file_based_on_url(self, mock_open_func, mock_reader):
        mock_reader.return_value = []

        process_file_from_metadata(self.sample_data, base_path='../a/path')

        mock_open_func.assert_called_once_with('../a/path/file_number_filename.ext')