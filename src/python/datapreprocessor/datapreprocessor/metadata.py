METADATA_COLUMN_KEYS = [
    'type',
    'title',
    'office',
    'collection',
    'date_published',
    'source_url',
]

def convert_metadata_row_to_dict(metadata_row):
    return dict(zip(METADATA_COLUMN_KEYS, metadata_row))