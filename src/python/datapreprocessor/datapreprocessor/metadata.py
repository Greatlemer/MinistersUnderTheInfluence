import csv
import os

from csvcleanser import csvcleanser
from csvreader import csvreader
from datanormaliser import datanormaliser


DEFAULT_BASE_PATH = '../../../php/gov-harvester/datafiles'
METADATA_COLUMN_KEYS = [
    'type',
    'title',
    'office',
    'collection',
    'date_published',
    'source_url',
]


def process_metadata_file(filename, error_collection):
    for row in csvreader.read_file(filename):
        metadata_dict = convert_metadata_row_to_dict(row)
        process_file_from_metadata(metadata_dict, error_collection)


def convert_metadata_row_to_dict(metadata_row):
    return dict(zip(METADATA_COLUMN_KEYS, metadata_row))


def process_file_from_metadata(
    metadata_dict, error_collection, base_path=DEFAULT_BASE_PATH
):
    filename = "_".join(metadata_dict['source_url'].split('/')[-2:])
    for row in process_csv_file(filename, error_collection):
        print row


def process_csv_file(filename, error_collection):
    file_info = datanormaliser.extract_info_from_filename(filename)
    current_minister = None
    new_rows = []
    row_index = 0
    for row in csvreader.read_file(filename):
        try:
            row_index += 1
            clean_row_data = csvcleanser.cleanse_row(row)
            if clean_row_data is None:
                # row didn't contain useful data.
                continue
            new_row, current_minister = datanormaliser.normalise_row(
                clean_row_data, file_info['year'], current_minister
            )
            new_row.append(metadata_dict['office'])
            yield new_row
        except Exception, e:
            error_collection.append({
                'filename': filename,
                'row_index': row_index,
                'row_data': row,
                'exception': repr(e),
                'type': 'row_error',
            })